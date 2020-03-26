//
//  LLViewController.m
//  LLToolbox
//
//  Created by LOLITA0164 on 12/11/2019.
//  Copyright (c) 2019 LOLITA0164. All rights reserved.
//

#import "LLViewController.h"

#import <LLToolbox/LLToolbox.h>

#import "LLPerson.h"
#import "LLStudent.h"


@interface LLViewController ()

@property (strong, nonatomic) UIView* AView;

@property (strong, nonatomic) LLTimer* timer;

@end

@implementation LLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor.grayColor colorWithAlphaComponent:0.5];

    
    self.AView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.AView.backgroundColor = UIColor.rand;
    [self.view addSubview:self.AView];

    
    LLPerson* pp = [LLPerson objectWithModelDic:@{
        @"name":@"luoliang"
    }];
    [pp print];
    
    
    NSLog(@"当前库的版本：%@",LLToolKit.version);
    
    self.timer  = [LLTimer timeInertval:2.0 target:self selector:@selector(doSomething) userInfo:nil];
    
}


-(void)doSomething{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}



@end
