//
//  DRZNetworkManager.m
//  Drizzzle
//
//  Created by Jatin Pandey on 11/1/16.
//  Copyright © 2016 JKP. All rights reserved.
//

#import "DRZNetworkManager.h"

#import "ShotObject.h"

@interface DRZNetworkManager ()

@property (nonatomic) NSString *accessToken;

@end

@implementation DRZNetworkManager

- (instancetype)initWithAccessToken:(NSString *)accessToken {
    if (self = [super init]) {
        _accessToken = accessToken;
    }
    return self;
}

- (void)getShotsWithRecentAndCompletionBlock:(void (^)(NSArray *))completionBlock {
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *urlString = [NSString stringWithFormat:@"https://api.dribbble.com/v1/shots?sort=recent&timeframe=month&access_token=%@", self.accessToken];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSMutableArray *shots = [NSMutableArray array];
            for (NSDictionary *shot in json) {
                [shots addObject:[[ShotObject alloc] initWithDictionary:shot error:nil]];
            }
            
            if (completionBlock) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completionBlock(shots);
                });
            }
        } else if (completionBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(nil);
            });
        }
    }];
    
    [dataTask resume];
}



@end
