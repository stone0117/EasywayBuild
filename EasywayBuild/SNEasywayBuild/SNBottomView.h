//
//  SNBottomView.h
//  EasywayBuild
//
//  Created by stone on 16/4/3.
//  Copyright © 2016年 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNBottomView;
@protocol SNBottomViewDelegate <NSObject>

@optional
- (void)bottomView:(SNBottomView *)bottomView didSelectIndex:(int)index;

@end

@interface SNBottomView : UIView

- (instancetype)initWithFrame:(CGRect)frame normalImages:(NSArray<UIImage *> *)normalImages highlightImages:(NSArray<UIImage *> *)highlightImages;

/** delegate */
@property (weak, nonatomic) id<SNBottomViewDelegate> delegate;
/** 单例模式 */
//SingletonH(SNBottomView)
@end
