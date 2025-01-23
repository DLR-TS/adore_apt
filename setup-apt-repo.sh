#!/bin/bash

set -e

REPO_NAME="adore-apt-repo"
DEB_PACKAGE_PATH="packages/"
BRANCH="gh-pages"

for cmd in git dpkg-scanpackages gzip; do
    if ! command -v $cmd &>/dev/null; then
        echo "Error: $cmd is not installed. Please install it before running this script."
        exit 1
    fi
done

# Create repository structure
echo "Creating APT repository structure..."
rm -rf "${REPO_NAME}"
mkdir -p $REPO_NAME/{pool/main,dists/stable/main/binary-amd64}

# Copy .deb package
echo "Copying .deb package..."
cp -r "$DEB_PACKAGE_PATH" $REPO_NAME/pool/main/

echo "Generating Packages file..."
cd $REPO_NAME
dpkg-scanpackages pool/main > dists/stable/main/binary-amd64/Packages
gzip -k dists/stable/main/binary-amd64/Packages

echo "Initializing Git repository..."
git init
git checkout -b $BRANCH



echo ""
echo "Done! Now go to your GitHub repository settings and enable GitHub Pages."
echo "Set the source to the '$BRANCH' branch and use the root directory as the publishing source."
echo ""
echo "To use this repository on an Ubuntu system, add the following line to your /etc/apt/sources.list:"
echo "deb [trusted=yes] https://$GITHUB_USERNAME.github.io/$REPO_NAME stable main"

