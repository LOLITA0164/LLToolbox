//
//  UIViewController+LLTool.m
//  LLToolbox
//
//  Created by 骆亮 on 2020/1/7.
//  Copyright © 2020 LOLITA0164. All rights reserved.
//

#import "UIViewController+LLTool.h"
#import <objc/runtime.h>
#import "NSString+LLTool.h"

static id <UIViewControllerLifeCycleProtocol> _delegate = nil;

@implementation UIViewController (LLTool)

+(void)load {
    [self exchangeMethod:@selector(viewWillAppear:)];
    [self exchangeMethod:@selector(viewWillDisappear:)];
    [self exchangeMethod:@selector(viewDidLoad)];
    [self exchangeMethod:NSSelectorFromString(@"dealloc")];
}

+ (void)exchangeMethod:(SEL)originalSelector{
    SEL swizzledSelector = NSSelectorFromString([@"ll_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    if (class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


+(void)setLifeCycleDelegate:(id<UIViewControllerLifeCycleProtocol>)delegate{
    _delegate = delegate;
}



- (void)ll_viewWillAppear:(BOOL)animated{
    if ([_delegate respondsToSelector:@selector(viewWillAppearEvent:)]) {
        [_delegate viewWillAppearEvent:self];
    }
    [self ll_viewWillAppear:animated];
}

- (void)ll_viewDidLoad{
    if ([_delegate respondsToSelector:@selector(viewDidLoadEvent:)]) {
        [_delegate viewDidLoadEvent:self];
    }
    [self ll_viewDidLoad];
}

- (void)ll_viewWillDisappear:(BOOL)animated{
    if ([_delegate respondsToSelector:@selector(viewWillDisappearEvent:)]) {
        [_delegate viewWillDisappearEvent:self];
    }
    [self ll_viewWillDisappear:animated];
}

- (void)ll_dealloc{
    if ([_delegate respondsToSelector:@selector(deallocEvent:)]) {
        [_delegate deallocEvent:self];
    }
    [self ll_dealloc];
}

@end
