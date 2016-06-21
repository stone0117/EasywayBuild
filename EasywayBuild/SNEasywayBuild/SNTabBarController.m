//
//  SNTabBarController.m
//  EasywayBuild
//
//  Created by stone on 16/6/21.
//  Copyright © 2016年 stone. All rights reserved.
//


#import "SNTabBarController.h"

@interface SNTabBarController () <SNBottomViewDelegate>

@end

@implementation SNTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //    self.customViewControllers = @[
    //        [[SNViewController alloc] initWithTitle:@"车源" normalIcon:[SNTabBarController imageWithString:@"A3D966"] seletedIcon:[SNTabBarController imageWithString:@"A3D900"]],
    //        [[SNViewController alloc] initWithTitle:@"寻车" normalIcon:[SNTabBarController imageWithString:@"9876AA"] seletedIcon:[SNTabBarController imageWithString:@"987600"]],
    //        [[SNViewController alloc] initWithTitle:@"我的" normalIcon:[SNTabBarController imageWithString:@"FF81AC"] seletedIcon:[SNTabBarController imageWithString:@"FF8100"]]
    //    ];
}
-(void)setFullScreenBack:(BOOL)fullScreenBack{
    _fullScreenBack = fullScreenBack;
}
- (void)setCustomViewControllers:(NSArray<UIViewController *> *)customViewControllers {
    _customViewControllers = customViewControllers;
    [self setupOperation];
}
- (void)setupOperation {
    NSMutableArray * arrM = [NSMutableArray arrayWithCapacity:self.customViewControllers.count];
//    NSArray * colors = @[
//        [UIColor whiteColor],
//        [UIColor greenColor],
//        [UIColor blueColor]
//    ];
    for (int i = 0; i < self.customViewControllers.count; i++) {
        UIViewController * vc = self.customViewControllers[i];
//        vc.view.backgroundColor = colors[i];
        
        SNNavigationController * nav = [[SNNavigationController alloc] initWithRootViewController:vc];

        nav.backImage = self.backImage;
        nav.navigationBackgroundColorString = self.navigationBackgroundColorString;
        nav.titleColorString = self.titleColorString;
        nav.titleFont = self.titleFont;
        
        nav.fullScreenBack = self.fullScreenBack;
        
        [arrM addObject:nav];
    }

    self.viewControllers = arrM; //@[ carResourceNav, findCarViewNav, mineNav, findCarViewNav, mineNav ];

    [self addBottomViewWithControllers:self.customViewControllers];
}
- (void)addBottomViewWithControllers:(NSArray *)customViewControllers {
    NSMutableArray * normalImages = [NSMutableArray arrayWithCapacity:customViewControllers.count];
    NSMutableArray * HighlightImages = [NSMutableArray arrayWithCapacity:customViewControllers.count];
    for (UIViewController * vc in customViewControllers) {
        [normalImages addObject:vc.normalIcon];
        [HighlightImages addObject:vc.seletedIcon];
    }

    SNBottomView * bottomView = [[SNBottomView alloc] initWithFrame:self.tabBar.bounds normalImages:normalImages highlightImages:HighlightImages];

    bottomView.delegate = self;

    // bottomView.frame = self.tabBar.bounds;

    [self.tabBar addSubview:bottomView];
}

#pragma mark - <SNBottomViewDelegate>
- (void)bottomView:(SNBottomView *)bottomView didSelectIndex:(int)index {
    self.selectedIndex = index;
}
/** - viewWillAppear -- 删除系统的tabbar */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.tabBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

      if ([obj isKindOfClass:UIControl.class]) {
          [obj removeFromSuperview];
      }

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

//=========  ============================ stone 🐳 ===========/
#import <objc/runtime.h>

//@implementation NSObject (MJRefresh)
//
//+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2 {
//    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
//}
//
//+ (void)exchangeClassMethod1:(SEL)method1 method2:(SEL)method2 {
//    method_exchangeImplementations(class_getClassMethod(self, method1), class_getClassMethod(self, method2));
//}
//
//@end
@implementation UIViewController (TitleImage)

//=========  ============================ stone ===========/
//- (void)setModel:(id)model{
//
//    objc_setAssociatedObject(self, @selector(model), model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//- (id)model{
//    return objc_getAssociatedObject(self, _cmd);
//}
//========= ============================ stone 🐳 ===========/

- (void)setNormalIcon:(UIImage *)normalIcon {
    objc_setAssociatedObject(self, @selector(normalIcon), normalIcon, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImage *)normalIcon {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setSeletedIcon:(UIImage *)seletedIcon {
    objc_setAssociatedObject(self, @selector(seletedIcon), seletedIcon, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImage *)seletedIcon {
    return objc_getAssociatedObject(self, _cmd);
}
- (instancetype)initWithTitle:(NSString *)title normalIcon:(UIImage *)normalIcon seletedIcon:(UIImage *)seletedIcon {
    
    self = [self init]; // NOT a mistake, see text!
    if (self)
        {
        // init category
        self.navigationItem.title = title;
        self.normalIcon = normalIcon;
        self.seletedIcon = seletedIcon;
        }
    return self;
}

//- (void)setTitle:(NSString *)title normalIcon:(UIImage *)normalIcon seletedIcon:(UIImage *)seletedIcon{
//    
//}

@end


