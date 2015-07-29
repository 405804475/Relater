//
//  SkimModel.m
//  Relater
//
//  Created by lanouhn on 15/7/29.
//  Copyright (c) 2015年 张万里. All rights reserved.
//

#import "SkimModel.h"

@implementation SkimModel


- (instancetype)initWithDictrionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.nickName = dic[@"nickname"];
        self.desc = dic[@"desc"];
        self.picUrl = dic[@"pic"];
    }
    return self;
}


@end
