//
//  HomeTableViewCell.h
//  Relater
//
//  Created by lanouhn on 15/7/27.
//  Copyright (c) 2015年 张万里. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UIImageView *pic;
@property (weak, nonatomic) IBOutlet UILabel *create_at;
@property (weak, nonatomic) IBOutlet UILabel *neckname;
@property (weak, nonatomic) IBOutlet UILabel *desc;

@end
