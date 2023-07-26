(*
Author: Nathan Rightnour (Github: NathanR-85)

This script uploads the selected file in Finder to an AWS S3 bucket. It makes the file publicly accessible and copies the public link to the clipboard.
If a file with the same name already exists in the bucket, the script asks if you want to replace it or add a suffix to make the new file's name unique.

Instructions for personalization:
1. Replace "your_bucket_name" with the name of your AWS S3 bucket.
2. Replace "your_directory_name" with the directory in your bucket where you want the files to be uploaded. If you want to upload files to the root of the bucket, leave it as an empty string (""). Make sure to include a trailing slash ("/") if specifying a directory.
*)

set bucketName to "your_bucket_name"
set directoryName to "your_directory_name"

tell application "Finder"
	set theSelection to the selection
	if theSelection is {} then
		display dialog "No file selected." buttons {"OK"} default button 1
		return
	end if
	set theItem to item 1 of theSelection as alias
	set thePath to POSIX path of theItem
end tell

set awsPath to "s3://" & bucketName & "/" & directoryName
set publicURL to "https://" & bucketName & ".s3.amazonaws.com/" & directoryName

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
do shell script "/usr/local/bin/aws s3api put-object-acl --bucket " & bucketName & " --key \"" & directoryName & fileName & "\" --acl public-read"

set publicURL to publicURL & fileName
set the clipboard to publicURL
