# Install python3 and required tools
sudo apt update
sudo apt install -y python3 python3-pip python-is-python3 unzip curl

# Download AWS CLI v2 installer
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Unzip AWS CLI installer
unzip awscliv2.zip

# Install AWS CLI
sudo ./aws/install

# Verify AWS CLI installed
aws --version

# Cleanup installer files
rm -rf awscliv2.zip aws
