//
//  HomePageViewController.h
//  Relater
//
//  Created by lanouhn on 15/7/27.
//  Copyright (c) 2015年 张万里. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageViewController : UIViewController
// 本页面的URL
@property (nonatomic , copy) NSString *url;
// 数组 ，用来接受请求到的数据
@property (nonatomic , strong) NSMutableArray *dataSource;



@end
