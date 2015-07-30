//
//  ListView.m
//  Relater
//
//  Created by lanouhn on 15/7/29.
//  Copyright (c) 2015年 张万里. All rights reserved.
//

#import "ListView.h"
#import "ListModel.h"

static ListView *listView = nil;

@implementation ListView

+ (ListView *)shareListView
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        listView = [[ListView alloc] init];
    });
    return listView;
    
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    if (nil == listView) {
        listView = [super allocWithZone:zone];
    }
    return listView;
}

- (id)copy
{
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        listView.ClickNumber = 0;
    }
    return self;
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
