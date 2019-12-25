//
//  UIView+LLTool.h
//  LLToolbox_Example
//
//  Created by 骆亮 on 2019/12/25.
//  Copyright © 2019 LOLITA0164. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface UIView (LLTool)
/// 圆角
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
/// 边框颜色
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

/// self.frame.origin
@property (nonatomic) CGPoint origin_ll;
/// self.frame.origin.x
@property (nonatomic) CGFloat x_ll;
/// self.frame.origin.y
@property (nonatomic) CGFloat y_ll;
/// self.frame.size
@property (nonatomic) CGSize size_ll;
/// self.frame.size.width
@property (nonatomic) CGFloat width_ll;
/// self.frame.size.height
@property (nonatomic) CGFloat height_ll;
/// 顶部
@property (nonatomic) CGFloat top_ll;
/// 左边
@property (nonatomic) CGFloat left_ll;
/// 底部
@property (nonatomic) CGFloat bottom_ll;
/// 右边
@property (nonatomic) CGFloat right_ll;
/// self.center.x
@property (nonatomic) CGFloat centerX_ll;
/// self.center.y
@property (nonatomic) CGFloat centerY_ll;
@end
