//
//  ETYColorPalletStore.h
//  ETYColorPalletPicker
//
//  Created by George Webster on 7/3/14.
//  Copyright (c) 2014 George Webster. All rights reserved.
//

#import <UIKit/UIkit.h>

@interface ETYColorPalletStore : NSObject

+ (instancetype)sharedStore;

- (void)fetchPalletsWithSuccess:(void (^)(NSArray *pallets))success
                        failure:(void (^)(NSError *error))failure;

@end
