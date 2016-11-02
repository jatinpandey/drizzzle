//
//  DRZServiceManager.m
//  Drizzzle
//
//  Created by Jatin Pandey on 11/1/16.
//  Copyright © 2016 JKP. All rights reserved.
//

#import "DRZServiceManager.h"

#import "DRZNetworkManager.h"

@interface DRZServiceManager ()

@property (nonatomic) DRZNetworkManager *networkServiceManager;

@end

@implementation DRZServiceManager

- (instancetype)initWithAccessToken:(NSString *)accessToken {
    if (self = [super init]) {
        // init network service with value
        _networkServiceManager = [[DRZNetworkManager alloc] initWithAccessToken:accessToken];
    }
    return self;
}

- (void)getShotsWithSortOrder:(NSString *)sortOrder completionBlock:(void (^)(NSArray *))completionBlock {
    [self.networkServiceManager getShotsWithRecentAndCompletionBlock:completionBlock];
}

@end
