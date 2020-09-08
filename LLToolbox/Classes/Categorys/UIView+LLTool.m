//
//  UIView+LLTool.m
//  LLToolbox_Example
//
//  Created by 骆亮 on 2019/12/25.
//  Copyright © 2019 LOLITA0164. All rights reserved.
//

#import "UIView+LLTool.h"
#import <objc/runtime.h>

@implementation UIView (LLTool)

- (void)setCornerRadius:(CGFloat)cornerRadius{
    objc_setAssociatedObject(self, @selector(cornerRadius), @(cornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}
- (CGFloat)cornerRadius{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setBorderColor:(UIColor *)borderColor{
    objc_setAssociatedObject(self, @selector(borderColor), borderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = 1;
}
- (UIColor *)borderColor{
    return objc_getAssociatedObject(self, _cmd);
}

-(CGPoint)origin_ll{
    return self.frame.origin;
}
-(void)setOrigin_ll:(CGPoint)origin_ll{
    CGRect newFrame = self.frame;
    newFrame.origin = origin_ll;
    self.frame = newFrame;
}

-(CGFloat)x_ll{
    return self.origin_ll.x;
}
-(void)setX_ll:(CGFloat)x_ll{
    self.origin_ll = CGPointMake(x_ll, self.y_ll);
}

-(CGFloat)y_ll{
    return self.origin_ll.y;
}
-(void)setY_ll:(CGFloat)y_ll{
    self.origin_ll = CGPointMake(self.x_ll, y_ll);
}

-(CGSize)size_ll{
    return self.frame.size;
}
-(void)setSize_ll:(CGSize)size_ll{
    CGRect newFrame = self.frame;
    newFrame.size = size_ll;
    self.frame = newFrame;
}

-(CGFloat)width_ll{
    return self.size_ll.width;
}
-(void)setWidth_ll:(CGFloat)width_ll{
    self.size_ll = CGSizeMake(width_ll, self.height_ll);
}

-(CGFloat)height_ll{
    return self.size_ll.height;
}
-(void)setHeight_ll:(CGFloat)height_ll{
    self.size_ll = CGSizeMake(self.width_ll, height_ll);
}

-(CGFloat)top_ll{
    return self.y_ll;
}
-(void)setTop_ll:(CGFloat)top_ll{
    self.y_ll = top_ll;
}

-(CGFloat)left_ll{
    return self.x_ll;
}
-(void)setLeft_ll:(CGFloat)left_ll{
    self.x_ll = left_ll;
}

-(CGFloat)bottom_ll{
    return self.top_ll + self.height_ll;
}
-(void)setBottom_ll:(CGFloat)bottom_ll{
    self.top_ll = bottom_ll - self.height_ll;
}

-(CGFloat)right_ll{
    return self.left_ll + self.width_ll;
}
-(void)setRight_ll:(CGFloat)right_ll{
    self.left_ll = right_ll - self.width_ll;
}

-(CGFloat)centerX_ll{
    return self.center.x;
}
-(void)setCenterX_ll:(CGFloat)centerX_ll{
    self.center = CGPointMake(centerX_ll, self.centerY_ll);
}

-(CGFloat)centerY_ll{
    return self.center.y;
}
-(void)setCenterY_ll:(CGFloat)centerY_ll{
    self.center = CGPointMake(self.centerX_ll, centerY_ll);
}


@end
