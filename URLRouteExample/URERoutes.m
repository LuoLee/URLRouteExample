//
//  URERoutes.m
//  URLRouteExample
//
//  Created by lilo on 15/11/11.
//  Copyright © 2015年 lilo. All rights reserved.
//

#import "URERoutes.h"
#import "NSString+Hash.h"
#import "UREFirstViewController.h"
#import "URESecondViewController.h"
#import "AppDelegate.h"

@interface URERoutes ()

@end

@implementation URERoutes

+ (instancetype)shardInstance
{
    static dispatch_once_t once;
    static URERoutes *shardInstance = nil;
    dispatch_once(&once, ^{
        shardInstance = [[self alloc] init];
        shardInstance.deepLinkRoute = [DPLDeepLinkRouter new];
    });
    return shardInstance;
}

- (void)configURLPath
{
    __weak URERoutes *weakSelf = self;
    self.deepLinkRoute[@"/viewController/:hashString"] = ^(DPLDeepLink *link) {
        __strong URERoutes *strongSelf = weakSelf;
        NSString *hashString = link.routeParameters[@"hashString"];
        NSString *viewControllerTitle = link.queryParameters[@"title"];
        NSInteger colorType = [link.queryParameters[@"colorType"] integerValue];
        NSArray *colorTypes = @[[UIColor whiteColor], [UIColor orangeColor], [UIColor redColor], [UIColor greenColor]];
        if (colorType >= [colorTypes count] || colorType < 0) {
            colorType = [colorTypes count] - 1;
        }
        NSLog(@"%@\t%@\t", link.URL, hashString);
        if ([hashString isEqualToString:[[NSStringFromClass([URESecondViewController class]) SHA1] uppercaseString]]){
            // SHA1:6D2FB4B73E4927873EEF0A78DF96863FC3C83878
            URESecondViewController *viewController = [URESecondViewController new];
            viewController.title = [NSString stringWithFormat:@"SecondViewController-%@", viewControllerTitle];
            viewController.view.backgroundColor = colorTypes[colorType];
            [strongSelf showViewController:viewController];
        } else if ([hashString isEqualToString:[[NSStringFromClass([UREFirstViewController class]) SHA1] uppercaseString]]) {
            // SHA1:4658CF27F926A5EFB3A70E28FCC1906E4D751335
            NSString *hashID = link.queryParameters[@"hashID"];
            UREFirstViewController *viewController = [UREFirstViewController new];
            viewController.hashID = hashID;
            viewController.title = [NSString stringWithFormat:@"FirstViewController-%@", viewControllerTitle];
            viewController.view.backgroundColor = colorTypes[colorType];
            [strongSelf showViewController:viewController];
        }
    };
}

- (void)showViewController:(UIViewController*)viewController
{
    UIViewController *currentPresentViewController = [(AppDelegate*)[UIApplication sharedApplication].delegate topViewController];
    if ([[currentPresentViewController.navigationController viewControllers] count] >= 1) {
        // 位于导航控制器堆栈
        [currentPresentViewController.navigationController pushViewController:viewController animated:YES];
    } else {
        [currentPresentViewController presentViewController:viewController animated:YES completion:NULL];
    }
}

@end
