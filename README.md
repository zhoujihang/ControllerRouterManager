# ControllerRouterManager
以tabbarcontroller＋navigationcontroller为层次结构建立的app，将各个页面间的层次关系解耦，实现像网页一样随意跳转的功能

#### 核心逻辑类：
  
1. RouterRegisterManager 自定义 页面名称 与 controller类 的对应关系。  
2. RouterManager 负责具体的跳转逻辑与合法性判断

#### 跳转模型：  

RouterInfoModel，json格式如下，描述了详细的跳转路径，与路径所需参数

	{
    "jump": [
             {
             "path": "OrderPage"
             },
             {
             "path": "OA"
             },
             {
             "path": "OB",
             "parameters": {
             "pID": "10033781",
             "pName": "AYB_RCBJ"
             }
             },
             {
             "path": "Web",
             "parameters": {
                 "url": "https://www.baidu.com/",
                 "title" : "百度"
                 }
             }
             ]
	}
	
#### 跳转节点合法性校验

目前校验2点：  

  1. 是否需要登录
  2. 是否传入必需参数
  
需要校验的controller实现如下协议即可

	@protocol RoutableDelegate <NSObject>
	// 如果路由跳转时需要参数则实现该方法
	@optional
	// 给定参数的初始化方法
	- (instancetype)initWithRoutableParameters:(NSDictionary *)dic;
	// 路由页面自己给出是否需要登录，不实现则认为不需要登录
	+ (BOOL)isNeedLogin;
	// 校验路由参数是否合法
	+ (BOOL)validateRoutableParameters:(NSDictionary *)dic;
	@end

