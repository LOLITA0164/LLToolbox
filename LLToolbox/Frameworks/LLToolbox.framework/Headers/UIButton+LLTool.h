
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    top,
    left,
    right,
    bottom,
} LLImageEdgeInsetsStyle;

@interface UIButton (LLTool)

/// 布局图片和文字
-(void)layoutImage:(LLImageEdgeInsetsStyle)style space:(CGFloat)space;

/// 添加常用事件回调
- (void)addEventBlock:(void(^)(UIButton *sender))block forControlEvents:(UIControlEvents)controlEvents;

@end


