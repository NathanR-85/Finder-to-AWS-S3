
# 🚀 Finder to S3 🗄️

This AppleScript uploads the currently selected file in Finder to your AWS S3 bucket. It then sets the file to be **publicly accessible 🟠**, and copies the public URL to your clipboard 📋. 

If a file with the same name already exists in the bucket, the script will ask you if you want to replace it or add a suffix to make the new file's name unique (e.g., filename becomes filename_xxxx 📄).

## 🛠️ Setup 

Before you can use the script, you'll need to have the AWS Command Line Interface (CLI) installed on your Mac. You can do this using the Homebrew package manager. If you don't have Homebrew installed, you can install it first using the following command in Terminal:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

After Homebrew is installed, you can install the AWS CLI using the following command:

```bash
brew install awscli
```

## ⚙️ AWS Configuration

Once the AWS CLI is installed, you'll need to configure it with your AWS credentials. This includes your AWS Access Key ID, Secret Access Key, and a default region. You can do this with the following command:

```bash
aws configure
```

This command will prompt you to enter your AWS Access Key ID, Secret Access Key, Default region name (like us-east-1, ap-south-1), and Default output format (like json).

Please note that the Access Key ID and Secret Access Key are sensitive information and should be kept secure 🔐. Also, be careful with the permissions of the AWS account associated with these keys. For uploading to S3, the account will need the necessary S3 permissions.

## 📄 Usage

To use the script, simply select a file in Finder, then run the script. The script will upload the file to your specified S3 bucket, make it publicly accessible, and copy the public URL to your clipboard.

If a file with the same name already exists in the bucket, a dialog will appear asking if you want to replace the existing file or rename the new file (by adding a suffix).

## ⚠️ Warning

This script makes the uploaded files publicly accessible. Be careful not to upload sensitive files that you do not want to be publicly accessible.
