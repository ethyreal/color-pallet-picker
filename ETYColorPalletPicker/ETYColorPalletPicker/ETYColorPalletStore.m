//
//  ETYColorPalletStore.m
//  ETYColorPalletPicker
//
//  Created by George Webster on 7/3/14.
//  Copyright (c) 2014 George Webster. All rights reserved.
//

#import "ETYColorPalletStore.h"
#import "ETYColorPallet.h"

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface ETYColorPalletStore ()

@property (nonatomic, strong) NSArray *pallets;

@end

@implementation ETYColorPalletStore


+ (instancetype)sharedStore
{
    static dispatch_once_t onceToken = 0;
    __strong static ETYColorPalletStore *_sharedObject = nil;
    
    dispatch_once(&onceToken, ^{
        _sharedObject = [[ETYColorPalletStore alloc] init];
    });
    
    return _sharedObject;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self setupPallets];
    }
    
    return self;
}

- (void)fetchPalletsWithSuccess:(void (^)(NSArray *pallets))success
                        failure:(void (^)(NSError *error))failure
{
    if (self.pallets) {
        success( self.pallets );
    } else {
        // TODO fetch remote data
    }
}

- (void)setupPallets
{
    NSString *nameRainbow       = @"Rainbow";
    
    NSArray *colorsRainbow      = @[RGB(242, 4, 4),
                                    RGB(255, 127, 0),
                                    RGB(255, 246, 0),
                                    RGB(0, 198, 23),
                                    RGB(1, 121, 255),
                                    RGB(225, 0, 252)];

    NSString *namePastels       = @"Pastels";
    
    NSArray *colorsPastels      = @[RGB(255,204,204),
                                    RGB(255,255,204),
                                    RGB(206,239,189),
                                    RGB(200,240,255),
                                    RGB(223, 194, 222),
                                    RGB(255, 158, 109)];

    NSString *nameNeutrals      = @"Neutrals";
    
    NSArray *colorsNeutrals     = @[RGB(255,255,255),
                                    RGB(163, 163, 163),
                                    RGB(0, 0, 0),
                                    RGB(105, 66, 0),
                                    RGB(212, 184, 130),
                                    RGB(242, 238, 215)];

    NSString *nameBlackWhite    = @"Black & White";
    
    NSArray *colorsBlackWhite   = @[RGB(255,255,255),
                                    RGB(232, 232, 232),
                                    RGB(210, 210, 210),
                                    RGB(160, 160, 160),
                                    RGB(96, 96, 96),
                                    RGB(0, 0, 0)];

    NSString *namePacificOcean  = @"Pacific Ocean";
    
    NSArray *colorsPacificOcean = @[RGB(134, 41, 11),
                                    RGB(255, 208, 107),
                                    RGB(78, 243, 66),
                                    RGB(30, 232, 255),
                                    RGB(96, 188, 188),
                                    RGB(52, 44, 203)];
    
    NSString *nameToyBoats      = @"Toy Boats";
    
    NSArray *colorsToyBoats     = @[RGB(247, 254, 255),
                                    RGB(184, 224, 230),
                                    RGB(28, 65, 99),
                                    RGB(252, 222, 171),
                                    RGB(199, 27, 24),
                                    RGB(200, 200, 200)];
    
    self.pallets = @[
                     [ETYColorPallet palletWithName:nameRainbow
                                          andColors:colorsRainbow],
                     [ETYColorPallet palletWithName:namePastels
                                          andColors:colorsPastels],
                     [ETYColorPallet palletWithName:nameNeutrals
                                          andColors:colorsNeutrals],
                     [ETYColorPallet palletWithName:nameBlackWhite
                                          andColors:colorsBlackWhite],
                     [ETYColorPallet palletWithName:namePacificOcean
                                          andColors:colorsPacificOcean],
                     [ETYColorPallet palletWithName:nameToyBoats
                                          andColors:colorsToyBoats]
                     ];
    
}

@end
