//
//  UIViewController+LLTool.h
//  LLToolbox
//
//  Created by 骆亮 on 2020/1/7.
//  Copyright © 2020 LOLITA0164. All rights reserved.
//

#import <UIKit/UIKit.h>

/// AOP 的方式实现统计
@protocol UIViewControllerLifeCycleProtocol <NSObject>
@optional
/// 控制器将要进入事件
-(void)viewWillAppearEvent:(UIViewController*)currentController;
/// 控制器加载完成事件
-(void)viewDidLoadEvent:(UIViewController*)currentController;
/// 控制器将要消失事件
-(void)viewWillDisappearEvent:(UIViewController*)currentController;
/// 控制器销毁事件
-(void)deallocEvent:(UIViewController*)currentController;
@end


@protocol UIViewControllerLifeCycleProtocol;
@interface UIViewController (LLTool)

/// 设置生命周期的监听
+(void)setLifeCycleDelegate:(id <UIViewControllerLifeCycleProtocol>)delegate;

@end


