#! /bin/bash

# used to install cockroachdb
DEST_PATH="/usr/local/bin"
VERSION="v19.2.6.linux-amd64"

rm -rf cockroach*
wget -qO- "https://binaries.cockroachdb.com/cockroach-${VERSION}.tgz" | tar  xvz
sudo cp -i "cockroach-${VERSION}/cockroach" "$DEST_PATH" || exit
cockroach --help > /dev/null

if [[ "$?" != "0" ]]; then
    echo "[ERROR] installation failed"
else
    echo "[INFO] cockroachdb installed"
fi


# cleanup
rm -rf cockroach*