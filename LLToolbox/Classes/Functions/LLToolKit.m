//
//  LLToolKit.m
//  LLToolKit_Example
//
//  Created by 骆亮 on 2019/12/25.
//  Copyright © 2019 LOLITA0164. All rights reserved.
//

#import "LLToolKit.h"
#import <sys/utsname.h>

static LLToolKit* obj = nil;
@implementation LLToolKit

+(instancetype)share{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[self class] new];
    });
    return obj;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [super allocWithZone:zone];
    });
    return obj;
}

/// 工具箱的版本
+(NSString*)version{
    return @"0.2.8";
}

@end





#pragma mark - 其他类功能
@implementation LLToolKit (tool)
+(int (^)(int a, int b))randNumber{
    return ^int (int a, int b) {
        int minValue = MIN(a, b);
        int maxValue = MAX(a, b);
        return (int)(minValue+(arc4random()%(maxValue-minValue+1)));
    };
}
/// 适配比例
+(CGFloat (^)(CGFloat a))adaptedWidthValue{
    return ^CGFloat (CGFloat a) {
        return [UIScreen mainScreen].bounds.size.width/375.0*(a);
    };
}
@end





#pragma mark - 其他信息
@implementation LLToolKit (info)
+(CGFloat)statusBarHeight{
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}
+(CGFloat)navigationBarHeight{
    return (self.statusBarHeight + 44.0);
}
+(CGFloat)tabBarHeight{
    return ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49);
}
+(CGRect)screenBounds{
    return UIScreen.mainScreen.bounds;
}
+(CGSize)screenSize{
    return [[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale) : [UIScreen mainScreen].bounds.size;
}
+(CGFloat)screenWidth{
    return self.screenSize.width;
}
+(CGFloat)screenHeight{
    return self.screenSize.height;
}
@end





#pragma mark - 应用信息
@implementation AppInfo
-(NSDictionary*)dictionary{
    return NSBundle.mainBundle.infoDictionary;
}
-(NSString*)name{
    return self.dictionary[@"CFBundleDisplayName"];
}
-(NSString*)version{
    return self.dictionary[@"CFBundleShortVersionString"];
}
-(NSString*)bundleIdentifier{
    return self.dictionary[@"CFBundleIdentifier"];
}
@end
@implementation LLToolKit (AppInfo)
-(AppInfo*)app{
    return AppInfo.new;
}
@end





#pragma mark - 设备信息
@implementation Device
-(NSString*)name{
    return UIDevice.currentDevice.name;
}
-(NSString*)systemVersion{
    return UIDevice.currentDevice.systemVersion;
}
-(NSString *)systemModelDetail{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if([platform isEqualToString:@"iPhone1,1"])  return @"iPhone 2G";
    if([platform isEqualToString:@"iPhone1,2"])  return @"iPhone 3G";
    if([platform isEqualToString:@"iPhone2,1"])  return @"iPhone 3GS";
    if([platform isEqualToString:@"iPhone3,1"])  return @"iPhone 4";
    if([platform isEqualToString:@"iPhone3,2"])  return @"iPhone 4";
    if([platform isEqualToString:@"iPhone3,3"])  return @"iPhone 4";
    if([platform isEqualToString:@"iPhone4,1"])  return @"iPhone 4S";
    if([platform isEqualToString:@"iPhone5,1"])  return @"iPhone 5";
    if([platform isEqualToString:@"iPhone5,2"])  return @"iPhone 5";
    if([platform isEqualToString:@"iPhone5,3"])  return @"iPhone 5c";
    if([platform isEqualToString:@"iPhone5,4"])  return @"iPhone 5c";
    if([platform isEqualToString:@"iPhone6,1"])  return @"iPhone 5s";
    if([platform isEqualToString:@"iPhone6,2"])  return @"iPhone 5s";
    if([platform isEqualToString:@"iPhone7,1"])  return @"iPhone 6 Plus";
    if([platform isEqualToString:@"iPhone7,2"])  return @"iPhone 6";
    if([platform isEqualToString:@"iPhone8,1"])  return @"iPhone 6s";
    if([platform isEqualToString:@"iPhone8,2"])  return @"iPhone 6s Plus";
    if([platform isEqualToString:@"iPhone8,4"])  return @"iPhone SE";
    if([platform isEqualToString:@"iPhone9,1"])  return @"iPhone 7";
    if([platform isEqualToString:@"iPhone9,3"])  return @"iPhone 7";
    if([platform isEqualToString:@"iPhone9,2"])  return @"iPhone 7 Plus";
    if([platform isEqualToString:@"iPhone9,4"])  return @"iPhone 7 Plus";
    if([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if([platform isEqualToString:@"iPhone11,8"])   return @"iPhone_XR";
    if([platform isEqualToString:@"iPhone11,2"])   return @"iPhone_XS";
    if([platform isEqualToString:@"iPhone11,4"])   return @"iPhone_XS_MAX";
    if([platform isEqualToString:@"iPhone11,6"])   return @"iPhone_XS_MAX";
    if([platform isEqualToString:@"iPod1,1"])  return @"iPod Touch 1G";
    if([platform isEqualToString:@"iPod2,1"])  return @"iPod Touch 2G";
    if([platform isEqualToString:@"iPod3,1"])  return @"iPod Touch 3G";
    if([platform isEqualToString:@"iPod4,1"])  return @"iPod Touch 4G";
    if([platform isEqualToString:@"iPod5,1"])  return @"iPod Touch 5G";
    if([platform isEqualToString:@"iPad1,1"])  return @"iPad 1G";
    if([platform isEqualToString:@"iPad2,1"])  return @"iPad 2";
    if([platform isEqualToString:@"iPad2,2"])  return @"iPad 2";
    if([platform isEqualToString:@"iPad2,3"])  return @"iPad 2";
    if([platform isEqualToString:@"iPad2,4"])  return @"iPad 2";
    if([platform isEqualToString:@"iPad2,5"])  return @"iPad Mini 1G";
    if([platform isEqualToString:@"iPad2,6"])  return @"iPad Mini 1G";
    if([platform isEqualToString:@"iPad2,7"])  return @"iPad Mini 1G";
    if([platform isEqualToString:@"iPad3,1"])  return @"iPad 3";
    if([platform isEqualToString:@"iPad3,2"])  return @"iPad 3";
    if([platform isEqualToString:@"iPad3,3"])  return @"iPad 3";
    if([platform isEqualToString:@"iPad3,4"])  return @"iPad 4";
    if([platform isEqualToString:@"iPad3,5"])  return @"iPad 4";
    if([platform isEqualToString:@"iPad3,6"])  return @"iPad 4";
    if([platform isEqualToString:@"iPad4,1"])  return @"iPad Air";
    if([platform isEqualToString:@"iPad4,2"])  return @"iPad Air";
    if([platform isEqualToString:@"iPad4,3"])  return @"iPad Air";
    if([platform isEqualToString:@"iPad4,4"])  return @"iPad Mini 2G";
    if([platform isEqualToString:@"iPad4,5"])  return @"iPad Mini 2G";
    if([platform isEqualToString:@"iPad4,6"])  return @"iPad Mini 2G";
    if([platform isEqualToString:@"iPad4,7"])  return @"iPad Mini 3";
    if([platform isEqualToString:@"iPad4,8"])  return @"iPad Mini 3";
    if([platform isEqualToString:@"iPad4,9"])  return @"iPad Mini 3";
    if([platform isEqualToString:@"iPad5,1"])  return @"iPad Mini 4";
    if([platform isEqualToString:@"iPad5,2"])  return @"iPad Mini 4";
    if([platform isEqualToString:@"iPad5,3"])  return @"iPad Air 2";
    if([platform isEqualToString:@"iPad5,4"])  return @"iPad Air 2";
    if([platform isEqualToString:@"iPad6,3"])  return @"iPad Pro 9.7";
    if([platform isEqualToString:@"iPad6,4"])  return @"iPad Pro 9.7";
    if([platform isEqualToString:@"iPad6,7"])  return @"iPad Pro 12.9";
    if([platform isEqualToString:@"iPad6,8"])  return @"iPad Pro 12.9";
    if([platform isEqualToString:@"i386"])  return @"iPhone Simulator";
    if([platform isEqualToString:@"x86_64"])  return @"iPhone Simulator";
    return platform;
}
-(NSString *)GUID{
    NSString * retrieveuuid;
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    assert(uuid != NULL);
    CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
    retrieveuuid = [NSString stringWithFormat:@"%@", uuidStr];
    return retrieveuuid;
}
/// 通用唯一标识码
//-(NSString *)IMEI{
//    NSString *retrieveuuid = [SSKeychain passwordForService:self.bundleIdentifier account:@"uuid"];
//    if (retrieveuuid == nil || [retrieveuuid isEqualToString:@""]){
//        CFUUIDRef uuid = CFUUIDCreate(NULL);
//        assert(uuid != NULL);
//        CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
//        retrieveuuid = [NSString stringWithFormat:@"%@", uuidStr];
//        [SSKeychain setPassword: retrieveuuid forService:self.bundleIdentifier account:@"uuid"];
//    }
//    return retrieveuuid;
//}
@end
@implementation LLToolKit (Device)
/// 设置信息
-(Device*)device{
    return Device.new;
}
@end
