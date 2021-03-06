//
//  NSString+LLTool.m
//  LLToolbox_Example
//
//  Created by 骆亮 on 2019/12/10.
//  Copyright © 2019 LOLITA0164. All rights reserved.
//

#import "NSString+LLTool.h"
#import <CommonCrypto/CommonDigest.h>//md5加密

@implementation NSString (LLTool)

/// 获取当然时间
+(NSString*)currentDate:(NSString*)dateFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: dateFormat.length ? dateFormat : @"yyyy-MM-dd"];
    // 得到当前时间（世界标准时间 UTC/GMT）
    NSDate *nowDate = [NSDate date];
    // 设置系统时区为本地时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    // 计算本地时区与 GMT 时区的时间差
    NSInteger interval = [zone secondsFromGMT];
    // 在 GMT 时间基础上追加时间差值，得到本地时间
    nowDate = [nowDate dateByAddingTimeInterval:interval];
    NSString *nowDateString = [dateFormatter stringFromDate:nowDate];
    return nowDateString;
}

/// 获取时间戳
+(NSString*)timestamp:(NSDate*)date{
    NSDate* dat = date ? date : [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970];
    NSString* timeString = [NSString stringWithFormat:@"%0.f", a];
    return timeString;
}

/// md5 加密
-(NSString*)md5String{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

/// base64 加密
-(NSString*)base64String{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    return base64String;
}
/// base64 解密
-(NSString*)base64DecodeString{
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:self options:0];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    return decodedString;
}

/// 是否为空
+ (BOOL)isBlank:(NSString *)text{
    if (text == nil || text == NULL) {
        return YES;
    }
    if ([text isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([text isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}

/// url 编码
- (NSString *)URLEncodedString{
    NSString *unencodedString = self;
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}
/// url 解码
-(NSString *)URLDecodedString{
    NSString *encodedString = self;
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

/// url 提取参数字典
-(NSDictionary*)URLGetParameter{
    NSURL* url = [NSURL URLWithString:self];
    // 参数字典
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    if (url.absoluteString.length) {
        NSString* absoluteString = [url.absoluteString stringByReplacingOccurrencesOfString:@"#" withString:@""];
        NSURLComponents *components = [[NSURLComponents alloc] initWithURL:[url.absoluteString containsString:@"#"] ? [NSURL URLWithString:absoluteString] : url resolvingAgainstBaseURL:NO];
        [components.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSURLQueryItem *item = (NSURLQueryItem *)obj;
            if (item.name.length && item.value.length) {
                [dic setValue:item.value forKey:item.name];
            }
        }];
    }
    return dic.copy;
}


@end
