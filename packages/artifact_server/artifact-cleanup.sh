#!/bin/bash
#
# artifact-cleanup.sh -- remove old, unreferenced AuthPass release artifacts.
#
# A file in the artifacts directory is DELETED only if all of these hold:
#
#   1. its name looks like a release artifact (known prefix + version + known
#      extension, see artifact-push.php);
#   2. it is older than --age-days (default 60, i.e. ~2 months);
#   3. nothing references it:
#        a. no symlink in the artifacts dir points at it
#           (authpass-latest.msix, authpass-linux-stable.deb, ...),
#        b. no "<prefix>latest<ext>.txt" / "<prefix>stable<ext>.txt" pointer
#           file names its version (these hold e.g. "1.9.12_2098"),
#        c. its file name does not appear verbatim in any scanned text file
#           (.stable.map.txt, appcast.xml, pad.xml, website articles, ...),
#        d. its version (e.g. "1.9.11_2007") does not appear in any scanned
#           text file -- this is what keeps the whole stable.txt release set
#           (release=..., *_files='...-XXX.exe') alive.
#
# Everything else is left alone: symlinks, .txt/.xml/.htaccess, and any file
# that does not parse as an artifact name are never candidates.
#
# Dry run by default -- pass --apply to actually delete.
#
#   ./artifact-cleanup.sh                 # show what would go
#   ./artifact-cleanup.sh --show-kept     # ... and why things are kept
#   ./artifact-cleanup.sh --apply         # delete
#

set -euo pipefail

ARTIFACT_DIR=/home/kahless/public_html/authpass-data/data/artifacts
AGE_DAYS=60
KEEP_NEWEST=0
APPLY=0
SHOW_KEPT=0
REF_SPECS=()

usage() {
    cat <<'EOF'
usage: artifact-cleanup.sh [options]

  -d, --dir DIR           artifacts directory
                          (default: /home/kahless/public_html/authpass-data/data/artifacts)
  -a, --age-days N        only delete artifacts older than N days (default: 60)
  -r, --ref PATH[:DEPTH]  additional file/directory to scan for references.
                          May be repeated. Replaces the defaults, which are:
                            <artifacts>:1        (*.txt, .stable.map.txt, appcast.xml)
                            <artifacts>/..:1     (pad.xml, tmpfile.txt, update_stable.sh)
                            <public_html>/authpass:20   (website articles/docs)
  -k, --keep-newest N     additionally always keep the N newest builds of each
                          artifact family, referenced or not (default: 0 = off)
      --show-kept         also list the old artifacts that are being kept, with
                          the reason
      --apply             actually delete (default is a dry run)
  -h, --help              this text
EOF
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -d|--dir)         ARTIFACT_DIR=$2; shift 2 ;;
        -a|--age-days)    AGE_DAYS=$2; shift 2 ;;
        -r|--ref)         REF_SPECS+=("$2"); shift 2 ;;
        -k|--keep-newest) KEEP_NEWEST=$2; shift 2 ;;
        --show-kept)      SHOW_KEPT=1; shift ;;
        --apply)          APPLY=1; shift ;;
        -h|--help)        usage; exit 0 ;;
        *) echo "unknown argument: $1" >&2; usage >&2; exit 2 ;;
    esac
done

[[ -d $ARTIFACT_DIR ]] || { echo "not a directory: $ARTIFACT_DIR" >&2; exit 1; }
ARTIFACT_DIR=$(cd "$ARTIFACT_DIR" && pwd -P)

if [[ ${#REF_SPECS[@]} -eq 0 ]]; then
    REF_SPECS=(
        "$ARTIFACT_DIR:1"
        "$ARTIFACT_DIR/..:1"
        "$ARTIFACT_DIR/../../../authpass:20"
    )
fi

# Sanity check: bail out if this does not look like the artifacts directory.
if [[ -z $(find "$ARTIFACT_DIR" -maxdepth 1 -type l -name '*latest*' -print -quit) ]]; then
    echo "refusing to run: no *latest* symlink in $ARTIFACT_DIR" >&2
    echo "(wrong directory? use --dir)" >&2
    exit 1
fi

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

# extensions, longest/most specific first
EXTS=(.tar.gz _amd64.snap .snap .apk .deb .exe .msix .zip .gz)

# Splits an artifact file name into AV_PREFIX / AV_VER / AV_EXT.
# Returns 1 if the name does not look like a release artifact.
AV_PREFIX=; AV_VER=; AV_EXT=
artifact_parse() {
    local f=$1 rest= ext
    for ext in "${EXTS[@]}"; do
        if [[ $f == *"$ext" ]]; then
            rest=${f%"$ext"}
            AV_EXT=$ext
            break
        fi
    done
    [[ -n $rest ]] || return 1
    [[ $rest =~ [-_.]([0-9][0-9._+]*)$ ]] || return 1
    AV_VER=${BASH_REMATCH[1]}
    AV_PREFIX=${rest%"$AV_VER"}
    return 0
}

human() {
    awk -v b="$1" 'BEGIN {
        split("B KiB MiB GiB TiB", u, " "); i = 1
        while (b >= 1024 && i < 5) { b /= 1024; i++ }
        printf (i == 1 ? "%d %s\n" : "%.1f %s\n"), b, u[i]
    }'
}

# ---------------------------------------------------------------- references

: >"$tmp/ref_names"
: >"$tmp/ref_versions"

# (a) symlinks in the artifacts dir, plus whatever they finally resolve to
find "$ARTIFACT_DIR" -maxdepth 1 -type l -printf '%l\n' |
    sed 's:.*/::' >>"$tmp/ref_names"
find "$ARTIFACT_DIR" -maxdepth 1 -type l -exec readlink -f {} + 2>/dev/null |
    sed 's:.*/::' >>"$tmp/ref_names"

# (b) "<prefix>latest<ext>.txt" / "<prefix>stable<ext>.txt" pointer files
while IFS= read -r txt; do
    base=${txt##*/}
    target=${base%.txt}
    ver=$(head -n1 "$txt" | tr -d '[:space:]')
    [[ -n $ver ]] || continue
    case "$target" in
        *latest*) printf '%s\n' "${target/latest/$ver}" >>"$tmp/ref_names" ;;
        *stable*) printf '%s\n' "${target/stable/$ver}" >>"$tmp/ref_names" ;;
    esac
done < <(find "$ARTIFACT_DIR" -maxdepth 1 -type f -name '*.txt')

# (c)+(d) scan text files for artifact names and version numbers
: >"$tmp/ref_files"
for spec in "${REF_SPECS[@]}"; do
    path=${spec%:*}
    depth=${spec##*:}
    [[ $depth == "$spec" ]] && depth=20
    [[ -e $path ]] || continue
    if [[ -f $path ]]; then
        printf '%s\n' "$path" >>"$tmp/ref_files"
        continue
    fi
    find "$path" -maxdepth "$depth" -type f -size -4M \
        ! -name '*.apk' ! -name '*.deb' ! -name '*.exe' ! -name '*.msix' \
        ! -name '*.snap' ! -name '*.zip' ! -name '*.gz' ! -name '*.png' \
        ! -name '*.jpg' ! -name '*.jpeg' ! -name '*.gif' ! -name '*.ico' \
        ! -name '*.webp' ! -name '*.woff' ! -name '*.woff2' ! -name '*.ttf' \
        ! -name '*.pdf' ! -name '*.mp4' >>"$tmp/ref_files"
done
sort -u "$tmp/ref_files" -o "$tmp/ref_files"

# ----------------------------------------------------------------- artifacts

find "$ARTIFACT_DIR" -maxdepth 1 -type f -printf '%T@\t%s\t%f\n' >"$tmp/files_meta"

: >"$tmp/candidates"
: >"$tmp/groups"
declare -A F_MTIME F_SIZE F_VER
n_files=0; n_other=0
while IFS=$'\t' read -r mtime size name; do
    n_files=$((n_files + 1))
    if ! artifact_parse "$name"; then
        n_other=$((n_other + 1))
        continue
    fi
    F_MTIME[$name]=${mtime%%.*}
    F_SIZE[$name]=$size
    F_VER[$name]=${AV_VER//+/_}
    printf '%s\n' "$name" >>"$tmp/candidates"
    printf '%s%s\t%s\t%s\n' "$AV_PREFIX" "$AV_EXT" "${mtime%%.*}" "$name" >>"$tmp/groups"
done <"$tmp/files_meta"

if [[ -s $tmp/candidates && -s $tmp/ref_files ]]; then
    xargs -a "$tmp/ref_files" -d '\n' -r \
        grep -oIhF -f "$tmp/candidates" -- >>"$tmp/ref_names" || true
    xargs -a "$tmp/ref_files" -d '\n' -r \
        grep -oIhE -e '[0-9]+\.[0-9]+\.[0-9]+[_+][0-9]+' -- >>"$tmp/ref_versions" || true
fi

declare -A REF_NAME REF_VER KEEP_NEW
while IFS= read -r n; do [[ -n $n ]] && REF_NAME[$n]=1; done <"$tmp/ref_names"
while IFS= read -r v; do [[ -n $v ]] && REF_VER[${v//+/_}]=1; done <"$tmp/ref_versions"

if [[ $KEEP_NEWEST -gt 0 ]]; then
    while IFS= read -r n; do KEEP_NEW[$n]=1; done < <(
        sort -t$'\t' -k1,1 -k2,2nr "$tmp/groups" |
            awk -F'\t' -v n="$KEEP_NEWEST" '
                $1 != prev { prev = $1; c = 0 }
                { if (++c <= n) print $3 }'
    )
fi

# ------------------------------------------------------------- classification

cutoff=$(( $(date +%s) - AGE_DAYS * 86400 ))
: >"$tmp/delete"
: >"$tmp/kept"
n_cand=0; n_new=0; n_ref=0; n_del=0; bytes_del=0; bytes_cand=0

while IFS= read -r name; do
    n_cand=$((n_cand + 1))
    bytes_cand=$((bytes_cand + ${F_SIZE[$name]}))
    if [[ ${F_MTIME[$name]} -gt $cutoff ]]; then
        n_new=$((n_new + 1))
        continue
    fi
    reason=
    if [[ -n ${REF_NAME[$name]:-} ]]; then
        reason="referenced by name"
    elif [[ -n ${REF_VER[${F_VER[$name]}]:-} ]]; then
        reason="version ${F_VER[$name]} referenced"
    elif [[ -n ${KEEP_NEW[$name]:-} ]]; then
        reason="among $KEEP_NEWEST newest of its kind"
    fi
    if [[ -n $reason ]]; then
        n_ref=$((n_ref + 1))
        printf '%s\t%s\n' "$name" "$reason" >>"$tmp/kept"
        continue
    fi
    n_del=$((n_del + 1))
    bytes_del=$((bytes_del + ${F_SIZE[$name]}))
    printf '%s\t%s\n' "${F_SIZE[$name]}" "$name" >>"$tmp/delete"
done <"$tmp/candidates"

# -------------------------------------------------------------------- report

echo "artifacts dir : $ARTIFACT_DIR"
echo "reference set : $(wc -l <"$tmp/ref_files") text files, ${#REF_NAME[@]} names, ${#REF_VER[@]} versions"
echo "age threshold : older than $AGE_DAYS days ($(date -d "@$cutoff" '+%Y-%m-%d' 2>/dev/null || date -r "$cutoff" '+%Y-%m-%d'))"
echo
echo "files in dir  : $n_files ($n_other non-artifact, never touched)"
echo "artifacts     : $n_cand ($(human $bytes_cand))"
echo "  too recent  : $n_new"
echo "  referenced  : $n_ref"
echo "  deletable   : $n_del ($(human $bytes_del))"
echo

if [[ $SHOW_KEPT -eq 1 && -s $tmp/kept ]]; then
    echo "--- kept although old ---"
    sort "$tmp/kept" | awk -F'\t' '{ printf "  %-46s %s\n", $1, $2 }'
    echo
fi

if [[ $n_del -eq 0 ]]; then
    echo "nothing to delete."
    exit 0
fi

if [[ $APPLY -eq 1 ]]; then
    echo "--- deleting ---"
else
    echo "--- would delete ---"
fi
sort -k2,2 "$tmp/delete" | while IFS=$'\t' read -r size name; do
    printf '  %10s  %s\n' "$(human "$size")" "$name"
done

if [[ $APPLY -eq 0 ]]; then
    echo
    echo "dry run -- nothing was deleted. re-run with --apply to free $(human $bytes_del)."
    exit 0
fi

echo
freed=0
while IFS=$'\t' read -r size name; do
    # paranoia: $name comes from `find -printf %f` so it is always a plain
    # basename, but never let anything outside $ARTIFACT_DIR be removed.
    case "$name" in
        ''|.|..|*/*) echo "refusing suspicious entry: '$name'" >&2; continue ;;
    esac
    target=$ARTIFACT_DIR/$name
    if [[ -L $target || ! -f $target ]]; then
        echo "refusing (not a regular file, or a symlink): $target" >&2
        continue
    fi
    if rm -f -- "$target"; then
        freed=$((freed + size))
    else
        echo "failed to delete: $name" >&2
    fi
done <"$tmp/delete"
echo "deleted $n_del files, freed $(human $freed)."
