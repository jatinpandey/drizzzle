//
//  DRZServiceManager.h
//  Drizzzle
//
//  Created by Jatin Pandey on 11/1/16.
//  Copyright © 2016 JKP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRZServiceManager : NSObject

- (instancetype)initWithAccessToken:(NSString *)accessToken;

- (void)getShotsWithSortOrder:(NSString *)sortOrder completionBlock:(void (^)(NSArray *))completionBlock;

@end
