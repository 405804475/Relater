//
//  PlayViewController.m
//  Relater
//
//  Created by lanouhn on 15/7/28.
//  Copyright (c) 2015年 张万里. All rights reserved.
//

#import "PlayViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "HouMoviePlayerView.h"

@interface PlayViewController ()

// 视频的现实页面
@property (nonatomic , strong) HouMoviePlayerView *houMoviePlayerView;

// 创建AVPlayer
@property (nonatomic , strong) AVPlayer *player;
// 判断点击时候是否隐藏控件
@property (nonatomic , assign) BOOL isFristTap;
@property (nonatomic , assign) BOOL isPlayOrParse;
// 保存改视频的资源的总时长 ， 快进或快退的时候要用
@property (nonatomic , assign) CGFloat totalMovieDuration;

@end

@implementation PlayViewController

// 使用MVC可以重写loadView方法 ， 也可以使用ViewDidLoad方法中直接加载View都可以使用 ， 方法自己取舍

- (void)loadView
{
    self.houMoviePlayerView = [[HouMoviePlayerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _houMoviePlayerView;
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [ListView shareListView].hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

   
    //  注册观察者用来观察，是否播放完毕
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    // 创建视频播放器层
    // AVPlayer需要显示必须创建 ， 必须创建一个播放器成的AVPlayerLayer用于展示 ， 播放器层继承于CALayer, 有了AVPlayerLayer添加到控制器的layer中即可
    // 创建显示层
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    // 设置frame
    CGRect frame = self.view.bounds;
    //    frame = CGRectMake(50, 30, 500, 300);
    frame.size.height = self.view.bounds.size.width;
    frame.size.width = self.view.bounds.size.height;
    playerLayer.frame = frame;
    
    // 这是视频的填充模式 ， 默认为AVLayerVideoGravityResizeAspect
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    // 插入到view的层面上 ，我没有用 addSulayer, 因为我想让播放的视图在最下层
    [self.view.layer insertSublayer:playerLayer atIndex:0];
    // 播放按钮的点击事件
    [self.houMoviePlayerView.playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    // 播放界面添加轻拍手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAllSubViews:)];
    [self.view addGestureRecognizer:tap];
    // 给音量滑竿设置事件
    [self.houMoviePlayerView.voiceSlider addTarget:self action:@selector(voiceSliderAction:) forControlEvents:UIControlEventValueChanged];
    
    //  给进度的滑杆设置事件
    [self.houMoviePlayerView.progressSlider addTarget:self action:@selector(scrubberIsScrolling:) forControlEvents:UIControlEventValueChanged];
    
    //  分享按钮的点击事件
    [self.houMoviePlayerView.shareButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //  收藏按钮的点击事件
    [self.houMoviePlayerView.collectionButton addTarget:self action:@selector(colletionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //  缓存按钮的点击事件
    [self.houMoviePlayerView.saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    // 返回按钮设置点击事件
    [self.houMoviePlayerView.backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}



#pragma mark - backButtonAction
- (void)backButtonAction:(UIButton *)sender
{
    [self.player pause];

    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - playButtonAction
- (void)playButtonAction:(UIButton *)sender
{
    NSLog(@"你点击了播放按钮");
#warning 两种方法 rate没有写
    // 在这里你可以自己设置bool 来判断是否正在播放或者已经停止 ， 也可以通过播放器自带的属性rata
    // 当rata为0时 ， 为暂停 ， 当rata为1时为长在播放
    if (!self.isPlayOrParse) {
        [self.player play];
        [sender setBackgroundImage:[UIImage imageNamed:@"播放器_暂停"] forState:UIControlStateNormal];
        self.isPlayOrParse = YES;
    } else{
        //  视屏播放器暂停
        [self.player pause];
        
        //  切换图片
        [sender setBackgroundImage:[UIImage imageNamed:@"播放器_播放"] forState:UIControlStateNormal];
        self.isPlayOrParse = NO;
        
    }
    
}

#pragma mark - dismissAllSubViews
// //  用于把上面的操作视图动画隐藏
- (void)dismissAllSubViews:(UITapGestureRecognizer *)sender
{
    // 防止循环引用
    __weak typeof(self) myself = self;
    if (!self.isFristTap) {
        [UIView animateWithDuration:0.2f animations:^{
            myself.houMoviePlayerView.topOperationView.frame = CGRectMake(0, -54, self.view.frame.size.width, 54);
            myself.houMoviePlayerView.bottomOperationView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 65);
            myself.houMoviePlayerView.leftOperationView.frame = CGRectMake(-45, 62, 45, 185);
            myself.houMoviePlayerView.rightOperationView.frame = CGRectMake(self.view.frame.size.width, 62, 45, 185);
            myself.isFristTap = YES;
            
            
        }];
    } else {
        [UIView animateWithDuration:.2f animations:^{
            
            myself.houMoviePlayerView.topOperationView.frame = CGRectMake(0, 0, self.view.frame.size.width, 54);
            myself.houMoviePlayerView.bottomOperationView.frame = CGRectMake(0, self.view.frame.size.height - 65, self.view.frame.size.width, 65);
            myself.houMoviePlayerView.leftOperationView.frame = CGRectMake(0, 62, 45, 185);
            myself.houMoviePlayerView.rightOperationView.frame = CGRectMake(self.view.frame.size.width - 45, 62, 45, 185);
            myself.isFristTap = NO;
        }];
        
    }
    
}

#pragma mark - voiceSliderAction
- (void)voiceSliderAction:(UISlider *)sender
{
    // 拿到sender的值
    [self.player setVolume:sender.value];
    if (sender.value == 0) {
        self.houMoviePlayerView.voiceImageView.image = [UIImage imageNamed:@"播放器_静音"];
        
    } else {
        self.houMoviePlayerView.voiceImageView.image = [UIImage imageNamed:@"播放器_音量"];
    }
    
}

#pragma mark - scrubberIsScrolling
- (void)scrubberIsScrolling:(UISlider *)sender
{
    // 先暂停
    [self.player pause];
    // 图片切换
    [self.houMoviePlayerView.playButton setBackgroundImage:[UIImage imageNamed:@"播放器_播放"] forState:UIControlStateNormal];
    // 得到的现在的进度
    float current = (float)(self.totalMovieDuration * sender.value);
    CMTime currentTime = CMTimeMake(current, 1);
    
    // 给player设置进度
    [self.player seekToTime:currentTime completionHandler:^(BOOL finished) {
        [self.houMoviePlayerView.playButton setBackgroundImage:[UIImage imageNamed:@"播放器_暂停"] forState:UIControlStateNormal];
        [self.player play];
    }];
}
#pragma mark - 播放结束后的代理回调
- (void)moviePlayDidEnd:(NSNotification *)notify
{
    // 更换播放按钮图片
    [self.houMoviePlayerView.playButton setBackgroundImage:[UIImage imageNamed:@"播放器_播放"] forState:UIControlStateNormal];
}
#pragma mark - 返回按钮

#pragma mark 分享按钮的点击事件
- (void)shareButtonAction:(UIButton *)sender
{
    NSLog(@"您点击了分享！");
}
#pragma mark 收藏按钮的点击事件
- (void)colletionButtonAction:(UIButton *)sender
{
    NSLog(@"您点击了收藏！");
}
#pragma mark 缓存按钮的点击事件
- (void)saveButtonAction:(UIButton *)sender
{
    NSLog(@"您点击了保存！");
}


// avplayer的懒加载
-(AVPlayer *)player
{
    if (!_player) {
        if (self.movieURL) {
            AVPlayerItem *item = [AVPlayerItem playerItemWithURL:self.movieURL];
            //                        NSLog(@"%@" , item.duration);
            self.player = [AVPlayer playerWithPlayerItem:item];
            // 添加观察进度
            [self addProgressObserver];
            [self addObserverToPlayerItem:item];
            
        }
    }
    return  _player;
}
//  依靠AVPlayer的- (id)addPeriodicTimeObserverForInterval:(CMTime)interval queue:(dispatch_queue_t)queue usingBlock:(void (^)(CMTime time))block方法获得播放进度，这个方法会在设定的时间间隔内定时更新播放进度，通过time参数通知客户端。相信有了这些视频信息播放进度就不成问题了，事实上通过这些信息就算是平时看到的其他播放器的缓冲进度显示以及拖动播放的功能也可以顺利的实现。

// 添加观察者
- (void)addProgressObserver
{
    // 获取当前媒体资源管理对象
    AVPlayerItem *playerItem = self.player.currentItem;
    __weak typeof(self) myself = self;
    
    // 设置每秒执行一次
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        // 获取当前进度
        float current = CMTimeGetSeconds(time);
        // 获取全部资源的大小
        float total = CMTimeGetSeconds([playerItem duration]);
        // 计算出进度
        if (current) {
            // 获取当前进度的百分比
            [myself.houMoviePlayerView.progressSlider setValue:(current / total) animated:YES];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:current];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            if (current / 3600 >= 1) {
                [formatter setDateFormat:@"HH:mm:ss"];
            } else {
                [formatter setDateFormat:@"00:mm:ss"];
                
            }
            NSString *showTime = [formatter stringFromDate:date];
            myself.houMoviePlayerView.startTimeLabel.adjustsFontSizeToFitWidth = YES;
            myself.houMoviePlayerView.startTimeLabel.text = showTime;
        }
        
    }];
}

//  这个方法，用来取得播放进度，播放进度就没有其他播放器那么简单了。在系统播放器中通常是使用通知来获得播放器的状态，媒体加载状态等，但是无论是AVPlayer还是AVPlayerItem（AVPlayer有一个属性currentItem是AVPlayerItem类型，表示当前播放的视频对象）都无法获得这些信息。当然AVPlayerItem是有通知的，但是对于获得播放状态和加载状态有用的通知只有一个：播放完成通知AVPlayerItemDidPlayToEndTimeNotification。在播放视频时，特别是播放网络视频往往需要知道视频加载情况、缓冲情况、播放情况，这些信息可以通过KVO监控AVPlayerItem的status、loadedTimeRanges属性来获得当AVPlayerItem的status属性为AVPlayerStatusReadyToPlay是说明正在播放，只有处于这个状态时才能获得视频时长等信息；当loadedTimeRanges的改变时（每缓冲一部分数据就会更新此属性）可以获得本次缓冲加载的视频范围（包含起始时间、本次加载时长），这样一来就可以实时获得缓冲情况。






- (void)addObserverToPlayerItem:(AVPlayerItem *)playItem
{
    // 监控状态属性 ， 注意AVplayer也有一个status属性 ， 通过监控他的status也可以获得播放状态
    [playItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    // 监控网络加载属性情况
    [playItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}

// 移除监听两个status ， loadedTimeRanges属性
- (void)removeObserverFromPlayerItem:(AVPlayerItem *)playerItem
{
    [playerItem removeObserver:self forKeyPath:@"status"];
    [playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}

// 观察者的方法 ， 会在加载好后触发， 我们可以在这个方法中 ，保存总文件的大小 ， 用于后面的进度实现
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    AVPlayerItem *playerItem = object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue];
        if (status == AVPlayerStatusReadyToPlay) {
            NSLog(@"正在播放 。。。。。视频总长度：%.2f" , CMTimeGetSeconds(playerItem.duration));
            CMTime totalTime = playerItem.duration;
            // 因为slider的值是小数 ， 所以要转换成float ， 当前时间和总时间相除才能得到小数 ，因为5/10 = 0
            self.totalMovieDuration = (CGFloat)totalTime.value/totalTime.timescale;
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:_totalMovieDuration];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            if (_totalMovieDuration/3600 >=1) {
                [formatter setDateFormat:@"HH:mm:ss"];
            }else{
                [formatter setDateFormat:@"00:mm:ss"];
            }
            NSString * showTimeNew = [formatter stringFromDate:date];
            self.houMoviePlayerView.endTimeLabel.adjustsFontSizeToFitWidth = YES;
            self.houMoviePlayerView.endTimeLabel.text = showTimeNew;
            
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSArray *array = playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue]; // 本次缓冲时间范围
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totalBuffer = startSeconds + durationSeconds; // 缓冲总长度
        NSLog(@"共缓冲：-----%.2f" , totalBuffer);
    }
}

// 进入改视图控制器自动横屏播放
- (BOOL)shouldAutorotate
{
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 移除观察者
- (void)dealloc
{
    [self removeObserverFromPlayerItem:self.player.currentItem];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemFailedToPlayToEndTimeNotification object:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
