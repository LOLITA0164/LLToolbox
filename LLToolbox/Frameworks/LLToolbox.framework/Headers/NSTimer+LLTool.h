
#import <Foundation/Foundation.h>
@interface NSTimer (LLTool)
/// 暂停
- (void)pause;
/// 恢复
- (void)resume;
/// 时间间隔后恢复
- (void)resumeAfterTimeInterval:(NSTimeInterval)interval;
@end


