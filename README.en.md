# ArcBlock - Interview Challenge Solution  


![iOS Swift](https://img.shields.io/badge/iOS-Swift-blue)  
A solution to the ArcBlock iOS development interview challenge.  

[Simplified Chinese / 简体中文](README.md)

## 📋 Table of Contents  
- [🧑‍💻Environment](#environment)  
- [🚀 Getting Started](#-getting-started)  

## 🧑‍💻Environment  
- **Operating System:** macOS 14.4  
- **Xcode Version:** 14.0 or later  

## 🚀 Getting Started  

Follow these steps to set up and run the project locally:  

1. **Install Xcode**  
   Download and install [Xcode](https://apps.apple.com/app/xcode/id497799835?mt=12) from the App Store. Ensure your version is **14.0 or newer**.  

2. **Install CocoaPods**  
   ```
   sudo gem install cocoapods
   ```

3. **Clone the Repository**  
   ```bash  
   git clone git@github.com:linleiqin/ArcBlockCoding.git  
   cd ArcBlockCoding  
   git pull  
   git checkout beta  
   pod install
   open ArcBlockCoding.xcworkspace

4. **Setup BASE_URL**
- Add a string value named `BASE_URL` in the project's `Info.plist` file
- Set the value of `BASE_URL` to `https://www.xxxxxxxx.io`


5. **Run the Project**
- Open the project in Xcode.
- Build and run the project on a simulator or a physical device.