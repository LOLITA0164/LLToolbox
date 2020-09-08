
/*
 为了实现高内聚方式使用 KVO，无需手动清理
 */

#import <Foundation/Foundation.h>

@class LLKVOHandle;
@interface LLKVO : NSObject
/// 返回值值需要被持有
+(LLKVOHandle*)addObserverTo:(NSObject*)obj forKey:(NSString*)keyPath block:(void(^)(NSDictionary*changes))block;
@end



///  KVO 的几个必要数据
@interface LLKVOHandle : NSObject
/// 被观察者
@property (nonatomic, strong) NSObject* target;
/// 观察属性
@property (nonatomic, copy) NSString* keyPath;
/// 属性变化的回调
@property (nonatomic, copy) void (^block)(NSDictionary*);
/// 构造器
-(instancetype)initWithTarget:(NSObject*)target keyPath:(NSString*)keyPath;
@end
