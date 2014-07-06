//
//  ETYColorPalletViewController.h
//  ETYColorPalletPicker
//
//  Created by George Webster on 7/3/14.
//  Copyright (c) 2014 George Webster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETYColorPalletViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UIImageView *backgroundView;

@end
