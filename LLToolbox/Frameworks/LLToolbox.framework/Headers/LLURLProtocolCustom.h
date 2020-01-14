#import <Foundation/Foundation.h>

/// 过滤条件
typedef BOOL (^FilterClosure)(NSURLRequest* request);
/// 请求回调
typedef NSURLRequest* (^RequestClosure)( NSURLRequest* request, NSString* method, NSDictionary* param);

@interface LLURLProtocolCustom : NSURLProtocol

/*
 将请求框架中的 sessionConfiguration 替换为此类中的 defaultSessionConfiguration (可选)
 */

/// 启用，需要在项目最开始开启（必须）
+(void)useable;

/// 过滤条件。需要做捕获时返回 YES （可选）
+(void)setCaptureCondition:(FilterClosure)block;

/// 请求回调。可以在此方法中获取到请求信息，以此作一些统计信息；可以在这里修改请求参数。
+(void)setRequestClosure:(RequestClosure)block;


@end

