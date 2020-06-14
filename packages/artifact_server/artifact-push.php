<?php
$TOKEN = 'lorem';

/**
 * @param string $message
 */
function fatalError($message) {
    throw new RuntimeException($message);
}

if ($_POST['token'] !== $TOKEN) {
    fatalError('Permission denied. Invalid token ' . $_POST['token']);
}

$filename = $_POST['filename'];
if (!$filename) {
    fatalError('Missing filename.');
}

class ArtifactMatch {
    public $prefix;
    public $version;
    public $extension;

    public function __construct($prefix, $version, $extension) {
        $this->prefix = $prefix;
        $this->version = $version;
        $this->extension = $extension;
    }
}

function isAllowedArtifact($filename) {
    // language=RegExp
    $versionPattern = '[\d._]+';
    $allowedArtifacts = array(
        "(authpass-linux-)($versionPattern)(.tar.gz)",
        "(authpass-sideload-)(\d+)(.apk)",
        "(testartifact-)($versionPattern)(.tar.gz)",
    );


    foreach ($allowedArtifacts as $artifactPattern) {
        $matches = NULL;
        $pattern = "/^$artifactPattern\$/";
//        echo "Matching $pattern against $filename\n";
//        $result = preg_match($pattern, $filename, $matches);
//        echo "Result: $result\n";
//        print_r($matches);
        if (preg_match($pattern, $filename, $matches) === 1) {
            return new ArtifactMatch($matches[1], $matches[2], $matches[3]);
        }
    }
    return null;
}


$artifact = isAllowedArtifact($filename);

if ($artifact === null) {
    fatalError('Invalid artifact name: ' . $filename);
}

$dir = 'artifacts';
$target = $dir . '/' . $filename;
$symlink = $dir . '/' . $artifact->prefix . 'latest' . $artifact->extension;
$versionFile = $dir . '/' . $artifact->prefix . 'latest' . '.txt';

if (file_exists($target)) {
    fatalError('file already exists at ' . $target);
}

if (!move_uploaded_file($_FILES['upload']['tmp_name'], $target)) {
    fatalError('Error moving file.');
}

echo "Linking $target to $symlink";

//symlink($target, $symlink);
exec("ln -sf $filename $symlink");
file_put_contents($versionFile, $artifact->version);

echo 'Done';
