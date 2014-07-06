//
//  ETYColorPallet.m
//  ETYColorPalletPicker
//
//  Created by George Webster on 7/3/14.
//  Copyright (c) 2014 George Webster. All rights reserved.
//

#import "ETYColorPallet.h"

@implementation ETYColorPallet

+ (instancetype)palletWithName:(NSString *)name andColors:(NSArray *)colors
{
    return [[[self class] alloc] initWithName:name andColors:colors];
}

- (instancetype)initWithName:(NSString *)name andColors:(NSArray *)colors
{
    self = [super init];
    
    if (self) {
        
        _name = [name copy];
        _colors = colors;
    }
    
    return self;
}

@end
