# 🚀 Finder to S3

This AppleScript uploads the currently selected file in Finder to your AWS S3 bucket. It then sets the file to be **publicly accessible**, and copies the public URL to your system clipboard.

If a file with the same name already exists in the S3 folder, the script will ask you if you want to replace it, or make the filename unique when uploading so both versions are kept (e.g., filename.png becomes filename_xxxx.png).

Personally, I use this to upload images that I want to use in emails, but it could be useful for anyone who wants to upload files directly to S3 from Finder with regularity.

> **General tip for using AWS:** avoid including periods in your S3 bucket names if you intend to access the files within them via HTTPS. The presence of periods in bucket names interferes with the subdomain structure and causes issues with the SSL certificate validation process, which can disrupt secure access (HTTPS).

## 🛠️ Setup 

Before you can use the script, you'll need to have the AWS Command Line Interface (CLI) installed on your Mac. You can do this using the Homebrew package manager. If you don't have Homebrew installed, you can install it first using the following command in Terminal:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

After Homebrew is installed, you can install the AWS CLI using the following command:

```bash
brew install awscli
```
You'll need an an AWS API Key — you can Google how to get this. 

### AWS Configuration

Once the AWS CLI is installed, you'll need to configure it with your AWS credentials. This includes your AWS Access Key ID, Secret Access Key, and a default region. You can do this with the following command:

```bash
aws configure
```

You'll be prompted to enter your AWS Access Key ID, Secret Access Key, and preferred region (e.g. us-east-1, ap-south-1). When you reach the prompt for 'Default output format', you can simply press Enter without typing anything to skip this setting.

## 📄 Usage

First, open the script and follow the comment to specify where to upload files: your bucket + folder.

To use the script, simply select a file in Finder, then run the script (I use a hotkey in Keyboard Maestro). The script will upload the file to your specified S3 bucket, make it publicly accessible, and copy the public URL to your clipboard.

If a file with the same name already exists in the bucket, a dialog will appear asking if you want to replace the existing file or rename the new file (by adding a suffix).

## Considerations

- This script makes the uploaded files publicly accessible. Be careful not to upload sensitive files that you do not want to be publicly accessible.
- The script allows overwriting existing files in the S3 bucket.
- The script copies overwrites anything on your system clipboard.
