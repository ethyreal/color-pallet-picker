//
//  ETYColorPallet.h
//  ETYColorPalletPicker
//
//  Created by George Webster on 7/3/14.
//  Copyright (c) 2014 George Webster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETYColorPallet : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *colors;

+ (instancetype)palletWithName:(NSString *)name andColors:(NSArray *)colors;

- (instancetype)initWithName:(NSString *)name andColors:(NSArray *)colors;

@end
