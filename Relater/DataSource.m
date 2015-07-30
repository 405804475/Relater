//
//  DataSource.m
//  Relater
//
//  Created by lanouhn on 15/7/29.
//  Copyright (c) 2015年 张万里. All rights reserved.
//

#import "DataSource.h"

@interface DataSource ()
@property (strong, nonatomic) NSArray *items;
@property (copy, nonatomic) NSString *cellIdentifier;
@property (copy, nonatomic) TableViewCellConfigureBlock configureCellBlock;
@end

@implementation DataSource
- (instancetype)init
{
    return nil;
}


- (instancetype)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIndentifier configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock
{
    self = [super init];
    if (self) {
        self.items = items;
        self.cellIdentifier = cellIndentifier;
        self.configureCellBlock = configureCellBlock;
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[(NSUInteger) indexPath.row];
}

#pragma mark - DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id item =  [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    return cell;
}




@end
