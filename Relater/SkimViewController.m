//
//  SkimViewController.m
//  Relater
//
//  Created by lanouhn on 15/7/27.
//  Copyright (c) 2015年 张万里. All rights reserved.
//

#import "SkimViewController.h"
#import "SkimTableViewCell.h"
#import "SkimModel.h"
@interface SkimViewController ()<UITableViewDataSource , UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *skimTableView;


@end

@implementation SkimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = [NSMutableArray array];
    self.skimTableView.rowHeight = UITableViewAutomaticDimension;
    

    [self getDataWithUrl];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [ListView shareListView].ClickNumber = 0;
    [ListView shareListView].hidden = YES;
}
-(void)getDataWithUrl
{
    NSString *url = @"http://api.yixi.tv/api/v1/category/19/lecturers";
    AFClient *afClient = [AFClient shareClient];
    [afClient GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *intrinsicData = responseObject;
        NSError *error = nil;
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:intrinsicData options:NSJSONReadingMutableContainers error:&error];
        NSArray *dataArray = data[@"data"];
        for (NSDictionary *dic in dataArray) {
            SkimModel *model = [[SkimModel alloc] init];
            model.nickName = dic[@"nickname"];
            model.desc = dic[@"desc"];
            model.picUrl = dic[@"pic"];
            [self.dataSource addObject:model];
        }
        [self.skimTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SkimTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"skimCell" forIndexPath:indexPath];
    SkimModel *model = self.dataSource[indexPath.row];
    [cell.pic sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:nil];
    cell.desc.text = model.desc;
    cell.pic.layer.cornerRadius = 30;
    cell.pic.layer.masksToBounds = YES;
    cell.nickName.text = model.nickName;
    
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
