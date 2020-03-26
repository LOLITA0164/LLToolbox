
#import <UIKit/UIKit.h>
#import "LLToolboxDefines.h"

@interface UIColor (LLTool)
/// 十六进制获取颜色
+(UIColor* (^)(NSInteger rgbValue))hex;
/// RGB获取颜色
+(UIColor* (^)(CGFloat r, CGFloat g, CGFloat b))rgb;
/// 随机色
+(UIColor*)rand;
@end





@interface UIColor (Deprecated)
/// 十六进制获取颜色
+(UIColor* (^)(NSInteger rgbValue))colorWithHex LLToolboxDeprecated("请使用`+hex`替换,未来版本即将删除.");
/// RGB获取颜色
+(UIColor* (^)(CGFloat r, CGFloat g, CGFloat b))colorWithRGB LLToolboxDeprecated("请使用`+rgb`替换,未来版本即将删除.");
/// 随机色
+(UIColor*)randColor LLToolboxDeprecated("请使用`+rand`替换,未来版本即将删除.");
@end

