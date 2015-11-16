//
//  URESecondViewController.m
//  URLRouteExample
//
//  Created by lilo on 15/11/10.
//  Copyright © 2015年 lilo. All rights reserved.
//

#import "URESecondViewController.h"
#import <Masonry.h>

@implementation URESecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.frame = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@\n%@", self.skipButton, self.descLabel);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"timer" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showTimer:)
                                                 name:@"timer"
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Util

- (void)showTimer:(NSNotification*)notification
{
    NSString *hashID = notification.userInfo[@"hashID"];
    if ([hashID isEqualToString:[NSString stringWithFormat:@"%lu", [self hash]]]) {
        CGFloat stayTime =  [notification.userInfo[@"stayTime"] floatValue];
        self.descLabel.text = [NSString stringWithFormat:@"%f", stayTime];
    }
}

- (void)skipToNextViewController
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *urlString = [NSString stringWithFormat:@"me.luolee.urlrouteexample://self/viewController/4658CF27F926A5EFB3A70E28FCC1906E4D751335?title=Safari&colorType=1&hashID=%lu", [self hash]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    });
}

#pragma mark - UIView

- (UIButton *)skipButton
{
    if (!_skipButton) {
        _skipButton = [UIButton new];
        [_skipButton setTitle:@"SkipToFirstViewController" forState:UIControlStateNormal];
        [_skipButton addTarget:self action:@selector(skipToNextViewController) forControlEvents:UIControlEventTouchUpInside];
        [_skipButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:_skipButton];
        [_skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@44);
            make.width.equalTo(self.view.mas_width).with.multipliedBy(0.8);
            make.centerX.equalTo(self.view.mas_centerX);
            make.centerY.equalTo(self.view.mas_centerY);
        }];
    }
    return _skipButton;
}

- (UILabel *)descLabel
{
    if (!_descLabel) {
        _descLabel = [UILabel new];
        _descLabel.backgroundColor = [UIColor purpleColor];
        [self.view addSubview:_descLabel];
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.skipButton.mas_bottom).with.offset(20);
            make.left.equalTo(self.view.mas_left).with.offset(10);
            make.right.equalTo(self.view.mas_right).with.offset(-10);
        }];
    }
    return _descLabel;
}

@end
