//
//  ListModel.m
//  Relater
//
//  Created by lanouhn on 15/7/29.
//  Copyright (c) 2015年 张万里. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.ids = dic[@"id"];
        self.name = dic[@"name"];
    }
    return self;
}

@end
