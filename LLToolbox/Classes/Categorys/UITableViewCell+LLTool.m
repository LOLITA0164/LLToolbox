//
//  UITableViewCell+LLTool.m
//  LLToolbox_Example
//
//  Created by 骆亮 on 2019/12/10.
//  Copyright © 2019 LOLITA0164. All rights reserved.
//

#import "UITableViewCell+LLTool.h"

@implementation UITableViewCell (LLTool)
+ (__kindof UITableViewCell *)cellFromXibWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if(cell){
        return cell;
    }
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
    [tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([self class])];
    UITableViewCell * cell2 = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
    return cell2;//height for row
}
+ (__kindof UITableViewCell *)cellFromClassWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if(cell)
        return cell;
    [tableView registerClass:[self class] forCellReuseIdentifier:NSStringFromClass([self class])];
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
}
+ (__kindof UITableViewCell *)cellLoadNibNamed:(NSString *)name WithTableView:(UITableView *)tableView identifier:(NSString *)identifier{
    identifier = identifier ?: NSStringFromClass(self);
    id cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:name owner:self options:nil];
        for (UITableViewCell *nib_cell in nibs) {
            if([nib_cell.reuseIdentifier isEqualToString:identifier] || [nib_cell isMemberOfClass:self]){
                return nib_cell;
            }
        }
        if (cell == nil) {
            cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        return cell;
    }
    return cell;
}
@end



@implementation UITableViewHeaderFooterView (LLTool)
+ (__kindof UITableViewHeaderFooterView *)HeaderFooterViewFromXibWithTableView:(UITableView *)tableView{
    UITableViewHeaderFooterView * LLView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([self class])];
    if(LLView)
        return LLView;
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
    [tableView registerNib:nib forHeaderFooterViewReuseIdentifier:NSStringFromClass([self class])];
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([self class])];
}
/** 适用于class创建  */
+ (__kindof UITableViewHeaderFooterView *)HeaderFooterViewFromClassWithTableView:(UITableView *)tableView {
    UITableViewHeaderFooterView * LLView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([self class])];
    if(LLView)
        return LLView;
    [tableView registerClass:[self class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([self class])];
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([self class])];
}
@end
