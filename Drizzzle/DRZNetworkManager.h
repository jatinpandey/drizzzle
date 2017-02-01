//
//  DRZNetworkManager.h
//  Drizzzle
//
//  Created by Jatin Pandey on 11/1/16.
//  Copyright © 2016 JKP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRZNetworkManager : NSObject

- (instancetype)initWithAccessToken:(NSString *)accessToken;

- (void)getShotsWithRecentAndCompletionBlock:(void (^)(NSArray *))completionBlock;

@end
