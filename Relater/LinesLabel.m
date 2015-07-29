//
//  LinesLabel.m
//  Relater
//
//  Created by lanouhn on 15/7/27.
//  Copyright (c) 2015年 张万里. All rights reserved.
//

#import "LinesLabel.h"

@implementation LinesLabel


- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置label的preferredmaxLayoutWidth , 使之等于当前设备的宽度
    if (self.numberOfLines == 0) {
        if (self.preferredMaxLayoutWidth != self.frame.size.width) {
            self.preferredMaxLayoutWidth = self.frame.size.width;
            // 更新label的当前约束
            [self setNeedsUpdateConstraints];
        }
    }
}



- (CGSize)intrinsicContentSize
{
    CGSize size = [super intrinsicContentSize];
    // 高度+1 1px就是分割线
    if (self.numberOfLines == 0) {
        size.height += 1;
    }
    return size;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
