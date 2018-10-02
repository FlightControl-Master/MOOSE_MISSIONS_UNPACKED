$dir = split-path -parent $MyInvocation.MyCommand.Definition
cd $dir
$file = Split-Path $dir -leaf

$dir
$file

cd "_unpacked"
. 7z a -r -y -tzip "..\$file.miz" *
cd ..
