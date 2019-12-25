//
//  LLToolbox.h
//  LLToolbox_Example
//
//  Created by 骆亮 on 2019/12/25.
//  Copyright © 2019 LOLITA0164. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AppInfo;
@class Device;
#pragma mark - 工具箱，各种常用配置
@interface LLToolbox : NSObject
/// 实例
+(instancetype)share;
@end




#pragma mark - 其他类功能
@interface LLToolbox (tool)
/// 随机数字
+(int (^)(int a, int b))randNumber;
/// 适配比例，基数为 375.0 大小的屏幕
+(CGFloat (^)(CGFloat a))adaptedWidthValue;
@end





#pragma mark - 其他信息
@interface LLToolbox (info)
/// 状态栏高度
+(CGFloat)statusBarHeight;
/// 导航栏高度
+(CGFloat)navigationBarHeight;
/// TabBar高度
+(CGFloat)tabBarHeight;
/// 屏幕大小
+(CGRect)screenBounds;
/// 屏幕大小
+(CGSize)screenSize;
/// 屏幕宽
+(CGFloat)screenWidth;
/// 屏幕高
+(CGFloat)screenHeight;
@end






#pragma mark - 颜色类
@interface LLToolbox (UIColor)
/// 十六进制获取颜色
+(UIColor* (^)(NSInteger rgbValue))colorWithHex;
/// RGB获取颜色
+(UIColor* (^)(CGFloat r, CGFloat g, CGFloat b))colorWithRGB;
/// 随机色
+(UIColor*)randColor;
@end







#pragma mark - 应用信息
@interface AppInfo : NSObject
/// 所有数据
-(NSDictionary*)dictionary;
/// 包名
-(NSString*)name;
/// app 版本
-(NSString*)version;
/// 包标识
-(NSString*)bundleIdentifier;
@end
@interface LLToolbox (AppInfo)
/// 应用信息
-(AppInfo*)app;
@end






#pragma mark - 设备信息
@interface Device : NSObject
/// 设备名称
-(NSString*)name;
/// 设备系统版本
-(NSString*)systemVersion;
/// 系统的model
-(NSString *)systemModelDetail;
/// 获取惟一标识符(很小概率会重复的码)
-(NSString *)GUID;
/// 通用唯一标识码
//-(NSString *)IMEI;
@end
@interface LLToolbox (Device)
/// 设置信息
-(Device*)device;
@end




