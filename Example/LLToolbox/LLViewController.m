//
//  LLViewController.m
//  LLToolbox
//
//  Created by LOLITA0164 on 12/11/2019.
//  Copyright (c) 2019 LOLITA0164. All rights reserved.
//

#import "LLViewController.h"
#import <LLToolbox/LLToolCategory.h>
#import <LLTOolbox/LLToolFunction.h>

#import "LLPerson.h"
#import "LLStudent.h"

#import "LLAlertView.h"


@interface LLViewController ()

@property (strong, nonatomic) UIView* AView;

@end

@implementation LLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.brownColor;

    
    self.AView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.AView.backgroundColor = LLToolbox.randColor;
    [self.view addSubview:self.AView];

    
    
}





@end
