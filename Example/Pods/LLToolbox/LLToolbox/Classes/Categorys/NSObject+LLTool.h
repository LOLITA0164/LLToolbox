//
//  NSObject+LLTool.h
//  LLToolbox_Example
//
//  Created by 骆亮 on 2019/12/10.
//  Copyright © 2019 LOLITA0164. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSObject (LLTool)

/**
 模型初始化
 @param modelDic 数据源
 @param hintDic 映射字典 @{ 模型属性 : 数据源字段 }
 */
 /// 模型初始化
 +(instancetype)objectWithModelDic:(NSDictionary*)modelDic hintDic:(NSDictionary*)hintDic;
 /// 模型初始化
 +(instancetype)objectWithModelDic:(NSDictionary*)modelDic;


/// 追加属性（相同覆盖）
-(void)appendFromDic:(NSDictionary *)propertyDic hintDic:(NSDictionary *)hintDic;
/// 追加属性（相同覆盖）
-(void)appendFromDic:(NSDictionary *)propertyDic;



/// 追加属性（相同覆盖）
-(void)appendFromModel:(NSObject*)model hintDic:(NSDictionary*)hintDic;
/// 追加属性（相同覆盖）
-(void)appendFromModel:(NSObject*)model;


/// 转字典，hintDic 是为目标字典的 key
-(NSDictionary*)dictionaryWithHintDic:(NSDictionary*)hintDic;
/// 转 字典
-(NSDictionary*)dictionary;


/// 转 json
-(NSString*)jsonStringWithHintDic:(NSDictionary*)hintDic;
/// 转 json
-(NSString*)jsonString;


/// 输出
-(void)print;

@end



