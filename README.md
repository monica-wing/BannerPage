# BannerPage

How to start
--

**安装CocoaPods**

CocoaPods安装及使用指南可参考[唐巧Blog](http://blog.devtang.com/blog/2014/05/25/use-cocoapod-to-manage-ios-lib-dependency/?utm_source=tuicool&utm_medium=referral)

如果觉得烦的话，打开命令行依次输入下列命令，回车执行

`gem sources --remove https://rubygems.org/`

`gem sources -a https://ruby.taobao.org/`

`sudo gem install cocoapods`需要输入计算机密码

`pod repo add master https://gitcafe.com/akuandev/Specs.git`

`pod repo update`

依次执行完毕，CocoaPods完成

安装项目依赖
-
终端定位到项目目录，运行

`pod install`

等待完成即可

打开项目
-
双击BannerPage.xcworkspace(白色图标)打开项目
