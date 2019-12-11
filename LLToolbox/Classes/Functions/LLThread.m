//
//  LLThread.m
//  GuDaShi
//
//  Created by 骆亮 on 2018/7/7.
//  Copyright © 2018年 晨曦科技. All rights reserved.
//

#import "LLThread.h"

@implementation LLThread

+(NSThread *)thread{
    static NSThread* _thread = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadEntryPoint:) object:nil];
        [_thread start];
    });
    return _thread;
}

/// 开启 runloop 循环
+(void)threadEntryPoint:(id)__unused object{
    @autoreleasepool{
        [[NSThread currentThread] setName:@"LLThread"];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
}

+(void)mainThread:(void (^)(void))block{
    if (block) {
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    }
}

@end





#import <objc/runtime.h>
@class LLThreadModel;
@interface NSObject()
@property (strong, nonatomic)LLThreadModel *model;
@end
@implementation NSObject (LLThread)

-(LLThreadModel *)model{
    LLThreadModel *model = objc_getAssociatedObject(self, _cmd);
    if(!model){
        objc_setAssociatedObject(self, _cmd, [LLThreadModel new], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        model = objc_getAssociatedObject(self, _cmd);
    }
    return model;
}

-(void)addAsynEvent:(void(^)(void))ablock mainThreadEvent:(void(^)(void))bblock{
    if (ablock) { self.model.first = ablock; }
    if (bblock) { self.model.second = bblock; }
    [self performSelector:@selector(aMethod) onThread:LLThread.thread withObject:nil waitUntilDone:YES];
}

-(void)aMethod{
    // 当前线程为 LLThread.thread
    if (self.model.first) {
        void (^blcok)(void) = self.model.first;
        blcok();
    }
    if (self.model.second) {
        void (^blcok)(void) = self.model.second;
        // 该 blcok 会被主线程复制保存，会在主线程中顺序执行。
        [LLThread mainThread:^{
            blcok();
        }];
    }
}


@end





@implementation LLThreadModel
@end

