//
//  SNBottomView.m
//  EasywayBuild
//
//  Created by stone on 16/4/3.
//  Copyright © 2016年 stone. All rights reserved.
//

#import "SNBottomView.h"
//#define kCount 3

#define kDefaultSelected 0

//=****** add class ****************** stone ***
@interface SNBottomViewButton : UIButton

@end

@implementation SNBottomViewButton

/** 取消高亮状态... */
- (void)setHighlighted:(BOOL)highlighted {
    // 111
}

@end
//=************************ stone ***

@interface SNBottomView ()
/** View */
@property(weak, nonatomic) SNBottomViewButton * previousBtn;

/** iconImages */
@property(nonatomic, strong) NSArray<UIImage *> * normalImages;
/** highlightImages */
@property(nonatomic, strong) NSArray<UIImage *> * highlightImages;

/** elementCount */
@property(nonatomic, assign) NSInteger elementCount;

@end

@implementation SNBottomView

- (instancetype)initWithFrame:(CGRect)frame normalImages:(NSArray<UIImage *> *)normalImages highlightImages:(NSArray<UIImage *> *)highlightImages {

    self = [super initWithFrame:frame];

    if (self) {

        for (int i = 0; i < normalImages.count; i++) {

            SNBottomViewButton * btn = [SNBottomViewButton buttonWithType:UIButtonTypeCustom];

            btn.tag = i;

            UIImage * normalImage = normalImages[i];
            UIImage * highlightImage = highlightImages[i];
            if (normalImages != nil ) {
                
                [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
            }
            if (highlightImages != nil) {
                
                [btn setBackgroundImage:highlightImage forState:UIControlStateSelected];
            }

            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];

            [self addSubview:btn];
        }
    }

    self.elementCount = normalImages.count;
    self.normalImages = normalImages;
    self.highlightImages = highlightImages;

    return self;
}

- (void)layoutSubviews {
    // 一定要调用super的layoutSubviews
    [super layoutSubviews];

    [self.subviews enumerateObjectsUsingBlock:^(__kindof SNBottomViewButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {

      CGFloat width = self.bounds.size.width / self.elementCount;
      CGFloat height = self.bounds.size.height;
      CGFloat x = width * idx;
      CGFloat y = 0;
      btn.frame = CGRectMake(x, y, width, height);

      /** 默认选中 */
      if (idx == kDefaultSelected) {

          [self btnClick:btn];
      }
    }];
}
//=****** btn click ****************** stone ***
- (void)btnClick:(SNBottomViewButton *)sender {

    self.previousBtn.selected = NO;
    sender.selected = YES;
    self.previousBtn = sender;

    if ([self.delegate respondsToSelector:@selector(bottomView:didSelectIndex:)]) {
        [self.delegate bottomView:self didSelectIndex:(int)sender.tag];
    }
}
@end
