//
//  LLRemotePusher.m
//  LLToolbox_Example
//
//  Created by 骆亮 on 2019/12/17.
//  Copyright © 2019 LOLITA0164. All rights reserved.
//

#import "LLRemotePush.h"
#import <UserNotifications/UserNotifications.h>

static LLRemotePush* manager = nil;

@interface LLRemotePush () <UNUserNotificationCenterDelegate> // iOS10 的协议
@property (weak, nonatomic) id <LLRemotePushProtocol> delegate;
@end
@implementation LLRemotePush

+(instancetype)share{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self class] new];
    });
    return manager;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [super allocWithZone:zone];
    });
    return manager;
}


/// 注册 APNS 服务
-(void)registerAPNS:(UIApplication*)application delegete:(id<LLRemotePushProtocol>)delegate{
    // 10之后将远程推送的部分移除了 appdelegate，单独成类
    if (@available(iOS 10, *)) {
        UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge |
                                                 UNAuthorizationOptionSound |
                                                 UNAuthorizationOptionAlert |
                                                 UNAuthorizationOptionCarPlay)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (error == nil) {
                NSLog(@"request authorization succeeded!");
            }
        }];
        [UIApplication.sharedApplication registerForRemoteNotifications];
    }
    else if (@available(iOS 8, *)) {
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings* settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [UIApplication.sharedApplication registerUserNotificationSettings:settings];
    }
    else {
        UIRemoteNotificationType type = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert;
        [UIApplication.sharedApplication registerForRemoteNotificationTypes:type];
    }
}



/// 处理收到 `deviceToken`, 为了统一口径，会回调到代理方法中（可选择直接在 appdelegate 中处理）
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    if ([self.delegate respondsToSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)]) {
        [self.delegate application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    }
}

/// 处理【iOS10以下】收到通知的方法, 为了统一口径，会回调到代理方法中（可选择直接在 appdelegate 中处理）
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    completionHandler(UIBackgroundFetchResultNoData);
    if ([self.delegate respondsToSelector:@selector(application:didReceiveRemoteNotification:applicationState:)]) {
        UIApplicationState state = [UIApplication sharedApplication].applicationState;
        [self.delegate application:application didReceiveRemoteNotification:userInfo applicationState:state];
    }
}


/// 【iOS10】处理【前台】收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0)){
    completionHandler(UNNotificationPresentationOptionNone);
    if ([self.delegate respondsToSelector:@selector(application:didReceiveRemoteNotification:applicationState:)]) {
        [self.delegate application:UIApplication.sharedApplication didReceiveRemoteNotification:notification.request.content.userInfo applicationState:UIApplicationStateActive];
    }
}

/// 【iOS10】处理【后台】收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    completionHandler();
    if ([self.delegate respondsToSelector:@selector(application:didReceiveRemoteNotification:applicationState:)]) {
        [self.delegate application:UIApplication.sharedApplication didReceiveRemoteNotification:response.notification.request.content.userInfo applicationState:UIApplicationStateBackground];
    }
}


@end
