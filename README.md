# Tools
一个专门用来存放工具类的代码库，包括自己写的和第三方框架。

## Library
库目录，该目录之外的文件均为 Xcode 自动生成，与工具无关。

### Library/Public
第三方框架库，暂不介绍。

### Library/Private
私有库，自己写的框架均在这里，包括分类和常用类。

目录名         | 目录说明
--------------|----------------------------------------
Foundation    | Foundation分类，包含Foundation类的功能扩展
UIKit         | UIKit分类，包含UIKit类的功能扩展
IPAddress     | 获取当前设备的 IP 地址
Model         | 字典模型转换（似乎有点小bug）
MUAudioPlayer | 流媒体播放器
MUToast       | 仿安卓 Toast 效果
Project       | 项目常用类
Socket        | 基于 NSThread 的 Socket 框架

### Library/Recource
资源库，媒体文件、plist文件、数据库。

目录名  | 目录说明
-------|-------------
Plist  | 存放plist文件