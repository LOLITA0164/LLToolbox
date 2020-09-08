
/*
 该类为了转移计时器的强引用关系。具体来说为了解决：`dealloc` 无法使用 `invalidate`。
 Q:
 调用者 -> NSTimer,
 NSTimer -> 调用者
 A：
 调用者 -> LLTimer,
 LLTimer -> NSTimer,
 LLTimer -> LLTimerHandle,
 NSTimer -> LLTimerHanele,
 */

#import <Foundation/Foundation.h>

@class LLTimerHandle;
@interface LLTimer : NSObject

/// 构造器，默认是重复
+(instancetype)timeInertval:(NSTimeInterval)interval target:(id)target selector:(SEL)selector userInfo:(NSDictionary*)info;

/// 构造器，非必要，可以使用 NSTimer 中的方法
+(instancetype)timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block API_AVAILABLE(macosx(10.12), ios(10.0), watchos(3.0), tvos(10.0));

/// 暂停
- (void)pause;
/// 恢复
- (void)resume;
/// 时间间隔后恢复
- (void)resumeAfterTimeInterval:(NSTimeInterval)interval;

@end



/// 只回调事件
@interface LLTimerHandle : NSObject
-(instancetype)initWithBlock:(void(^)(void))block;
-(void)doRepeatEvent;
@end
