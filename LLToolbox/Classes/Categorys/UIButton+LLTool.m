//
//  UIButton+LLTool.m
//  LLToolbox_Example
//
//  Created by 骆亮 on 2019/12/10.
//  Copyright © 2019 LOLITA0164. All rights reserved.
//

#import "UIButton+LLTool.h"
#import <objc/runtime.h>
#import "NSDictionary+LLTool.h"

@interface UIButton ()
@property (strong, nonatomic) NSDictionary *event_blocks;//block事件缓存
@end

@implementation UIButton (LLTool)

/// 布局图片和文字
-(void)layoutImage:(LLImageEdgeInsetsStyle)style space:(CGFloat)space{
    CGFloat imageWidth = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = self.titleLabel.intrinsicContentSize.width;
    CGFloat labelHeight = self.titleLabel.intrinsicContentSize.height;
    
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    //根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
    case top:
            //上 左 下 右
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, -imageHeight-space/2, 0);
            break;
    case left:
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2, 0, space);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2, 0, -space/2);
            break;
    case bottom:
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2, -imageWidth, 0, 0);
            break;
    case right:
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2, 0, -labelWidth-space/2);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWidth-space/2, 0, imageWidth+space/2);
            break;
    }
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}



/// 添加事件回调
- (void)addEventBlock:(void(^)(UIButton *sender))block forControlEvents:(UIControlEvents)controlEvents{
    NSAssert(block, @"不行，block必须传！");
    SEL sel = NULL;
    switch (controlEvents) {
        case UIControlEventTouchDown:
            sel = @selector(UIControlEventTouchDown);
            break;
        case UIControlEventTouchDownRepeat:
            sel = @selector(UIControlEventTouchDownRepeat);
            break;
        case UIControlEventTouchDragInside:
            sel = @selector(UIControlEventTouchDragInside);
            break;
        case UIControlEventTouchDragOutside:
            sel = @selector(UIControlEventTouchDragOutside);
            break;
        case UIControlEventTouchDragEnter:
            sel = @selector(UIControlEventTouchDragEnter);
            break;
        case UIControlEventTouchDragExit:
            sel = @selector(UIControlEventTouchDragExit);
            break;
        case UIControlEventTouchUpInside:
            sel = @selector(UIControlEventTouchUpInside);
            break;
        case UIControlEventTouchUpOutside:
            sel = @selector(UIControlEventTouchUpOutside);
            break;
        case UIControlEventTouchCancel:
            sel = @selector(UIControlEventTouchCancel);
            break;
        default:
            break;
    }
    /// 将所有的 block 存储起来
    [self.event_blocks setValue:block forKey:NSStringFromSelector(sel)];
    [self addTarget:self action:sel forControlEvents:controlEvents];
}
- (void)UIControlEventTouchDown{[self block:_cmd];}
- (void)UIControlEventTouchDownRepeat{[self block:_cmd];}
- (void)UIControlEventTouchDragInside{[self block:_cmd];}
- (void)UIControlEventTouchDragOutside{[self block:_cmd];}
- (void)UIControlEventTouchDragEnter{[self block:_cmd];}
- (void)UIControlEventTouchDragExit{[self block:_cmd];}
- (void)UIControlEventTouchUpInside{[self block:_cmd];}
- (void)UIControlEventTouchUpOutside{[self block:_cmd];}
- (void)UIControlEventTouchCancel{[self block:_cmd];}
- (void)block:(SEL)cmd{
    NSMutableDictionary *dic = objc_getAssociatedObject(self, @selector(event_blocks));
    void (^blcok)(UIButton *) = [dic objectForKeyNotNull:NSStringFromSelector(cmd)];
    if(blcok){
        blcok(self);
    }
}

/// 运行时绑定属性
- (NSDictionary *)event_blocks{
    NSMutableDictionary *dic = objc_getAssociatedObject(self, _cmd);
    if(!dic){
        objc_setAssociatedObject(self, _cmd, [NSMutableDictionary dictionary], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        dic = objc_getAssociatedObject(self, _cmd);
    }
    return dic;
}



@end
