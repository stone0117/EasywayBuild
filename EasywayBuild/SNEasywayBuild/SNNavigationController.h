//
//  SNNavigationController.h
//  EasywayBuild
//
//  Created by stone on 16/6/21.
//  Copyright © 2016年 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNNavigationController : UINavigationController

/** backButton */
@property (nonatomic,strong) UIImage * backImage;

/** colorString 16进制*/
@property (nonatomic,strong) NSString * navigationBackgroundColorString;

/** titleColorString 16进制 */
@property (nonatomic,strong) NSString * titleColorString;

/** UIFont */
@property (nonatomic,strong) UIFont * titleFont;

/** fullScreenBack */
@property (nonatomic,assign) BOOL fullScreenBack;

@end
//========= UIColor 分类 ============================ stone 🐳 ===========/
@interface UIColor (HexString)
+ (UIImage *)imageWithString:(NSString *)string ;
+ (UIColor *)colorWithString:(NSString *)string;
+ (UIImage *)imageWithColor:(UIColor *)color;
@end
//=========  ============================ stone 🐳 ===========/