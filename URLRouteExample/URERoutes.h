//
//  URERoutes.h
//  URLRouteExample
//
//  Created by lilo on 15/11/11.
//  Copyright © 2015年 lilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DeepLinkKit.h>

@interface URERoutes : NSObject
@property (strong, nonatomic)           DPLDeepLinkRouter           *deepLinkRoute;

+ (instancetype)shardInstance;

- (void)configURLPath;

@end
