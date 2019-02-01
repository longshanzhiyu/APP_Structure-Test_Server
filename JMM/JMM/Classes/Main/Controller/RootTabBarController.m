//
//  RootTabBarController.m
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import "RootTabBarController.h"

static NSString *const kTabBarSettingFileName = @"TabBarSetting";
static NSString *const kItemClass = @"itemClass";//类名
static NSString *const kItemName = @"itemName";//title
static NSString *const kImageName = @"imageName";//图片名
static NSString *const kSelectImageName = @"selectImageName";//选中图片名

@interface RootTabBarController () <UITabBarControllerDelegate>
@property (nonatomic,strong) NSMutableArray * items;//tabbar root VC
@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    //初始化tabbar
    [self setUpTabBar];
    //添加子控制器
    [self setUpAllChildViewController];
    
    [[UserManager share] addObserver:self forKeyPath:@"user.isFirstOpen" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    BOOL isFirstNew = [[change objectForKey:@"new"] boolValue];
    // 在此处理是否首次登录
    
}

- (void)dealloc {
    [[UserManager share] removeObserver:self forKeyPath:@"user.isFirstOpen"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
}

#pragma mark -
#pragma mark 初始化TabBar
-(void)setUpTabBar{
    //设置背景色 去掉分割线
    [self setValue:[TabBar new] forKey:@"tabBar"];
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    [self.tabBar setBackgroundImage:[UIImage new]];
    //通过这两个参数来调整badge位置
    //    [self.tabBar setTabIconWidth:29];
    //    [self.tabBar setBadgeTop:9];
}

#pragma mark -
#pragma mark 初始化VC
-(void)setUpAllChildViewController
{
    NSString *path = [[NSBundle mainBundle] pathForResource:kTabBarSettingFileName ofType:@"plist"];
    NSData *plistData = [NSData dataWithContentsOfFile:path];
    NSDictionary *dic =[NSDictionary dictionaryWithPlistData:plistData];
    NSArray *arr = [dic objectForKey:@"tabbar"];
    
    if (!ValidArray(arr)) {
        return;
    }
    for (NSDictionary *item in arr) {
        Class cls = NSClassFromString([item objectForKey:kItemClass]);
        BaseViewController *vc =  [[cls alloc]init];
        NSString *title = [item objectForKey:kItemName];
        NSString *imageName = [item objectForKey:kImageName];
        NSString *selectImageName = [item objectForKey:kSelectImageName];
        [self setupChildViewController:vc title:title imageName:imageName seleceImageName:selectImageName];
    }
    self.viewControllers = self.items;
}

-(void)setupChildViewController:(UIViewController*)controller title:(NSString *)title imageName:(NSString *)imageName seleceImageName:(NSString *)selectImageName{
    [controller.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    controller.title = title;
    controller.tabBarItem.title = title;//跟上面一样效果
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //未选中字体颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromHex(0xBDC0CE),NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
    
    //选中字体颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromHex(0x39B1C7),NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateSelected];
    //包装导航控制器
    RTContainerNavigationController *nav = [[RTContainerNavigationController alloc]initWithRootViewController:controller];
    
    [self.items addObject:nav];
    
}


-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //    NSLog(@"选中 %ld",tabBarController.selectedIndex);
    
    
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}

/**<设置小红点*/
-(void)setRedDotWithIndex:(NSInteger)index isShow:(BOOL)isShow{
    if (isShow) {
        [self.tabBar setBadgeStyle:kCustomBadgeStyleRedDot value:0 atIndex:index];
    }else{
        [self.tabBar setBadgeStyle:kCustomBadgeStyleNone value:0 atIndex:index];
    }
    
}

- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.selectedViewController supportedInterfaceOrientations];
}

#pragma mark -
#pragma mark getter
- (NSMutableArray *)items
{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

@end
