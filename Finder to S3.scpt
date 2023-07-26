tell application "Finder"
    set theSelection to the selection
    if theSelection is {} then
        display dialog "No file selected." buttons {"OK"} default button 1
        return
    end if
    set theItem to item 1 of theSelection as alias
    set thePath to POSIX path of theItem
end tell

set bucketName to "your_bucket_name_here"
set awsPath to "s3://" & bucketName & "/your_directory_here/"
set publicURL to "https://" & bucketName & ".s3.amazonaws.com/your_directory_here/"

set quotedPath to quoted form of thePath

set fileName to do shell script "basename " & quotedPath

set allFiles to do shell script "/usr/local/bin/aws s3 ls " & awsPath

if allFiles contains fileName then
    display dialog "File already exists. Replace it?" buttons {"Yes", "Keep both"} default button 2
    if the button returned of the result is "Keep both" then
        set randomNumber to random number from 1000 to 9999
        set nameWithoutExtension to do shell script "basename " & quotedPath & " | cut -d. -f1"
        set extension to do shell script "basename " & quotedPath & " | cut -d. -f2"
        set fileName to nameWithoutExtension & "_" & randomNumber & "." & extension
    end if
end if

set newFilePath to awsPath & fileName
set quotedNewFilePath to quoted form of newFilePath

do shell script "/usr/local/bin/aws s3 cp " & quotedPath & " " & quotedNewFilePath
do shell script "/usr/local/bin/aws s3api put-object-acl --bucket " & bucketName & " --key \"your_directory_here/" & fileName & "\" --acl public-read"

set publicURL to publicURL & fileName
set the clipboard to publicURL
