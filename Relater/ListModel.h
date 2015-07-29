//
//  ListModel.h
//  Relater
//
//  Created by lanouhn on 15/7/29.
//  Copyright (c) 2015年 张万里. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListModel : NSObject

@property (nonatomic , copy) NSString *name;
@property (nonatomic , strong) NSNumber *ids;


- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
