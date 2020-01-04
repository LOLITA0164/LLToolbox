//
//  NSDictionary+LLTool.h
//  LLToolbox_Example
//
//  Created by 骆亮 on 2019/12/10.
//  Copyright © 2019 LOLITA0164. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (LLTool)

/// 获取数据
-(id)objectForKeyNotNull:(id)key;
/// 转换为字符串
-(NSString*)toString;

@end


