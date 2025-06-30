#!/bin/bash

set -e  # Exit on error
set -x  # Print executed commands

# Root directory and Conda path (modify as needed)
ROOT_DIR=~/Desktop/TEST
FBX_VERSION=fbx202032

# Search for local archives
SDK_TAR=$(find "$ROOT_DIR" -name "${FBX_VERSION}_fbxsdk_linux.tar.gz" | head -n 1)
BINDING_TAR=$(find "$ROOT_DIR" -name "${FBX_VERSION}_fbxpythonbindings_linux.tar.gz" | head -n 1)

if [[ ! -f "$SDK_TAR" ]]; then
    echo "❌ FBX SDK archive not found: ${FBX_VERSION}_fbxsdk_linux.tar.gz"
    exit 1
fi

if [[ ! -f "$BINDING_TAR" ]]; then
    echo "❌ FBX Python Bindings archive not found: ${FBX_VERSION}_fbxpythonbindings_linux.tar.gz"
    exit 1
fi

# === 1. Extract FBX SDK ===
mkdir -p $ROOT_DIR/FBX/FBXSDK
cd $ROOT_DIR/FBX/FBXSDK

tar -xzf "$SDK_TAR"
chmod +x ${FBX_VERSION}_fbxsdk_linux
./${FBX_VERSION}_fbxsdk_linux

export FBXSDK_ROOT=$ROOT_DIR/FBX/FBXSDK/

# === 2. Extract FBX Python Bindings ===
cd $ROOT_DIR/FBX
mkdir -p FBXPythonBinding
cd FBXPythonBinding

tar -xzf "$BINDING_TAR"
chmod +x ${FBX_VERSION}_fbxpythonbindings_linux
./${FBX_VERSION}_fbxpythonbindings_linux

# === 3. Install SIP 4.19.3 (from local archive) ===
cd $ROOT_DIR/FBX
mkdir -p sip
cd sip

# Locate local SIP archive
SIP_TAR=$(find "$ROOT_DIR" -name "sip-4.19.3.tar.gz" | head -n 1)

if [[ ! -f "$SIP_TAR" ]]; then
    echo "❌ SIP archive not found: sip-4.19.3.tar.gz. Please place it under $ROOT_DIR/FBX/sip/"
    exit 1
fi

# Extract and install SIP
tar -xzf "$SIP_TAR"
cd sip-4.19.3
python configure.py
make -j$(nproc)
sudo make install

export SIP_ROOT=$ROOT_DIR/FBX/sip/sip-4.19.3

# === 4. Install dependencies ===
sudo apt-get update
sudo apt-get install -y libxml2-dev

# === 5. Build Python Bindings ===
FBXSDK_ROOT="${FBXSDK_ROOT%/}"
cd $ROOT_DIR/FBX/FBXPythonBinding/
python PythonBindings.py Python3_x64 buildsip

# === 6. Modify Makefile LIBS paths ===
MAKEFILE=$ROOT_DIR/FBX/FBXPythonBinding/build/Python38_x64/Makefile
sed -i "s|^LIBS = .*|LIBS = -L${FBXSDK_ROOT}/lib/gcc/x64/release ${FBXSDK_ROOT}/lib/gcc/x64/release/libfbxsdk.a -lz -lxml2|" $MAKEFILE

# === 7. Compile and install ===
cd $ROOT_DIR/FBX/FBXPythonBinding/build/Python38_x64/
make clean
make -j$(nproc)
sudo make install

cp -v fbx.so $ROOT_DIR/FBX/FBXPythonBinding/build/Distrib/site-packages/fbx/fbx.so

