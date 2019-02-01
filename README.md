# APP_Structure-Test_Server

此项目中为APP架构搭建的总结

JMM为iOS端APP的基础框架 框架使用了cocoapods工具管理项目 开发语言为OC 里面的UI框架 根部采用了一个导航控制器 解决了突如其来的跳转问题 登录采用单例管理用户数据 登录页面切换采用KVO 通过数据监听的方式解决了页面耦合的问题 有待完善

服务器端采用了perfect框架 开发语言为swift 只是一个简单的服务器支持 仅参考

项目中都删除了依赖的三方库 APP要使用pod install 安装完毕 才能运行 服务端 安装依赖库 参考 perfect.org 官方教程 
