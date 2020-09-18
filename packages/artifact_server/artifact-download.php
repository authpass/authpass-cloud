<?php

$dir = 'artifacts';
$map = file_get_contents('artifacts/.stable.map.txt');
$absolute_url = "/data/$dir";
$host = "https://data.authpass.app";

//$file = $_GET['file'];
$file = trim($_SERVER['PATH_INFO'], '/');

$fileParts = explode('/', $file);
$shield = false;
if (count($fileParts) > 1 && $fileParts[1] == 'shield') {
    $shield = true;
    $file = $fileParts[0];
}

$fileInfo = array(
    'AuthPass-setup-stable.exe' => array(
        'type' => 'Windows Installer'
    ),
    'authpass-sideload-stable.apk' => array(
        'type' => 'Android'
    ),
    'AuthPass.app-stable.zip' => array(
        'type' => 'MacOS'
    ),
    'authpass-linux-stable.tar.gz' => array(
        'type' => 'Linux Binaries'
    ),
);


function parseMap() {
    $map = file_get_contents('artifacts/.stable.map.txt');
    $lines = explode("\n", $map);
    $versionMap = array();
    foreach($lines as $line) {
        $mapping = explode(' ', $line);
        $filename = $mapping[1];
        if (preg_match('/(\d+\.\d+\.\d+).b?(\d+)/', $filename, $match) !== 1) {
            error_log('Error unable to match pattern for ' . $filename);
            continue;
        }
        $version = $match[1];
        $buildNumber = $match[2];
        $versionMap[$mapping[0]] = array(
            'version' => $version,
            'buildNumber' => $buildNumber,
            'fileName' => $filename,
        );
    }
    return $versionMap;
}

$versionMap = parseMap();

if ($file === '.fosshub') {
    $ret = array();
    $latestVersion = null;
    foreach ($fileInfo as $key => $value) {
        $version = $versionMap[$key];
        $v = $version['version'] . '+' . $version['buildNumber'];
        $ret[] = array(
            'fileUrl' => $host . $absolute_url . '/' . $version['fileName'],
            'fileName' => $version['fileName'],
            'type' => $value['type'],
            'version' => $v,
        );
        if ($latestVersion !== null && $latestVersion !== $v) {
            echo "Error, all stable versions must be the same. $v vs $latestVersion";
            print_r($versionMap);
            exit;
        }
        $latestVersion = $v;
    }
    echo json_encode(array('version' => $latestVersion, 'files' => $ret));
    exit;
}

$version = $versionMap[$file];

if ($version === null) {
    header('HTTP/1.0 404 Not Found');

    echo 'File not found: ' . $file;
    exit;
}

if ($shield) {
    $shieldUrl = 'https://img.shields.io/badge/'.urlencode(str_replace('-', '--', $file)).'-'.urlencode($version['version'].'+'.$version['buildNumber']).'-green';
    header('Location: ' . $shieldUrl);
    exit;
}
header("Location: ${absolute_url}/".$version['fileName']);
exit;


$lines = explode("\n", $map);
foreach($lines as $line) {
    $mapping = explode(' ', $line);
    if ($mapping[0] === $file) {
        $filename = $mapping[1];
        if ($shield) {
            if (preg_match('/(\d+\.\d+\.\d).(\d+)/', $filename, $match) === 1) {
                $file = str_replace('-', '--', $file);
                $shieldUrl = 'https://img.shields.io/badge/'.urlencode($file).'-'.urlencode($match[1].'+'.$match[2]).'-green';
                header('Location: ' . $shieldUrl);
            } else {
                error_log('Error unable to match pattern for ' . $filename);
            }
            exit;
        }
        header("Location: ${absolute_url}/$filename");
        exit;
    }
}

header('HTTP/1.0 404 Not Found');

echo 'File not found: ' . $file;

//echo $f;

