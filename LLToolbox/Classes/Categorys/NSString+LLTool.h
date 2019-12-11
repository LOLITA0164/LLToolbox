//
//  NSString+LLTool.h
//  LLToolbox_Example
//
//  Created by 骆亮 on 2019/12/10.
//  Copyright © 2019 LOLITA0164. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LLTool)

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


