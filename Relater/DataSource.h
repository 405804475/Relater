//
//  DataSource.h
//  Relater
//
//  Created by lanouhn on 15/7/29.
//  Copyright (c) 2015年 张万里. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^TableViewCellConfigureBlock)(id cell , id item);

@interface DataSource : NSObject<UITableViewDataSource>

- (instancetype)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIndentifier configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
