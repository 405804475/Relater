//
//  HomeModeTest.h
//  Relater
//
//  Created by lanouhn on 15/7/27.
//  Copyright (c) 2015年 张万里. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModeTest : NSObject

// 显示的图片
@property (nonatomic , copy) NSString *coverUrl;
// 标题
@property (nonatomic , copy) NSString *title;
// 播放地址
@property (nonatomic , copy) NSString *video;
// 讲述着名字
@property (nonatomic , copy) NSString *nickName;
// 讲述着介绍
@property (nonatomic , copy) NSString *desc;
// 时间
@property (nonatomic , copy) NSString *create_at;
// 讲述者头像
@property (nonatomic , copy) NSString *picUrl;

// 拼接好的播放地址的总接口
@property (nonatomic , copy) NSString *movieUrlPlay;

- (instancetype)initWithDictiory:(NSDictionary *)dic;

@end
