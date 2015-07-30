//
//  TableBarViewController.m
//  Relater
//
//  Created by lanouhn on 15/7/28.
//  Copyright (c) 2015年 张万里. All rights reserved.
//

#import "TableBarViewController.h"
#import "ListView.h"
#import "ListModel.h"
#import "ArtViewController.h"
#import "HomelandViewController.h"
#import "ObserveViewController.h"
#import "TradeViewController.h"
#import "TechnologyViewController.h"
#import "BusinessViewController.h"
#import "OriginalityViewController.h"
#import "MannerViewController.h"
#import "AnnualViewController.h"
@interface TableBarViewController ()

//@property (nonatomic , assign) NSInteger ClickNumber;

@property (nonatomic , strong) NSDictionary *urlDic;

@end

@implementation TableBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.listView = [ListView shareListView];
    [self getDataWithUrl];
    
    [self addSubviews];
    
    self.listView.ClickNumber = 0;
}

- (NSMutableArray *)listArray
{
    if (!_listArray) {
        self.listArray = [NSMutableArray array];
        
    }
    return _listArray;
}

- (NSDictionary *)urlDic
{
    if (!_urlDic) {
        self.urlDic = [NSMutableDictionary dictionary];
    }
    return _urlDic;
}
- (void)addSubviews
{
    // 添加list点击事件
    [self.ListBar setTarget:self];
    [self.ListBar setAction:@selector(ListBarAction:)];
    
    
    
    self.listView.frame = CGRectMake(0, 64, 150, 360);
    self.listView.backgroundColor = [UIColor clearColor];
    
    
    self.listView.hidden = YES;
    [self.view addSubview:self.listView];
    
}
- (void)tapAction:(UITapGestureRecognizer *)sender
{
    self.listView.hidden = YES;
    self.listView.ClickNumber = 0;
}
- (void)ListBarAction:(UIBarButtonItem *)sender
{
//    if ((self.ClickNumber % 2) == 0) {
//        //            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
//        //            [self.view addGestureRecognizer:tap];
//        self.listView.hidden = NO;
//        //       NSLog(@"克拉克 . %ld" , (long)self.ClickNumber);
//        for (int i = 0; i < self.listArray.count; i++) {
//            [self setAnimateStart:i];
//        }
//        
//        self.ClickNumber++;
//        
//        
//    } else if ((self.ClickNumber % 2) == 1) {
//        for (int i = 0; i < self.listArray.count; i++) {
//            [self stopAnimation:i];
//        }
//        //        self.listView.hidden = YES;
//        
//        self.ClickNumber--;
//    }
    if ((self.listView.ClickNumber % 2) == 0) {
        //            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        //            [self.view addGestureRecognizer:tap];
        self.listView.hidden = NO;
        //       NSLog(@"克拉克 . %ld" , (long)self.ClickNumber);
        for (int i = 0; i < self.listArray.count; i++) {
            [self setAnimateStart:i];
        }
        
        self.listView.ClickNumber++;
        
        
    } else if ((self.listView.ClickNumber % 2) == 1) {
        for (int i = 0; i < self.listArray.count; i++) {
            [self stopAnimation:i];
        }
        //        self.listView.hidden = YES;
        
        self.listView.ClickNumber--;
    }

}

#pragma mark - 动画开始
- (void)setAnimateStart:(NSInteger )index
{
    
    CABasicAnimation *animation1 =
    [CABasicAnimation animationWithKeyPath:@"position.x"];
    
    // 起止点的设定
    //    NSLog(@"%f" , [self.listView viewWithTag:109 - index].frame.origin.x);
    animation1.toValue = [NSNumber numberWithFloat:[self.listView viewWithTag:100 + index].frame.origin.x - 150];; // 終点
    animation1.duration = 0 + 0.2 * index;
    animation1.removedOnCompletion = NO;
    
    [[self.listView viewWithTag:100 + index].layer addAnimation:animation1 forKey:@"move"];
    // 当移动完之后改变frame
    [self.listView viewWithTag:100 + index].frame = CGRectMake(0, 40 * index, 150, 40);
    
}

- (void)stopAnimation:(NSInteger)index
{
    CABasicAnimation *animation1 =
    [CABasicAnimation animationWithKeyPath:@"position.x"];
    
    // 起止点的设定
    //    NSLog(@"%f" , [self.listView viewWithTag:109 - index].frame.origin.x);
    animation1.toValue = [NSNumber numberWithFloat:[self.listView viewWithTag:108 - index].frame.origin.x - 150];; // 終点
    animation1.duration = 0 + 0.2 * index;
    animation1.removedOnCompletion = NO;
    
    [[self.listView viewWithTag:100 + index].layer addAnimation:animation1 forKey:@"Rotation"];
    // 当移动完之后改变frame
    [self.listView viewWithTag:100 + index].frame = CGRectMake(-150, 40 * index, 150, 40);
}

- (void)addViewsWithListArray:(NSMutableArray *)listArray
{
    
    NSArray *array = @[@"文艺" , @"家园" , @"观察" ,  @"科技" , @"行当" , @"商业" , @"创意" , @"态度" , @"年会"];
    
    for (int i = 0; i < listArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        NSString *name = array[i];
        [button setTitle:name forState:UIControlStateNormal];
        button.frame = CGRectMake(-150, 40 * i, 150, 40);
        button.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:139 / 255.0 blue:139 / 255.0 alpha:0.69];
        button.tintColor = [UIColor redColor];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(listButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.listView addSubview:button];
        
    }
    
}
#pragma mark - listButtonAction
- (void)listButtonAction:(UIButton *)sender
{
    
    switch (sender.tag) {
        case 100:{
            ArtViewController *artVC = [[ArtViewController alloc] init];
            NSLog(@"%@" , [self.urlDic valueForKey:@"3"]);
            artVC.url = [self.urlDic valueForKey:@"3"];
            [self.navigationController pushViewController:artVC animated:YES];
            
        }
            break;
        case 101:{
            
            HomelandViewController *artVC = [[HomelandViewController alloc] init];
            NSLog(@"%@" , [self.urlDic valueForKey:@"4"]);
            artVC.url = [self.urlDic valueForKey:@"4"];
            [self.navigationController pushViewController:artVC animated:YES];
        }
            break;
            
        case 102:{
            ObserveViewController *artVC = [[ObserveViewController alloc] init];
            NSLog(@"%@" , [self.urlDic valueForKey:@"5"]);
            [self.navigationController pushViewController:artVC animated:YES];
        }
            break;
        case 103:{
            TradeViewController *artVC = [[TradeViewController alloc] init];
            NSLog(@"%@" , [self.urlDic valueForKey:@"16"]);
            [self.navigationController pushViewController:artVC animated:YES];
        }
            break;
        case 104:{
            TechnologyViewController *artVC = [[TechnologyViewController alloc] init];
            NSLog(@"%@" , [self.urlDic valueForKey:@"19"]);
            [self.navigationController pushViewController:artVC animated:YES];
        }
            break;
        case 105:{
            BusinessViewController *artVC = [[BusinessViewController alloc] init];
            NSLog(@"%@" , [self.urlDic valueForKey:@"28"]);
            [self.navigationController pushViewController:artVC animated:YES];
        }
            break;
        case 106:{
            OriginalityViewController *artVC = [[OriginalityViewController alloc] init];
            NSLog(@"%@" , [self.urlDic valueForKey:@"46"]);
            [self.navigationController pushViewController:artVC animated:YES];
        }
            break;
        case 107:{
            MannerViewController *artVC = [[MannerViewController alloc] init];
            NSLog(@"%@" , [self.urlDic valueForKey:@"48"]);
            [self.navigationController pushViewController:artVC animated:YES];
        }
            break;
        case 108:{
            AnnualViewController *artVC = [[AnnualViewController alloc] init];
            NSLog(@"%@" , [self.urlDic valueForKey:@"50"]);
            [self.navigationController pushViewController:artVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}



#pragma mark - 请求数据
- (void)getDataWithUrl
{
    
    NSString *appendUrl = @"category/list";
    NSString *url = [kHost stringByAppendingString:appendUrl];
    AFClient *afClient = [AFClient shareClient];
    [afClient GET:url  parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = responseObject;
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"list解析时候 error = %@", error);
        NSArray *dataArr = dic[@"data"];
        for (NSDictionary *needDic in dataArr) {
            ListModel *model = [[ListModel alloc] init];
            model.ids = needDic[@"id"];
            model.name = needDic[@"name"];
            [self.listArray addObject:model];
            [self.urlDic setValue:[kHost stringByAppendingString:[NSString stringWithFormat:@"category/%@/lecturers" , model.ids]] forKey:[NSString stringWithFormat:@"%@" , model.ids]];
        }
        NSLog(@"asdf");
        // 添加中自定义视图
        [self addViewsWithListArray:self.listArray];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"list ， ，， AFN网络请求失败%@" , error);
    }];
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
