$dir = split-path -parent $MyInvocation.MyCommand.Definition 
cd $dir 
$file = Split-Path $dir -leaf 
Remove-Item .\_unpacked -Force -Recurse 
md "_unpacked" 
cd "_unpacked" 
. 7z x -r -y "..\$file.miz" * 
