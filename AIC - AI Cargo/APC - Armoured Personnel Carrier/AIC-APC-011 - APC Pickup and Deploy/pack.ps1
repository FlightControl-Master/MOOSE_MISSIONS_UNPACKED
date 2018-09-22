$dir = (Get-Location).Path 
$file = Split-Path $dir -leaf
cd "_unpacked"
. 7z a -r -y -tzip "..\$file.miz" *
cd ..
