<?php

$dir = 'artifacts';
$map = file_get_contents('artifacts/.stable.map.txt');
$absolute_url = "/data/$dir";

//$file = $_GET['file'];
$file = trim($_SERVER['PATH_INFO'], '/');

$lines = explode("\n", $map);
foreach($lines as $line) {
    $mapping = explode(' ', $line);
    if ($mapping[0] === $file) {
        header("Location: ${absolute_url}/$mapping[1]");
        exit;
    }
}

header('HTTP/1.0 404 Not Found');

echo 'File not found: ' . $file;

//echo $f;

