//
//  HomePageViewController.m
//  Relater
//
//  Created by lanouhn on 15/7/27.
//  Copyright (c) 2015年 张万里. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomeTableViewCell.h"
#import "HomeModeTest.h"
#import "PlayViewController.h"
#import "ListView.h"
@interface HomePageViewController () <UITableViewDelegate , UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *HomeTableView;

// 定义一个homepage页面所播放地址总接口的数组
@property (nonatomic , strong) NSMutableArray *allMovieUrlPlay;
// 定义一个数组来接受请求到最终能播放的地址的接口
@property (nonatomic , strong) NSMutableDictionary *allPlayUrl;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = [NSMutableArray array];
    self.allMovieUrlPlay = [NSMutableArray array];
    self.allPlayUrl = [NSMutableDictionary dictionary];
    self.HomeTableView.rowHeight = UITableViewAutomaticDimension;
//    self.HomeTableView.estimatedRowHeight = 300;
    [self getDataSource];
}

#pragma mark - 请求数据
- (void)getDataSource
{
    // 开始用AFN请求数据
    self.url = [kHost stringByAppendingString:@"album"];
    AFClient *afClient = [AFClient shareClient];

    [afClient GET:self.url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = responseObject;
        NSDictionary *originalDic = [NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *data1 = originalDic[@"data"];
        for (NSDictionary *maxDic in data1) {
            NSArray *lectures = maxDic[@"lectures"];
            NSDictionary *needDic = [lectures objectAtIndex:0];
            HomeModeTest *homeModel = [[HomeModeTest alloc] init];
            homeModel.create_at = needDic[@"created_at"];
            homeModel.title = needDic[@"title"];
            homeModel.coverUrl = needDic[@"cover"];
            homeModel.video = needDic[@"video"];
            NSDictionary *lecturer = needDic[@"lecturer"];
            homeModel.nickName = lecturer[@"nickname"];
            homeModel.desc = lecturer[@"desc"];
            homeModel.picUrl = lecturer[@"pic"];
            homeModel.movieUrlPlay = [NSString stringWithFormat:@"http://api.yixi.tv/youku.php?id=%@" , homeModel.video];
            [self.dataSource addObject:homeModel];
            [self.allMovieUrlPlay addObject:homeModel.movieUrlPlay];
            
        }
        [self getDataWithUrl];
        [self.HomeTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"解析出错 ，，，， %@" , error);
    }];
}

- (void)getDataWithUrl
{
    AFClient *afClient = [AFClient shareClient];
    for (int i = 0; i < self.allMovieUrlPlay.count; i++) {
        [afClient GET:self.allMovieUrlPlay[i] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSData *data = responseObject;
            NSDictionary *originalDic = [NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *files = originalDic[@"files"];
            NSDictionary *gphd = files[@"3gphd"];
            NSArray *segs = gphd[@"segs"];
            NSDictionary *needDic = [segs objectAtIndex:0];
            NSString *urlStr = needDic[@"url"];
            
            [self.allPlayUrl setValue:urlStr forKey:((HomeModeTest *)self.dataSource[i]).video];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"play , error --- %@" , error);
        }];

    }
    
}
#pragma mark - HomeTableView Delegate

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

//    static NSString *cellIdentifier = @"HomeCell";
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell" forIndexPath:indexPath];
//    if (cell == nil) {
//        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }
    
    HomeModeTest *homeModel = self.dataSource[indexPath.row];
    cell.neckname.text = homeModel.nickName;
    cell.title.text = homeModel.title;
    cell.create_at.text = homeModel.create_at;
    cell.desc.text = homeModel.desc;
    [cell.cover sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@" , homeModel.coverUrl]] placeholderImage:nil];
    [cell.pic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@" , homeModel.picUrl]] placeholderImage:nil];

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayViewController *playVC = [[PlayViewController alloc] init];
  
#warning 这里要传送过取一个播放地址
    NSString *urlStr = [self.allPlayUrl objectForKey:((HomeModeTest *)(self.dataSource[indexPath.row])).video];
    playVC.movieURL = [NSURL URLWithString:urlStr];
//    NSLog(@"++++++++++++++++++++已经拿到播放地址 , %@" ,((HomeModeTest *)(self.dataSource[indexPath.row])).title);
    NSLog(@"%@" , playVC.movieURL);
    [self presentViewController:playVC animated:YES completion:nil];
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 385;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 385;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [ListView shareListView].ClickNumber = 0;
    [ListView shareListView].hidden = YES;
}


// 隐藏导航条
//-(void)viewWillAppear:(BOOL)animated
//{
//    self.navigationController.navigationBarHidden = YES;
//}
//// 隐藏状态栏
//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
