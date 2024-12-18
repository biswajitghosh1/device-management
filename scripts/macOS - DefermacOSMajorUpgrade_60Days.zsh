#This script will defer the macOS upgrade by 60 days and needs to be deployed via Workspace One. Initially this script will be applied to the group of MacBooks if required, simnce this will only temporarily block the updates

#----COPY BELOW THIS LINE------


#!/bin/zsh

outputPath="/Library/Application Support/macOSUpdate/"
outputlog=$outputPath"daycount.txt"
softwareupdatelog=$outputPath"softwareupdate.txt"
DefaultlatestVersion=$(awk -F , '$2>max {max=$2;output=$2}END{print output}' "$softwareupdatelog" | cut -d ' ' -f3)
OSname=$(grep "$DefaultlatestVersion," "$softwareupdatelog" | awk -F ',' 'END{print substr($1,16,19)}')

datediff=$(head -1 "$outputlog")
expireday=$(expr 60 - $datediff)