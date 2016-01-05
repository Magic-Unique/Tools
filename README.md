# Tools
一个专门用来存放工具类的代码库，包括自己写的和第三方框架。

## Library
库目录，该目录之外的文件均为 Xcode 自动生成，与工具无关。

## Library/Private
私有库，自己写的框架均在这里，包括分类和常用类。

## Library/Private/Foundation
Foundation 框架分类, 包含

Class    | Content
---------|-----------------------------------------------------------------
NSData   | MD5校验
NSDate   | 快速计算近期时间
NSLog    | 格式化 JSON 输出, 包含缩进, 字符串用双引号括起来
NSString | 字符串加解密算法, 字符串特定场合(手机号, 邮箱)算法, emoji获取, 二维码转换

## Library/Private/UIKit
UIKit 框架分类, 包含

Class           | Content
----------------|-----------------------------------------------------------------
UIBarButtonItem | 快速创建 BarButtonItem
UIButton        | 对 Button 不同状态的值做快速读写
UIColor         | 取 RGBA, HSBA 通道值, 取渐变色, 取随机色
UIImage         | 创建单色图片, 修改尺寸(自由伸缩, 比例伸缩, 外切, 内切)
UINavigationBar | 导航栏透明框架
UIView          | 布局框架

## Library/Private/IPAddress
IP 地址类

```
+ (NSArray<NSString *> *)localIPAddress;//获取所有IP地址

+ (NSArray<NSString *> *)localWiFiIPAddress;//获取WiFi地址

+ (NSArray<NSString *> *)localGPRSIPAddress;//获取移动数据地址

+ (NSArray<NSString *> *)localLANIPAddress;//获取广域网地址

+ (NSArray<NSString *> *)localWANIPAddress;//获取局域网地址
```

## Library/Private/Model
字典模型转换

##### 字典数组转模型

将一个任意结构的字典和数组组成的结构, 转为模型.

如果字典中存在某一key对应的value为数组, 且该数组中全为字典, 若是希望该数组中的字典全部转为某一子模型XXX, 则往guide添加key对应XXX

如果模型中一个属性名被迫取别名(比如字典中存在description, 但是模型中只能取名为desc), 则往guide添加Name映射 description=>desc

##### 模型转字典

将一个任意的模型转为字典与数组的结构

如果模型中的某一属性想转为别的名字, 如上述的desc与description的反方向, 则同样往guide添加Name映射 description=>desc

##### WARING

谨慎使用二维数组转模型, 如[[...], [...], [...]]

## Library/Private/MUAudioPlayer
基于 NSURLSession 和 NSMutableData 的流媒体播放器

## Library/Private/MUBottomPopView
底部弹出菜单, 已封装的菜单

Class                     | Content
--------------------------|--------------------------------------------------------
MUBottomPopView           | 基类, 封装 delegate 和 block 回传菜单结果, 4种动画效果
MUBottomPopDatePickerView | 日期选择器, 从底部弹出一个日期选择器 (常用于个人信息的生日修改)
MUBottomPopCityPickerView | 城市选择器, 同上, 支持 3 级地区的定制
MUBottomPopPickerView     | 标题选择器, 传入标题数组自动封装 PickerView 并回传一个选择下标

## Library/Private/MUCirculateRoll
循环滚动条

## Library/Private/MUFirstTime
第一次运行

## Library/Private/MUGuideView
新手指南视图

## Library/Private/MUToast
仿照安卓 Toast 效果, 功能类似 MBProgressHUD

## Library/Private/Project/Welcome
欢迎界面

## Library/Private/Runtime
Runtime 基础框架

## Library/Private/Socket
基于 NSThread 的 Socket 框架

Class                  | Content
-----------------------|--------------------
TCPAsyncServer(Client) | TCP异步服务器(客户端)
TCPSyncServer(Client)  | TCP同步服务器(客户端)
UDPAsyncSocket         | UDP异步数据报
UDPSyncSocket          | UDP同步数据报



### Library/Recource
资源库，媒体文件、plist文件、数据库。

目录名  | 目录说明
-------|-------------
Plist  | 存放plist文件