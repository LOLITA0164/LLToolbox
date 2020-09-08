//
//  UIColor+LLTool.m
//  LLToolbox_Example
//
//  Created by 骆亮 on 2019/12/25.
//  Copyright © 2019 LOLITA0164. All rights reserved.
//

#import "UIColor+LLTool.h"

@implementation UIColor (LLTool)
/// 十六进制获取颜色
+(UIColor * _Nonnull (^)(NSInteger))hex{
    return ^UIColor* (NSInteger rgbValue) {
        return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
    };
}
/// RGB获取颜色
+(UIColor * _Nonnull (^)(CGFloat, CGFloat, CGFloat))rgb{
    return ^id(CGFloat r, CGFloat g, CGFloat b) {
        return [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1];
    };
}
/// 随机色
+(UIColor*)rand{
    return UIColor.rgb(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255));
}
@end










@implementation UIColor (Deprecated)

/// 十六进制获取颜色
+(UIColor* (^)(NSInteger rgbValue))colorWithHex{
    return ^UIColor* (NSInteger rgbValue) {
        return UIColor.hex(rgbValue);
    };
}
/// RGB获取颜色
+(UIColor* (^)(CGFloat r, CGFloat g, CGFloat b))colorWithRGB{
    return ^id(CGFloat r, CGFloat g, CGFloat b) {
        return UIColor.rgb(r, g, b);
    };
}
/// 随机色
+(UIColor*)randColor{
    return UIColor.rand;
}

@end
