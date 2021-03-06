<?php

// stored in the authpass-cloudu repository. do not  change on server.
// https://github.com/authpass/authpass-cloud

$TOKEN = '3?okQI/#~L.$lp.G8$gr';

/**
 * @param string $message
 */
function fatalError($message) {
    throw new RuntimeException($message);
}

if ($_POST['token'] !== $TOKEN) {
    fatalError('Permission denied. Invalid token ' . $_POST['token']);
}

if (isset($_POST['metrics'])) {
    $newMetrics = json_decode($_POST['metrics'], true);
    $oldMetrics = json_decode(file_get_contents('metrics.json'), true);
    print_r($newMetrics);
    $metrics = array_replace_recursive($oldMetrics, $newMetrics);
    print_r($metrics);
    file_put_contents('metrics.json', json_encode($metrics));
    echo 'Done';
    exit(0);
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
    $versionPattern = '[\d._\+]+';
    $allowedArtifacts = array(
        "(authpass-linux-)($versionPattern)(.tar.gz)",
        "(testartifact-)($versionPattern)(.tar.gz)",
        "(AuthPassSetup-)($versionPattern)(.exe)",
        "(AuthPass-setup-)($versionPattern)(.exe)",
        "(authpass_)($versionPattern)(_amd64.snap)",
        "(authpass-sideload-)($versionPattern)(.apk)",
        "(authpass-samsungapps-)($versionPattern)(.apk)",
        "(authpass-huawei-)($versionPattern)(.apk)",
        "(authpass-amazon-)($versionPattern)(.apk)",
        "(AuthPass.app-)($versionPattern)(.zip)",
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
$versionFile = $dir . '/' . $artifact->prefix . 'latest' . $artifact->extension . '.txt';

# TODO for now we simply overwrite the file. this sounds a bit strange,
# but allows CI to build in multiple branches the same build.
#if (file_exists($target)) {
#    fatalError('file already exists at ' . $target);
#}

// Check $_FILES['upload']['error'] value.

switch ($_FILES['upload']['error']) {
    case UPLOAD_ERR_OK:
        break;
    case UPLOAD_ERR_NO_FILE:
        throw fatalError('No file sent.');
    case UPLOAD_ERR_INI_SIZE:
    case UPLOAD_ERR_FORM_SIZE:
        throw fatalError('Exceeded filesize limit.');
    default:
        throw fatalError('Unknown errors.' . $_FILES['upload']['error']);
}

if (!move_uploaded_file($_FILES['upload']['tmp_name'], $target)) {
    fatalError('Error moving file.');
}

echo "Linking $target to $symlink";

//symlink($target, $symlink);
exec("ln -sf $filename $symlink");
file_put_contents($versionFile, $artifact->version);

echo 'Done';
