//
//  NSTimer+LLTool.h
//  LLToolbox_Example
//
//  Created by 骆亮 on 2019/12/10.
//  Copyright © 2019 LOLITA0164. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSTimer (LLTool)
/// 暂停
- (void)pause;
/// 恢复
- (void)resume;
/// 时间间隔后恢复
- (void)resumeAfterTimeInterval:(NSTimeInterval)interval;
@end


