#!/bin/bash

set -xeu

basedir="${0%/*}"

pushd "${basedir}"

dir=artifacts

prefix='AuthPass-setup-'

filename=$(cat "${dir}"/.stable.map.txt  | grep AuthPass-setup-stable.exe | cut -d' ' -f2)
latest=$(echo "$filename" | sed 's/AuthPass-setup-\(.*\).exe/\1/')

FILENAME="${prefix}${latest}.exe"
PUB_DATE=`date`
split=($(echo $latest | tr '_' '\n'))

BUILDNUMBER=${split[1]}
VERSION_STRING=${split[0]}+${split[1]}

if ! test -f "${dir}/${FILENAME}" ; then
    echo "Unable to find file ${FILENAME}"
    exit 1
fi


cat <<EOF > $dir/appcast.xml
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:sparkle="http://www.andymatuschak.org/xml-namespaces/sparkle">
    <channel>
        <title>AuthPass Appcast</title>
        <description>Most recent updates to AuthPass for Windows</description>
        <language>en</language>
        <item>
            <title>Version $VERSION_STRING</title>
            <sparkle:releaseNotesLink>
                https://raw.githubusercontent.com/authpass/authpass/master/authpass/CHANGELOG.md
            </sparkle:releaseNotesLink>
            <pubDate>${PUB_DATE}</pubDate>
            <enclosure url="https://data.authpass.app/data/artifacts/${FILENAME}"
                sparkle:version="${BUILDNUMBER}"
                sparkle:shortVersionString="${VERSION_STRING}"
                sparkle:os="windows"
                length="0"
                sparkle:installerArguments="/SILENT /SP- /NOICONS"
                       type="application/octet-stream" />
        </item>
    </channel>
</rss>
EOF

