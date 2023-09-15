#!/bin/bash

version="1.2.10"
md5="4a621715c73cba3237ae72c04647c53f"
folderName="Logic ${version} (64-bit)"
fileName="${folderName// /+}.zip"
downloadUrl="https://downloads.saleae.com/logic/${version}/${fileName}"

binPath="${folderName}/Logic"
scriptPath="sigrok-util/firmware/saleae-logic16/sigrok-fwextract-saleae-logic16"

echo "Cleaning old files"
rm -rf "$folderName"
rm -f *.zip
rm -f *.bitstream
rm -f *.fw
echo "Downloading Logic ${version} from ${downloadUrl}"
curl "$downloadUrl" -o "$fileName"
echo "Checking md5"
md5sum -c check.md5
if [[ $? != 0 ]]; then
    echo "Check failed! Expected:"
    cat check.md5
    echo "Got:"
    md5sum "$fileName"
    exit 1
fi

echo "Unzipping archive"
unzip "$fileName"

echo "Running extraction script"
python "$scriptPath" "$binPath"


