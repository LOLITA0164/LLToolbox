#import "LLURLProtocolCustom.h"
#include <objc/runtime.h>

static NSString * const hasInitKey = @"LLURLProtocolCustom";

static RequestClosure _reqBlock;
static FilterClosure _filterBlock;

@interface LLURLProtocolCustom() <NSURLSessionDelegate>
@property (nonatomic, strong) NSURLConnection* connection;
@end
@implementation LLURLProtocolCustom

/// 设置过滤条件，需要拦截返回 YES
+(void)setCaptureCondition:(FilterClosure)block{
    _filterBlock = block;
}

/// 设置请求回调
+(void)setRequestClosure:(RequestClosure)block{
    _reqBlock = block;
}

+(void)useable{
    [NSURLProtocol registerClass:self.class];
    [self exchangeClass:NSURLSession.class method:NSSelectorFromString(@"sessionWithConfiguration:delegate:delegateQueue:")];
}

+(void)load{
    
}

// 解析类型，决定哪些请求要做拦截
+(BOOL)canInitWithRequest:(NSURLRequest *)request{
    // 如果有标记，则不要再发出请求，防止循环重复请求
    if ([NSURLProtocol propertyForKey:hasInitKey inRequest:request]) {
        return NO;
    }
    BOOL condition = YES;
    if (_filterBlock) {
        condition = _filterBlock(request);
    }
    return condition;
}


// 开始加载资源
-(void)startLoading{
    NSMutableURLRequest *mutableReqeust = [[self request] mutableCopy];
    //做下标记，防止递归调用
    [NSURLProtocol setProperty:@YES forKey:hasInitKey inRequest:mutableReqeust];
    self.connection = [NSURLConnection connectionWithRequest:mutableReqeust delegate:self];
}

-(void)stopLoading{
    [self.connection cancel];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [self.client URLProtocol:self didFailWithError:error];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.client URLProtocol:self didLoadData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self.client URLProtocolDidFinishLoading:self];
}



// 自定义网络请求，如果不需要处理直接返回request。
+(NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request{
    // 解析当前请求的信息
    NSString* method = request.HTTPMethod;
    NSString* content = [self getParam:request];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    NSArray* paramList = [content componentsSeparatedByString:@"&"];
    for (NSString* item in paramList) {
        NSArray* param = [item componentsSeparatedByString:@"="];
        if (item.length&&param.count==2) {
            [dic setValue:param.lastObject forKey:param.firstObject];
        }
    }
    // 在这里可以修改掉请求信息，做一些骚操作。
//    [self DOSOMETHING:request param:content];
    if (_reqBlock) {
        return _reqBlock(request, method, dic);
    } else {
        return request;
    }
}


// 替换掉 AF 中的默认配置，这样可以拦截 AF 发出的请求。其他请求类这需要主动配置
+(NSURLSessionConfiguration *)defaultSessionConfiguration{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSMutableArray *array = [[config protocolClasses] mutableCopy];
    [array insertObject:[self class] atIndex:0];
    config.protocolClasses = array;
    return config;
}


// 交换方法
+(void)exchangeClass:(Class)class method:(SEL)originalSelector{
    SEL swizzledSelector = NSSelectorFromString([@"ll_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
    Method originalMethod = class_getClassMethod(class, originalSelector);
    Method swizzledMethod = class_getClassMethod(self, swizzledSelector);
    // 将原来的方法指向新的实现
    class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    // 将新的方法指向原来的实现
    class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}


+(NSURLSession *)ll_sessionWithConfiguration:(NSURLSessionConfiguration *)configuration delegate:(nullable id <NSURLSessionDelegate>)delegate delegateQueue:(nullable NSOperationQueue *)queue{
    NSURLSessionConfiguration* configurationNew = [LLURLProtocolCustom defaultSessionConfiguration];
    return [LLURLProtocolCustom ll_sessionWithConfiguration:configurationNew delegate:delegate delegateQueue:queue];
}

// 获取请求参数
+(NSString*)getParam:(NSURLRequest*)request{
    NSMutableData *data = [[NSMutableData alloc] init];
    if ([request.HTTPMethod isEqualToString:@"POST"]) {
        if (!request.HTTPBody) {
            uint8_t rd[1024] = {0};
            NSInputStream *stream = request.HTTPBodyStream;
            [stream open];
            while ([stream hasBytesAvailable]) {
                NSInteger len = [stream read:rd maxLength:1024];
                if (len > 0 && stream.streamError == nil) {
                    [data appendBytes:(void *)rd length:len];
                }
            }
            [stream close];
        }
    }
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return str;
}

#pragma mark - 其他一些事情
//+(void)DOSOMETHING:(NSURLRequest*)request param:(NSString*)param{
//    [NSUserDefaults.standardUserDefaults setURL:request.URL forKey:@"RequestCustomURL"];
//    [NSUserDefaults.standardUserDefaults setObject:request.HTTPMethod forKey:@"RequestCustomMethod"];
//    [NSUserDefaults.standardUserDefaults setObject:param forKey:@"RequestCustomParam"];
//    [NSUserDefaults.standardUserDefaults synchronize];
//
//    static dispatch_source_t timer = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
//        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
//        dispatch_source_set_event_handler(timer, ^{
//            [self DOSOMETHING];
//        });
//        dispatch_resume(timer);
//    });
//}
//
//+(void)DOSOMETHING{
//    NSURL* url = [NSUserDefaults.standardUserDefaults URLForKey:@"RequestCustomURL"];
//    NSString* method = [NSUserDefaults.standardUserDefaults objectForKey:@"RequestCustomMethod"];
//    NSString* param = [NSUserDefaults.standardUserDefaults objectForKey:@"RequestCustomParam"];
//    if (url.absoluteString.length==0) { return; }
//    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
//    request.HTTPMethod = method;
//    request.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
//    [[NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (error == nil) {
//            NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//        } else {
//            NSLog(@"%@",error);
//        }
//    }] resume];
//}

@end
