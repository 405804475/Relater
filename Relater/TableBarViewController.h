//
//  TableBarViewController.h
//  Relater
//
//  Created by lanouhn on 15/7/28.
//  Copyright (c) 2015年 张万里. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListView;
@interface TableBarViewController : UITabBarController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *ListBar;

@property (nonatomic , strong) ListView *listView;

@property (nonatomic , strong) NSMutableArray *listArray;


@end
