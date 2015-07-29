//
//  SkimTableViewCell.h
//  Relater
//
//  Created by lanouhn on 15/7/28.
//  Copyright (c) 2015年 张万里. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkimTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *pic;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *desc;

@end
