//
//  UIButton+LLTool.h
//  LLToolbox_Example
//
//  Created by 骆亮 on 2019/12/10.
//  Copyright © 2019 LOLITA0164. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    top,
    left,
    right,
    bottom,
} LLImageEdgeInsetsStyle;

@interface UIButton (LLTool)

/// 布局图片和文字
-(void)layoutImage:(LLImageEdgeInsetsStyle)style space:(CGFloat)space;

/// 添加常用事件回调
- (void)addEventBlock:(void(^)(UIButton *sender))block forControlEvents:(UIControlEvents)controlEvents;

@end


