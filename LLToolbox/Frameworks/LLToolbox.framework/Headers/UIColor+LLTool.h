//
//  UIColor+LLTool.h
//  LLToolbox_Example
//
//  Created by 骆亮 on 2019/12/25.
//  Copyright © 2019 LOLITA0164. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LLTool)
/// 十六进制获取颜色
+(UIColor* (^)(NSInteger rgbValue))colorWithHex;
/// RGB获取颜色
+(UIColor* (^)(CGFloat r, CGFloat g, CGFloat b))colorWithRGB;
/// 随机色
+(UIColor*)randColor;
@end

