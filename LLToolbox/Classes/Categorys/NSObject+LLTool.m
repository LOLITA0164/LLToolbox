//
//  NSObject+LLTool.m
//  LLToolbox_Example
//
//  Created by 骆亮 on 2019/12/10.
//  Copyright © 2019 LOLITA0164. All rights reserved.
//

#import "NSObject+LLTool.h"
#import <objc/runtime.h>
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"

@implementation NSObject (LLTool)

/// 模型初始化
+(instancetype)objectWithModelDic:(NSDictionary *)modelDic hintDic:(NSDictionary *)hintDic{
    NSObject *instance = [[[self class] alloc] init];
    [instance appendFromDic:modelDic hintDic:hintDic];
    return instance;
}
/// 模型初始化
+(instancetype)objectWithModelDic:(NSDictionary*)modelDic{
    return [self objectWithModelDic:modelDic hintDic:nil];
}



/// 追加属性（相同覆盖）
-(void)appendFromDic:(NSDictionary *)propertyDic hintDic:(NSDictionary *)hintDic{
    Class className = self.class;
    while (className && ![NSStringFromClass(className) containsString:@"NSObject"]) {
        [self setupFromDic:propertyDic hintDic:hintDic class:className];
        className = [className superclass];
    }
}
/// 追加属性（相同覆盖）
-(void)appendFromDic:(NSDictionary *)propertyDic{
    [self appendFromDic:propertyDic hintDic:nil];
}
/// 赋值
-(void)setupFromDic:(NSDictionary *)propertyDic hintDic:(NSDictionary *)hintDic class:(Class)className{
    unsigned int numIvars; // 成员变量
    Ivar *vars = class_copyIvarList(className, &numIvars);
    NSString* key = nil;
    NSString *key_property = nil;  // 属性
    for (int i=0; i<numIvars; i++) {
        Ivar thisIvar = vars[i];
        key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];   // 获取成员变量的名称
        key = [key hasPrefix:@"_"]?[key substringFromIndex:1]:key;  // 去掉成员变量的头部下划线
        key_property = key;
        
        // 映射字典,转换key
        if (hintDic) {
            key = [hintDic objectForKey:key]?[hintDic objectForKey:key]:key;
        }
        
        id value = [propertyDic objectForKey:key];
        if (value == NSNull.null) { value = nil; }
        
        NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(thisIvar)];//获取变量类型
        if(value){
            if([type containsString:@"NSString"]){
                [self setValue:[NSString stringWithFormat:@"%@", value] forKey:key_property];
            }else
                [self setValue:value forKey:key_property];
        }
    }
    free(vars);
}





/// 追加属性（相同覆盖）
-(void)appendFromModel:(NSObject*)model hintDic:(NSDictionary*)hintDic{
    NSDictionary* propertyDic = [model dictionaryWithHintDic:nil];
    [self appendFromDic:propertyDic hintDic:hintDic];
}
/// 追加属性（相同覆盖）
-(void)appendFromModel:(NSObject*)model{
    [self appendFromModel:model hintDic:nil];
}






/// 转字典
-(NSDictionary*)dictionaryWithHintDic:(NSDictionary*)hintDic{
    NSMutableDictionary *resDic = [NSMutableDictionary dictionary];
    Class className = self.class;
    while (className && ![NSStringFromClass(className) containsString:@"NSObject"]) {
        NSDictionary* dic = [self getDictionaryWithHintDic:hintDic class:className];
        if (dic.allKeys.count) {
            [resDic setValuesForKeysWithDictionary:dic];
        }
        className = [className superclass];
    }
    return resDic.copy;
}
/// 转 字典
-(NSDictionary*)dictionary{
    NSDictionary *dic = [self dictionaryWithHintDic:nil];
    return dic;
}
///
-(NSDictionary*)getDictionaryWithHintDic:(NSDictionary*)hintDic class:(Class)className{
    NSMutableDictionary *resDic = [NSMutableDictionary dictionary];
    unsigned int numIvars; // 成员变量个数
    Ivar *vars = class_copyIvarList(className, &numIvars);
    NSString *key=nil;
    for(int i = 0; i < numIvars; i++) {
        Ivar thisIvar = vars[i];
        key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];  // 获取成员变量的名字
        key = [key hasPrefix:@"_"]?[key substringFromIndex:1]:key;
        id value = [self valueForKey:key];
        if (value!=nil) {
            // 映射字典,转换key
            if (hintDic) {
                key = [hintDic objectForKey:key]?[hintDic objectForKey:key]:key;
            }
            [resDic setValue:value forKey:key];
        }
    }
    free(vars);
    return resDic.copy;
}






/// 转 json
-(NSString*)jsonStringWithHintDic:(NSDictionary*)hintDic{
    NSDictionary *resDic = [self dictionaryWithHintDic:hintDic];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:resDic options:NSJSONWritingPrettyPrinted error:nil];
    if (jsonData) {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return @"";
}
/// 转 json
-(NSString*)jsonString{
    return [self jsonStringWithHintDic:nil];
}






/// 以字典的形式输出模型中的数据
-(void)print{
    NSLog(@"%@",self.dictionary);
}


@end

