//
//  SNNavigationController.m
//  EasywayBuild
//
//  Created by stone on 16/6/21.
//  Copyright © 2016年 stone. All rights reserved.
//

#import "SNNavigationController.h"

#import <objc/runtime.h>

//=****** add class ****************** stone ***
@interface SNBackButton : UIButton

@end

@implementation SNBackButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect {

    return CGRectMake(contentRect.origin.x - 8, contentRect.origin.y, contentRect.size.width, contentRect.size.height);
}

@end
//=************************ stone ***

@interface SNNavigationController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@property(nonatomic, strong) id popDelegate;

@end

@implementation SNNavigationController

// 加载类的时候调用
// 当程序一启动的时候就会调用
+ (void)load {
    //    NSLog(@"%s",__func__);
}

// 当前类或者他的子类第一次使用的时候才会调用
+ (void)initialize {

    //    UINavigationBar * bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[ self.class ]];

    //    UIImage * image = [SNNavigationController imageWithString:@"0A5BD4"];
    //    [bar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];

    // 设置导航条标题颜色
    //    NSMutableDictionary * titleAttribute = [NSMutableDictionary dictionary];
    //    titleAttribute[NSForegroundColorAttributeName] = [UIColor whiteColor];
    //    titleAttribute[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    //    [bar setTitleTextAttributes:titleAttribute];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"222");
    UINavigationBar * bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[ self.class ]];

    NSString * navigationBackgroundColorString = self.navigationBackgroundColorString != nil ? self.navigationBackgroundColorString : @"F8F8F8";
    UIImage * image = [SNNavigationController imageWithString:navigationBackgroundColorString];
    [bar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];

    NSMutableDictionary * titleAttribute = [NSMutableDictionary dictionary];
    titleAttribute[NSForegroundColorAttributeName] = self.titleColorString == nil ? [UIColor blackColor] : [SNNavigationController colorWithString:self.titleColorString];
    titleAttribute[NSFontAttributeName] = self.titleFont == nil ? [UIFont boldSystemFontOfSize:20] : self.titleFont;
    [bar setTitleTextAttributes:titleAttribute];
}
- (void)setFullScreenBack:(BOOL)fullScreenBack {
    _fullScreenBack = fullScreenBack;

    NSLog(@"%d",fullScreenBack);
    if (self.fullScreenBack) {

        // 防止手势冲突 (终止系统手势.)
        self.interactivePopGestureRecognizer.enabled = NO;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

        //这里是会报警告的代码
        // handleNavigationTransition: 系统私有api
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];

#pragma clang diagnostic pop

        pan.delegate = self;

        [self.view addGestureRecognizer:pan];
    } else {
        self.popDelegate = self.interactivePopGestureRecognizer.delegate;

        self.delegate = self;
    }
}
//=========  ============================ stone 🐳 ===========/
#pragma mark - 导航控制器的代理方法
// 完全展示完调用
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 如果展示的控制器是根控制器，就还原pop手势代理
    if (viewController == [self.viewControllers firstObject]) {

        self.interactivePopGestureRecognizer.delegate = self.popDelegate;
    }
}
//=========  ============================ stone 🐳 ===========/

//- (NSArray *)getPropertyNames:(NSString *)string {
//    // 遍历模型中属性
//    unsigned int count = 0;
//    // 取出模型中所有属性
//    Ivar * ivars = class_copyIvarList(NSClassFromString(string), &count);
//    
//    NSMutableArray * propertyNameList = [NSMutableArray array];
//    // 遍历模型中所有属性
//    for (int i = 0; i < count; i++) {
//        // 取出属性
//        Ivar ivar = ivars[i];
//        // 获取属性名称（加下划线的属性名称）
//        NSString * ivarName = @(ivar_getName(ivar));
//        // 截取属性名称（取出下划线的属性名称）
//        ivarName = [ivarName substringFromIndex:1];
//        
//        //        NSLog(@"%@",ivarName);
//        [propertyNameList addObject:ivarName];
//    }
//    return propertyNameList;
//}

//=========  ============================ stone 🐳 ===========/
#pragma mark - 手势代理方法 <UIGestureRecognizerDelegate>
// 是否开始触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    // 判断下当前控制器是否是跟控制器
    if (self.viewControllers.count <= 1) {
        return NO;
    }
    
//    NSLog(@"%@",[self getPropertyNames:@"UINavigationController"]);
    
    if ([[self valueForKey:@"_isTransitioning"] boolValue]) {
        
        return NO;
    }

    return YES;
    
}

// self -> 导航控制器
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if (self.viewControllers.count != 0) { // 非跟控制器hi
        viewController.hidesBottomBarWhenPushed = YES;

        // 设置导航条左边按钮的内容,把系统的返回按钮给覆盖,导航控制器的滑动返回功能就没有了
        //        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Action_backward_white"]  style:UIBarButtonItemStylePlain target:self action:@selector(back)];

        if (self.backImage != nil) {
            SNBackButton * backBtn = [SNBackButton buttonWithType:UIButtonTypeCustom];

            backBtn.bounds = CGRectMake(0, 0, 13, 21);

            [backBtn setBackgroundImage:self.backImage forState:UIControlStateNormal];

            [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];

            viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        }

        if (self.fullScreenBack == NO) {
            // 就有滑动返回功能
            self.interactivePopGestureRecognizer.delegate = nil;
        }
    }

    [super pushViewController:viewController animated:animated];
}
/** popViewController 处理 */
- (void)back {

    [self popViewControllerAnimated:YES];
}

//========= tool ============================ stone 🐳 ===========/
/** 16进制(字符串形式) 返回 图片 */
+ (UIImage *)imageWithString:(NSString *)string {

    return [self imageWithColor:[self colorWithString:string]];
}
/** 16进制返回颜色 */
+ (UIColor *)colorWithString:(NSString *)string {
    CGFloat alpha = 1.0f;
    NSNumber * red = @0.0;
    NSNumber * green = @0.0;
    NSNumber * blue = @0.0;

    NSMutableArray<NSNumber *> * colors = [NSMutableArray arrayWithArray:@[ red, green, blue ]];

    unsigned hexComponent;
    NSString * colorString = [string uppercaseString];
    NSLog(@"%ld", colors.count);
    for (int i = 0; i < colors.count; i++) {
        NSString * substring = [colorString substringWithRange:NSMakeRange(i * 2, 2)];

        [[NSScanner scannerWithString:substring] scanHexInt:&hexComponent];

        NSNumber * temp = colors[i];
        temp = @(hexComponent / 255.0);
        colors[i] = temp;
    }

    return [UIColor colorWithRed:[colors[0] floatValue] green:[colors[1] floatValue] blue:[colors[2] floatValue] alpha:alpha];
}
/** 颜色 返回 图片 */
+ (UIImage *)imageWithColor:(UIColor *)color {

    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}
@end

//========= UIColor 分类 ============================ stone 🐳 ===========/
@implementation UIColor (HexString)
//========= tool ============================ stone 🐳 ===========/
/** 16进制(字符串形式) 返回 图片 */
+ (UIImage *)imageWithString:(NSString *)string {

    return [self imageWithColor:[self colorWithString:string]];
}
/** 16进制返回颜色 */
+ (UIColor *)colorWithString:(NSString *)string {
    CGFloat alpha = 1.0f;
    NSNumber * red = @0.0;
    NSNumber * green = @0.0;
    NSNumber * blue = @0.0;

    NSMutableArray<NSNumber *> * colors = [NSMutableArray arrayWithArray:@[ red, green, blue ]];

    unsigned hexComponent;
    NSString * colorString = [string uppercaseString];
    NSLog(@"%ld", colors.count);
    for (int i = 0; i < colors.count; i++) {
        NSString * substring = [colorString substringWithRange:NSMakeRange(i * 2, 2)];

        [[NSScanner scannerWithString:substring] scanHexInt:&hexComponent];

        NSNumber * temp = colors[i];
        temp = @(hexComponent / 255.0);
        colors[i] = temp;
    }

    return [UIColor colorWithRed:[colors[0] floatValue] green:[colors[1] floatValue] blue:[colors[2] floatValue] alpha:alpha];
}
/** 颜色 返回 图片 */
+ (UIImage *)imageWithColor:(UIColor *)color {

    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}
@end
