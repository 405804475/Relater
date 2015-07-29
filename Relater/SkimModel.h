//
//  SkimModel.h
//  Relater
//
//  Created by lanouhn on 15/7/29.
//  Copyright (c) 2015年 张万里. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SkimModel : NSObject

@property (nonatomic , copy) NSString *picUrl;
@property (nonatomic , copy) NSString *nickName;
@property (nonatomic , copy) NSString *desc;


- (instancetype)initWithDictrionary:(NSDictionary *)dic;
@end
