//
//  DRZPostCollectionViewCell.m
//  Drizzzle
//
//  Created by Jatin Pandey on 10/29/16.
//  Copyright © 2016 JKP. All rights reserved.
//

#import "DRZPostCollectionViewCell.h"

@interface DRZPostCollectionViewCell ()

@end

@implementation DRZPostCollectionViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.imageView.superview != self) {
        [self addSubview:self.imageView];
    }
    self.imageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    if (self.imageView.image != self.image) {
        self.imageView.image = self.image;
    }
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:self.image];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

@end
