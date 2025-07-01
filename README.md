# FBX SDK & Python Bindings Installer (Linux)

This is an automated installation script for setting up Autodesk FBX SDK 2020.3.2 and its Python bindings on Linux.  
It also installs the required SIP dependency and builds the `fbx` Python module.

---
# Installation

## ✅ Requirements
  
* Python 3.8 (recommended)
* Ubuntu 20/22 LTS
  
## 📁 Required Files
**Open the script FBX_SDK_Install.sh and customize target root directory (ROOT_DIR) (default: `~/Desktop/TEST`)**  
Download and place the following files in your target root directory:  
[autodesk FBX SDK 202032](https://www.autodesk.com/developer-network/platform-technologies/fbx-sdk-2020-3.2)  
[sip==4.19.3 archive file download](https://sourceforge.net/projects/pyqt/files/sip/sip-4.19.3/)
```
fbx202032_fbxsdk_linux.tar.gz
fbx202032_fbxpythonbindings_linux.tar.gz
sip-4.19.3.tar.gz
```
  
## 🛠️ Usage

```
chmod +x FBX_SDK_Install.sh
./FBX_SDK_Install.sh
```

The script performs:

1. Extraction and installation of FBX SDK
2. Extraction and installation of Python bindings
3. Local installation of SIP 4.19.3 (required to build fbx bindings)
4. System dependency installation (`libxml2-dev`)
5. Building of Python bindings using SIP
6. Makefile patching for proper library linking
7. Compilation and installation of the `fbx.so` module

## ✅ Last Step

3 files will be generated under:
$ROOT_DIR/FBX/FBXPythonBinding/build/Distrib/site-packages/fbx/  

- `sip.so`  
- `FbxCommon.py`  
- `fbxsip.so`

You need to **manually copy** them to your Python environment's `site-packages` directory.  
For example:  
```
~/miniconda/envs/xxx/lib/python3.7/site-packages/sip.so  
~/miniconda/envs/xxx/lib/python3.7/site-packages/FbxCommon.py  
~/miniconda/envs/xxx/lib/python3.7/site-packages/fbxsip.so
```
## ✅ INSTALLATION FINISHED

You are now ready to use the FBX Python module 🎉  
Run the test script to verify the installation:
```python
import sys
sys.path.append('$ROOT_DIR/FBX/FBXPythonBinding/build/Distrib/site-packages/fbx')
import fbx
print("✅ FBX SDK import successful")
```

---

## ⚠️ Notes

* This script is designed for **Linux only**
* All tarballs must be downloaded manually and placed in the root directory
* You must have the appropriate license to use Autodesk FBX SDK

## 📄 License

This script is provided for research and educational purposes only.
Please ensure you are properly licensed to use Autodesk FBX SDK.


