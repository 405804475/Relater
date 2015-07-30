//
//  HelpModel.h
//  Relater
//
//  Created by lanouhn on 15/7/29.
//  Copyright (c) 2015年 张万里. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HelpModel : NSObject

@property (nonatomic , copy) NSString *nickname;

@property (nonatomic , copy) NSString *desc;
@property (nonatomic , copy) NSString *picUrl;
@property (nonatomic , copy) NSString *backgroundUrl;
@property (nonatomic , copy) NSNumber *is_lecturer;
@property (nonatomic , copy) NSNumber *cate_id;
@property (nonatomic , copy) NSArray *lectures_with_cover;
@property (nonatomic , copy) NSString *ids;
@property (nonatomic , copy) NSString *id1;
@property (nonatomic , copy) NSString *title;
@property (nonatomic , copy) NSNumber *lecturer_id;
@property (nonatomic , copy) NSString *coverUrl;









- (instancetype)initWithDictionary:(NSDictionary *)dic;


@end
