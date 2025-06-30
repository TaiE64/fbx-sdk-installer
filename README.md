# fbx-sdk-installer
Automated installer for Autodesk FBX SDK 2020.3.2 and Python bindings on Linux.

```markdown
# FBX SDK & Python Bindings Installer (Linux)

This is an automated installation script for setting up Autodesk FBX SDK 2020.3.2 and its Python bindings on Linux. It also installs the required SIP dependency and builds the `fbx` Python module.

## 📦 Features

- Extracts and installs the FBX SDK  
- Installs Python bindings  
- Installs SIP 4.19.3 from a local archive  
- Builds and installs the `fbx` Python module  
- Supports Python 3.8 (can be modified for other versions)

## 📁 Required Files

Place the following files in your target root directory (default: `~/Desktop/TEST`):

```

fbx202032\_fbxsdk\_linux.tar.gz
fbx202032\_fbxpythonbindings\_linux.tar.gz
sip-4.19.3.tar.gz

````

## 🛠️ Usage

```bash
chmod +x FBX_SDK_Install.sh
./FBX_SDK_Install.sh
````

The default installation path is:

```
~/Desktop/TEST/FBX
```

The script performs:

1. Extraction and installation of FBX SDK
2. Extraction and installation of Python bindings
3. Local installation of SIP 4.19.3 (required to build fbx bindings)
4. System dependency installation (`libxml2-dev`)
5. Building of Python bindings using SIP
6. Makefile patching for proper library linking
7. Compilation and installation of the `fbx.so` module

## ✅ Requirements

* Python 3.8 (recommended)
* `sudo` access
* Linux system
* Required packages: `build-essential`, `libxml2-dev`

## 🧩 Environment Variables

The script will export the following:

```bash
export FBXSDK_ROOT=~/Desktop/TEST/FBX/FBXSDK/
export SIP_ROOT=~/Desktop/TEST/FBX/sip/sip-4.19.3
```

## 🔎 Verification

After installation, test the Python module:

```python
import fbx
```

## ⚠️ Notes

* This script is designed for **Linux only**
* All tarballs must be downloaded manually and placed in the root directory
* You must have the appropriate license to use Autodesk FBX SDK

## 📄 License

This script is provided for research and educational purposes only.
Please ensure you are properly licensed to use Autodesk FBX SDK.

```

如果你有其他模块想要在 README 中展示（比如效果图、执行截图、模块结构等），我也可以继续帮你补充！
```
