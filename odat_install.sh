#!/bin/bash

# Update and install system dependencies
echo "Updating package lists and installing required packages..."
sudo apt update && sudo apt install -y git libaio-dev alien build-essential python3-dev libssl-dev libaio1 python3-venv

# Clone the ODAT repository
echo "Cloning ODAT repository..."
git clone https://github.com/quentinhardy/odat.git

# Navigate to the ODAT directory
cd odat || {
	echo "Failed to navigate to ODAT directory"
	exit 1
}

# Create a Python virtual environment
echo "Creating Python virtual environment..."
python3 -m venv odat_env

# Activate the virtual environment
echo "Activating virtual environment..."
source odat_env/bin/activate

# Install required Python packages (cx_Oracle, pycryptodome, passlib, scapy)
echo "Installing Python dependencies inside the virtual environment..."
pip install cx_Oracle pycryptodome passlib scapy

# Manually install libnmap from GitHub
echo "Cloning and installing libnmap..."
git clone https://github.com/savon-noir/python-libnmap.git
cd python-libnmap
pip install .

# Go back to the ODAT directory
cd ..

# Verify installation
echo "Verifying ODAT installation..."
python3 odat.py --help

echo "ODAT installation completed."

# Deactivate the virtual environment
deactivate
