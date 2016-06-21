//
//  SNTabBarController.h
//  EasywayBuild
//
//  Created by stone on 16/6/21.
//  Copyright © 2016年 stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNBottomView.h"
#import "SNNavigationController.h"
//========= 分类 ============================ stone 🐳 ===========/
@interface UIViewController (TitleImage)

/** normalIcon */
@property (nonatomic,strong) UIImage * normalIcon;

/** seletedIcon */
@property (nonatomic,strong) UIImage * seletedIcon;

- (instancetype)initWithTitle:(NSString *)title normalIcon:(UIImage *)normalIcon seletedIcon:(UIImage *)seletedIcon;

@end

@interface SNTabBarController : UITabBarController
/** viewControllers */
@property (nonatomic,strong) NSArray<UIViewController *> * customViewControllers;

//========= nav 用的 ============================ stone 🐳 ===========/
/** backButton */
@property (nonatomic,strong) UIImage * backImage;

/** colorString 16进制*/
@property (nonatomic,strong) NSString * navigationBackgroundColorString;

/** titleColorString 16进制 */
@property (nonatomic,strong) NSString * titleColorString;

/** UIFont */
@property (nonatomic,strong) UIFont * titleFont;

/** fullScreenBack 全屏滑动返回 是否开启 */
@property (nonatomic,assign) BOOL fullScreenBack;

@end


