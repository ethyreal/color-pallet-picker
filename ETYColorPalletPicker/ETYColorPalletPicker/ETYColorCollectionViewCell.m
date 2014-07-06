//
//  ETYColorCollectionViewCell.m
//  ETYColorPalletPicker
//
//  Created by George Webster on 7/4/14.
//  Copyright (c) 2014 George Webster. All rights reserved.
//

#import "ETYColorCollectionViewCell.h"

@implementation ETYColorCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if (self) {
        // Initialization code
        
        UIView *cv = [[UIView alloc] initWithFrame:CGRectInset(self.contentView.frame, 4.f, 4.f)];
        
        [self.contentView addSubview:cv];
        
        self.colorView = cv;
        
    }
    return self;
}

@end
