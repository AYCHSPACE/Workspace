#!/bin/sh

# Stops script execution if a command has an error
set -e

INSTALL_ONLY=0
# Loop through arguments and process them: https://pretzelhands.com/posts/command-line-flags
for arg in "$@"; do
    case $arg in
        -i|--install) INSTALL_ONLY=1 ; shift ;;
        *) break ;;
    esac
done

if ! hash nteract 2>/dev/null; then
    echo "Installing Nteract. Please wait..."
    cd $RESOURCES_PATH
    wget https://github.com/nteract/nteract/releases/download/v0.14.5/nteract_0.14.5_amd64.deb -O ./nteract.deb
    dpkg -i ./nteract.deb
    rm ./nteract.deb
else
    echo "Nteract is already installed"
fi

# Run
if [ $INSTALL_ONLY = 0 ] ; then
    echo "Starting nteract..."
    echo "nteract is a GUI application. Make sure to run this script only within the VNC Desktop."
    nteract
    sleep 10
fi
