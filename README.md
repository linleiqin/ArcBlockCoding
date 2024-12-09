# ArcBlock - 面试题答案

![iOS Swift](https://img.shields.io/badge/iOS-Swift-blue)  
ArcBlock iOS 开发面试题答案

[English / 英文](README.en.md)

## 📋 目录  
- [🧑‍💻 环境](#环境)  
- [🚀 开始使用](#-开始使用)  
- [💼 题目内容](#-题目内容)  
- [答题进度](#答题进度)  
- [TODO](#TODO)  

## 🧑‍💻 环境  
- **操作系统:** macOS 14.4  
- **Xcode 版本:** 14.0 或更高版本  

## 🚀 开始使用  

按照以下步骤在本地设置并运行项目：

1. **安装 Xcode**  
   从 [App Store](https://apps.apple.com/app/xcode/id497799835?mt=12) 下载并安装 [Xcode](https://apps.apple.com/cn/app/xcode/id497799835?mt=12)。确保你的版本是 **14.0 或更新的版本**。

2. **安装 CocoaPods**
   ```
   sudo gem install cocoapods
   ```

3. **克隆仓库**  
   ```bash  
   git clone git@github.com:linleiqin/ArcBlockCoding.git  
   cd ArcBlockCoding  
   git pull  
   git checkout beta  
   pod install
   open ArcBlockCoding.xcworkspace


4. **设置BASE_URL**
- 在项目的 `Info.plist` 文件中添加一个名为 `BASE_URL` 的字符串值
- `BASE_URL`值为 `https://www.xxxxxxxx.io`


5. **运行项目**  
- 在 Xcode 中打开项目
- 在模拟器或物理设备上构建并运行项目。


## 💼 题目内容

- 基于下面提供的 json 数据源，实现一个简易的 “文章列表-文章详情” 应用
- [json 数据源](https://www.arcblock.io/blog/api/blogs?page=1&size=20&locale=zh)
- [对应的官方 Blog 页面](https://www.arcblock.io/blog/?locale=zh)

### 实现建议
- 使用 `Swift` 或者 `SwiftUI` 编写
- `多类型列表项的高度根据内容动态适应，具体外观自由发挥 （需要在你的能力范围内做到最美观，例如列表页如何设计美观？如何处理内容没有图片、1张图片、多张图片在列表页的展示？）
- 详情页面依据不同类型，自由发挥，但审美、可用性、界面流畅，美观，使用体验是我们的评判指标 （例如：为不同内容的详情页采用不同设计，详情页内容非常长可能有多屏长，并且有多段落如何处理？详情页有很多图片或没有图片如何处理美观？屏幕截屏如何显示美观？）
- 考虑性能和可用性（例如：图片是否需要cache？ 没有网络时如何处理？如果列表非常大怎么办？如果图片非常大怎么办？等等）
- 我们只考察在代码里实现了的细节，如果只是一些想法而没有实现不会得分。

### 时间限制
- 3 天内完成。


## 答题进度

- 列表页
1. 列表页展示✅
2. 分页加载✅
3. 过滤条件✅
4. 列表空白占位图展示❌

- 详情页
   数据类型的展示:
1. `paragraph`,`heading`,`image`,`list`✅
2. `tab`,`post-link`,`mention` ❌
3. `other` ❌
4. 使用更美观的字体❌

- 其他
1. 网络层的封装✅
2. 图片缓存，图片压缩✅
3. 颜色主题✅
4. 多语言❌


## TODO
🙏🙏🙏🙏由于时间限制，我实际上只有`不到两天`时间来完成这个题目，目前在职，实在挤不出更多时间完成，且最近3年比较多的时间是从事前端开发（Typescript），在不同的语言间切换需要时间适应。
我从事iOS开发至今已有10+年，但是Swift的占比只有30%，对Swift特性基本了解，很多语法问题需要时间回顾，当需要用Swift会翻翻[Swiftgg](https://gitbook.swiftgg.team/swift)复习。
如果使用的是更熟悉的Objective-C，我相信我可以在2天内完成这个题目。🙏🙏🙏🙏

- 项目结构已尽量规范化，如果时间足够，不同功能的代码应该被不同的framework或library封装，例如网络层、图片缓存、多语言等。
- 封装NSMutableAttributedString，Base类，不同的数据类型继承Base类
