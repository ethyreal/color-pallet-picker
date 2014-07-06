//
//  ETYColorPalletViewController.m
//  ETYColorPalletPicker
//
//  Created by George Webster on 7/3/14.
//  Copyright (c) 2014 George Webster. All rights reserved.
//

#import "ETYColorPalletViewController.h"
#import "ETYColorPalletStore.h"
#import "ETYColorPallet.h"
#import "ETYColorCollectionViewCell.h"
#import "ETYPalletHeaderCollectionReusableView.h"
#import "ETYColorPalletFlowLayout.h"

@interface ETYColorPalletViewController () <UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *colorPallets;
@property (nonatomic, weak) ETYColorPalletFlowLayout *layout;

@end

@implementation ETYColorPalletViewController

static NSString * const colorCellReuseIdentifier = @"colorCollectionViewCellIdentifier";
static NSString * const palletHeaderReuseIdentifier = @"palletHeaderIdentifier";
static NSString * const palletSupplementaryViewKind = @"palletSupplementaryViewKind";

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    //self.clearsSelectionOnViewWillAppear = NO;
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    ETYColorPalletFlowLayout *layout = [[ETYColorPalletFlowLayout alloc] init];
    
    self.collectionView.collectionViewLayout = layout;
    
    self.layout = layout;
    
    // Register cell classes
    [self.collectionView registerClass:[ETYColorCollectionViewCell class] forCellWithReuseIdentifier:colorCellReuseIdentifier];
    [self.collectionView registerClass:[ETYPalletHeaderCollectionReusableView class]
            forSupplementaryViewOfKind:palletSupplementaryViewKind
                   withReuseIdentifier:palletHeaderReuseIdentifier];
    
    // Do any additional setup after loading the view.
    
    [[ETYColorPalletStore sharedStore] fetchPalletsWithSuccess:^(NSArray *pallets) {
        
        self.colorPallets = pallets;
        [self.collectionView reloadData];
        
        } failure:^(NSError *error) {
        
    }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark UICollectionViewDataSource Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.colorPallets count];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([self.colorPallets count] > section) {
        ETYColorPallet *pallet = self.colorPallets[section];
        return [pallet.colors count];
    }
    
    return 0;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    ETYPalletHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                           withReuseIdentifier:palletHeaderReuseIdentifier
                                                                                                  forIndexPath:indexPath];
    if ([self.colorPallets count] > indexPath.section) {
        
        ETYColorPallet *pallet = self.colorPallets[indexPath.section];
        
        headerView.textLabel.text = pallet.name;
    }
    
    return headerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ETYColorCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:colorCellReuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    if ([self.colorPallets count] > indexPath.section) {
        
        ETYColorPallet *pallet = self.colorPallets[indexPath.section];
        
        if ([pallet.colors count] > indexPath.row) {
            UIColor *color = pallet.colors[indexPath.row];
            
            cell.colorView.backgroundColor = color;
        }
    }
    
    return cell;
}

#pragma mark UICollectionViewDelegate Methods

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
	
}
*/

#pragma mark UICollectionViewDelegateFlowLayout Methods

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if ([self.colorPallets count] > section) {
        return CGSizeMake(CGRectGetWidth(self.collectionView.frame), 40.f);
    }
    return CGSizeZero;
}

@end
