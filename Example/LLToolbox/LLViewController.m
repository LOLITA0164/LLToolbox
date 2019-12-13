//
//  LLViewController.m
//  LLToolbox
//
//  Created by LOLITA0164 on 12/11/2019.
//  Copyright (c) 2019 LOLITA0164. All rights reserved.
//

#import "LLViewController.h"
#import <LLToolCategory.h>

#import "LLPerson.h"
#import "LLStudent.h"

#import "LLAlertView.h"
#import <LLToolView.h>

@interface LLViewController ()<UITableViewDelegate,UITableViewDataSource,LLNestedTableViewProtocol>
@property (strong, nonatomic) LLNestedTableView* mainTable;
@property (strong, nonatomic) LLNestedTableView* subTable;
@end

@implementation LLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.brownColor;

    
    self.mainTable = [self getATable];
    self.mainTable.delegateNested = self;
    self.mainTable.typeNested = LLNestedTableViewTypeMain;
    [self.view addSubview:self.mainTable];
    
    self.subTable = [self getATable];
    self.subTable.typeNested = LLNestedTableViewTypeSub;
}


-(LLNestedTableView*)getATable{
    LLNestedTableView* table = [[LLNestedTableView alloc] initWithFrame:UIScreen.mainScreen.bounds style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    return table;
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell* cell = [UITableViewCell cellFromClassWithTableView:tableView IndexPath:indexPath];
    cell.selectionStyle = NO;
    cell.textLabel.text = [NSString stringWithFormat:@"%ld + %ld",(long)((LLNestedTableView*)tableView).typeNested, indexPath.row];
    if (tableView == self.mainTable && indexPath.row == 20 - 1) {
        [cell addSubview:self.subTable];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.mainTable) {
        if (indexPath.row == 20 - 1) {
            return UIScreen.mainScreen.bounds.size.height - 64;
        }
        return 60;
    }
    return 100;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.mainTable) {
        return 20;
    }
    return 30;
}

- (CGFloat)llNestedTableViewStayPosition:(LLNestedTableView *)tableView {
    return [tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:20-2 inSection:0]].origin.y;
}


@end
