//
//  ShotObject.h
//  Drizzzle
//
//  Created by Jatin Pandey on 11/1/16.
//  Copyright © 2016 JKP. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ShotImages : JSONModel

@property (nonatomic) NSString <Optional> *normal;
@property (nonatomic) NSString <Optional> *teaser;

@end

@interface ShotObject : JSONModel

@property (nonatomic, assign) NSInteger id;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString <Optional> *description;
@property (nonatomic) NSDictionary *images;

@end
