
#import <Foundation/Foundation.h>

@interface NSString (LLTool)

/// 获取当前时间
+(NSString*)currentDate:(NSString*)dateFormat;

/// 获取时间戳
+(NSString*)timestamp:(NSDate*)date;

/// md5 加密
-(NSString*)md5String;

/// base64 加密
-(NSString*)base64String;
/// base64 解密
-(NSString*)base64DecodeString;

/// 是否为空
+ (BOOL)isBlank:(NSString *)text;

/// url 编码
-(NSString *)URLEncodedString;
/// url 解码
-(NSString *)URLDecodedString;

/// url 提取参数字典
-(NSDictionary*)URLGetParameter;

@end


