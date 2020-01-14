
#import <Foundation/Foundation.h>

/// 定义私有线程
@interface LLThread : NSObject
/// 私有线程
+(NSThread*)thread;
/// 回到主线程
+(void)mainThread:(void(^)(void))block;
@end



/// 添加线程的切换功能
@interface NSObject (LLThread)
/// 异步任务，执行线程为 LLThread.thread
-(void)addAsynEvent:(void(^)(void))ablock mainThreadEvent:(void(^)(void))bblock;
@end


@interface LLThreadModel : NSObject
@property (strong, nonatomic) id first;
@property (strong, nonatomic) id second;
@end
