//
//  HelpModel.m
//  Relater
//
//  Created by lanouhn on 15/7/29.
//  Copyright (c) 2015年 张万里. All rights reserved.
//

#import "HelpModel.h"

@implementation HelpModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.id1 = dic[@"id"];
        self.nickname = dic[@"nickname"];
        self.desc = dic[@"desc"];
        self.picUrl = dic[@"pic"];
        self.backgroundUrl = dic[@"background"];
        self.is_lecturer = dic[@"is_lecturer"];
        self.cate_id = dic[@"cate_id"];
        self.lectures_with_cover = dic[@"lectures_with_cover"];
        if (self.lectures_with_cover.count != 0) {
            self.ids = self.lectures_with_cover[0][@"id"];
            self.title = self.lectures_with_cover[0][@"title"];
            self.lecturer_id = self.lectures_with_cover[0][@"lecturer_id"];
            self.coverUrl = self.lectures_with_cover[0][@"cover"];
        }
        
        
    }
    return self;
}


- (NSArray *)lectures_with_cover
{
    if (!_lectures_with_cover) {
        self.lectures_with_cover = [NSArray array];
    }
    return _lectures_with_cover;
}
@end
