//
//  SkimTableViewCell.m
//  Relater
//
//  Created by lanouhn on 15/7/28.
//  Copyright (c) 2015年 张万里. All rights reserved.
//

#import "SkimTableViewCell.h"

@implementation SkimTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews
{
    self.pic.layer.masksToBounds = YES;
    self.pic.layer.cornerRadius = 30;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
