//
//  LLTimer.m
//  TESTDEMO
//
//  Created by QS on 2020/3/25.
//  Copyright © 2020 LOLITA0164. All rights reserved.
//

#import "LLTimer.h"
@interface LLTimer ()
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, strong) NSDictionary* info;
@property (nonatomic, strong) NSTimer* timer;
@property (nonatomic, strong) LLTimerHandle* handle;
@end

@implementation LLTimer

/// 构造器，默认是重复
+(instancetype)timeInertval:(NSTimeInterval)interval target:(id)target selector:(SEL)selector userInfo:(NSDictionary*)info{
    LLTimer* timer = [[LLTimer alloc] initWithTimeInertval:interval target:target selector:selector userInfo:info];
    return timer;
}
/// 构造器，默认是重复
-(instancetype)initWithTimeInertval:(NSTimeInterval)interval target:(id)target selector:(SEL)selector userInfo:(NSDictionary *)info{
    if (self = [super init]) {
        self.target = target;
        self.selector = selector;
        self.info = info;
        __weak typeof(self) ws = self;
        self.handle = [[LLTimerHandle alloc] initWithBlock:^{
            __strong typeof(self) ss = ws;
            if (ss.target == nil) { return; }
            // 为了防止在某些多线程中，self.target 被替换
            id target = ss.target;
            SEL selector = ss.selector;
            NSDictionary* info = ss.info;
            if ([target respondsToSelector:selector]) {
                [target performSelector:selector withObject:info];
            }
        }];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self.handle selector:@selector(doRepeatEvent) userInfo:nil repeats:YES];
    }
    return self;
}

/// 构造器
+ (instancetype)timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block{
    LLTimer* timer = [[LLTimer alloc] initWithTimeInterval:interval repeats:repeats block:block];
    return timer;
}
-(instancetype)initWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block API_AVAILABLE(macosx(10.12), ios(10.0), watchos(3.0), tvos(10.0)){
    if (self = [super init]) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:interval repeats:repeats block:^(NSTimer * timer) {
            if (block) {
                block(timer);
            }
        }];
    }
    return self;
}


/// 关闭定时器
-(void)shutDown{
    [self.timer invalidate];
    self.timer = nil;
}


- (void)pause{
    if (![self.timer isValid]) {
        return ;
    }
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)resume{
    if (![self.timer isValid]) {
        return ;
    }
    [self.timer setFireDate:[NSDate date]];
}

- (void)resumeAfterTimeInterval:(NSTimeInterval)interval{
    if (![self.timer isValid]) {
        return ;
    }
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}


-(void)dealloc{
    [self shutDown];
//    NSLog(@"%@ 释放了。", NSStringFromClass(self.class));
}

@end






@interface LLTimerHandle ()
@property (nonatomic, copy) void (^block)(void);
@end
@implementation LLTimerHandle
-(instancetype)initWithBlock:(void (^)(void))block{
    if (self = [super init]) {
        self.block = block;
    }
    return self;
}
-(void)doRepeatEvent{
    if (self.block) {
        self.block();
    }
}
-(void)dealloc{
//    NSLog(@"%@ 释放了。", NSStringFromClass(self.class));
}
@end
