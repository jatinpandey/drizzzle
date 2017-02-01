//
//  ShotObject.m
//  Drizzzle
//
//  Created by Jatin Pandey on 11/1/16.
//  Copyright © 2016 JKP. All rights reserved.
//

#import "ShotObject.h"

@implementation ShotObject

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"shotId": @"id",
                                                                  @"title": @"title",
                                                                  @"shotDescription": @"description",
                                                                  @"images": @"images"
                                                                  }];
}

@end
