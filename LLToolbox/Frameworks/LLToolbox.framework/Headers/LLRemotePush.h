
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol LLRemotePushProtocol;
@interface LLRemotePush : NSObject

/// 实例
+(instancetype)share;

/// 注册 APNS 服务，进入 `application:didRegisterForRemoteNotificationsWithDeviceToken:` 方法返回 `deviceToken`
-(void)registerAPNS:(UIApplication*)application delegete:(id <LLRemotePushProtocol>)delegate;

/// 处理 `deviceToken`, 为了统一口径，会回调到代理方法中（也可直接在 `appdelegate` 中处理）
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
/// 处理 iOS10 以下收到通知的方法, 为了统一口径，会回调到代理方法中（也可直接在 `appdelegate` 中处理）
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

@end





@protocol LLRemotePushProtocol <NSObject>
@optional
/// 处理 `deviceToken`
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
@required
/// 接收到推送通知的方法，`state` 判断前后台状态
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo applicationState:(UIApplicationState)state;

@end
