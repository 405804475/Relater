//
//  AFClient.h
//  Relater
//
//  Created by lanouhn on 15/7/27.
//  Copyright (c) 2015年 张万里. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface AFClient : AFHTTPRequestOperationManager

+ (AFClient *)shareClient;

@end
