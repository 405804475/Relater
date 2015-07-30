//
//  ArtViewController.m
//  Relater
//
//  Created by lanouhn on 15/7/29.
//  Copyright (c) 2015年 张万里. All rights reserved.
//

#import "ArtViewController.h"

@interface ArtViewController ()

@property (nonatomic , strong) NetWorkHelper *netwoekHelper;

@end

@implementation ArtViewController

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];

    [ListView shareListView].ClickNumber = 0;
    self.netwoekHelper = [[NetWorkHelper alloc] init];
    
    [self.netwoekHelper netWorkWithUrl:self.url dataSource:self.dataSource];
    

    [self addSubViews];
    // Do any additional setup after loading the view.
}
- (void)addSubViews
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
