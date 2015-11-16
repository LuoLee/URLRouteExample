//
//  ViewController.m
//  URLRouteExample
//
//  Created by lilo on 15/11/10.
//  Copyright © 2015年 lilo. All rights reserved.
//

#import "ViewController.h"
#import "UREFirstViewController.h"
#import <Masonry.h>

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic)           UIButton            *skipButton;
@property (strong, nonatomic)           UILabel             *descLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.frame = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@\n%@", self.skipButton, self.descLabel);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Util

- (void)skipToNextViewController
{
    UREFirstViewController *viewController = [UREFirstViewController new];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - UIView

- (UIButton *)skipButton
{
    if (!_skipButton) {
        _skipButton = [UIButton new];
        [_skipButton setTitle:@"GoIntoFirstViewController" forState:UIControlStateNormal];
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
