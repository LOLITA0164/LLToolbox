//
//  LLKVO.m
//  TESTDEMO
//
//  Created by QS on 2020/3/25.
//  Copyright © 2020 LOLITA0164. All rights reserved.
//

#import "LLKVO.h"

@implementation LLKVO

+(LLKVOHandle*)addObserverTo:(NSObject*)obj forKey:(NSString*)keyPath block:(void (^)(NSDictionary *))block{
    LLKVOHandle* handle = [[LLKVOHandle alloc] initWithTarget:obj keyPath:keyPath];
    handle.block = block;
    return handle;
}

@end

@implementation LLKVOHandle
/// 构造器
-(instancetype)initWithTarget:(NSObject*)target keyPath:(NSString*)keyPath{
    if (self = [super init]) {
        self.target = target;
        self.keyPath = keyPath;
        [target addObserver:self forKeyPath:keyPath options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (self.block) {
        self.block(change);
    }
}

/// 管理观察者和被观察者，这里进行了移除清理操作
-(void)removeObserver{
    [self.target removeObserver:self forKeyPath:self.keyPath context:nil];
    self.target = nil;
}

/// 释放之后自动移除观察者
-(void)dealloc{
    [self removeObserver];
//    NSLog(@"%@ 释放了", NSStringFromClass(self.class));
}


@end
