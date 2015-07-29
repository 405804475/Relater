//
//  HomeModeTest.m
//  Relater
//
//  Created by lanouhn on 15/7/27.
//  Copyright (c) 2015年 张万里. All rights reserved.
//

#import "HomeModeTest.h"

@implementation HomeModeTest

- (instancetype)initWithDictiory:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.title = dic[@"title"];
        self.desc = dic[@"desc"];
        if (![dic[@"create_at"] isKindOfClass:[NSString class]]) {
            self.create_at = [NSString stringWithFormat:@"%@" , dic[@"create_at"]];
        } else {
            self.create_at = dic[@"create_at"];
        }
    }
    self.coverUrl = dic[@"cover"];
    self.picUrl = dic[@"pic"];
    self.video = dic[@"video"];
    self.nickName = dic[@"nickname"];
    self.movieUrlPlay = nil;
    return self;
}




@end
