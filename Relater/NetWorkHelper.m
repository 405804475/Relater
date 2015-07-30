//
//  NetWorkHelper.m
//  Relater
//
//  Created by lanouhn on 15/7/29.
//  Copyright (c) 2015年 张万里. All rights reserved.
//

#import "NetWorkHelper.h"

@implementation NetWorkHelper

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化数组 ， 给数组开空间

    }
    return self;
}

- (void)netWorkWithUrl:(NSString *)urlStr dataSource:(NSMutableArray *)dataSource
{
    AFClient *afClient = [AFClient shareClient];
        [afClient GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSData *intrinsicData = responseObject;
            NSError *error = nil;
            NSDictionary *data = [NSJSONSerialization JSONObjectWithData:intrinsicData options:NSJSONReadingMutableContainers error:&error];
            NSArray *dataArray = data[@"data"];
            for (NSDictionary *dic in dataArray) {
                HelpModel *model = [[HelpModel alloc] initWithDictionary:dic];
                [dataSource addObject:model];
            }
            NSLog(@"%@" ,dataSource);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}



@end
