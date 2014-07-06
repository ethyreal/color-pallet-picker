//
//  ETYColorPalletFlowLayout.m
//  ETYColorPalletPicker
//
//  Created by George Webster on 7/5/14.
//  Copyright (c) 2014 George Webster. All rights reserved.
//

#import "ETYColorPalletFlowLayout.h"

@interface ETYColorPalletFlowLayout ()

@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;
@property (nonatomic, strong) NSMutableSet *visibleIndexPaths;
@property (nonatomic) CGFloat lastDelta;

@end

@implementation ETYColorPalletFlowLayout

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.minimumInteritemSpacing = 2;
        self.minimumLineSpacing = 5;
        
        self.itemSize = CGSizeMake(48, 48);
        
        self.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
        
        self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];

        self.visibleIndexPaths = [NSMutableSet set];
    }
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    // expand visable rect slightly to accounts for fast scrolling
    CGRect visableRect = CGRectZero;
    visableRect.origin = self.collectionView.bounds.origin;
    visableRect.size = self.collectionView.frame.size;
    
    CGRect visableRectExpanded = CGRectInset(visableRect, -100.f, -100.f);
    
    NSArray *itemsInVisibleRect = [super layoutAttributesForElementsInRect:visableRectExpanded];
    
    NSSet *indexPathsForItemsInVisibleRect = [NSSet setWithArray:[itemsInVisibleRect valueForKey:@"indexPath"]];
    
    // remove behavoirs no longer visable
    NSPredicate *removalPredicate = [NSPredicate predicateWithBlock:^BOOL(UIAttachmentBehavior *behaviour, NSDictionary *bindings) {
        BOOL isVisible = [indexPathsForItemsInVisibleRect member:[[[behaviour items] firstObject] indexPath]] != nil;
        return !isVisible;
    }];
    
    NSArray *behavoirsToRemove = [self.dynamicAnimator.behaviors filteredArrayUsingPredicate:removalPredicate];
    
    [behavoirsToRemove enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self.dynamicAnimator removeBehavior:obj];
        NSIndexPath *indexPath = [[[obj items] firstObject] indexPath];
        [self.visibleIndexPaths removeObject:indexPath];
    }];
    
    // add behaviours now visable
    NSPredicate *addPredicate = [NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *item, NSDictionary *bindings) {
        BOOL isVisible = [self.visibleIndexPaths member:item.indexPath] != nil;
        return !isVisible;
    }];
    
    NSArray *behavoirsToAdd = [itemsInVisibleRect filteredArrayUsingPredicate:addPredicate];

    CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
    
    [behavoirsToAdd enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *item, NSUInteger idx, BOOL *stop) {
        
        CGPoint center = item.center;
        
        UIAttachmentBehavior *behaviour = [[UIAttachmentBehavior alloc] initWithItem:item
                                                                    attachedToAnchor:center];
        
        behaviour.length = 0.0f;
        behaviour.damping = 0.8f;
        behaviour.frequency = 1.0f;

        // if touchlocation not 0,0 adjust
        
        if (!CGPointEqualToPoint(CGPointZero, touchLocation)) {
            CGFloat yDistanceFromTouch = fabsf(touchLocation.y - behaviour.anchorPoint.y);
            CGFloat xDistanceFromTouch = fabsf(touchLocation.x - behaviour.anchorPoint.x);
            CGFloat scrollResistance = ( yDistanceFromTouch + xDistanceFromTouch ) / 1500.f;

            if (self.lastDelta < 0) {
                center.y += MAX( self.lastDelta, self.lastDelta * scrollResistance );
            } else {
                center.y += MIN( self.lastDelta, self.lastDelta * scrollResistance );
            }
            
            item.center = center;
        }
        
        [self.dynamicAnimator addBehavior:behaviour];
        [self.visibleIndexPaths addObject:item.indexPath];

    }];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [self.dynamicAnimator itemsInRect:rect];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    UIScrollView *scrollView = self.collectionView;
    CGFloat delta = CGRectGetMinY(newBounds) - CGRectGetMinY(scrollView.bounds);
    
    self.lastDelta = delta;
    
    CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
    
    [self.dynamicAnimator.behaviors enumerateObjectsUsingBlock:^(UIAttachmentBehavior *springBehaviour, NSUInteger idx, BOOL *stop) {
        
        CGFloat yDistanceFromTouch = fabsf(touchLocation.y - springBehaviour.anchorPoint.y);
        CGFloat xDistanceFromTouch = fabsf(touchLocation.x - springBehaviour.anchorPoint.x);
        CGFloat scrollResistance = ( yDistanceFromTouch + xDistanceFromTouch ) / 1500.f;
        
        UICollectionViewLayoutAttributes *item = [springBehaviour.items firstObject];
        
        CGPoint center = item.center;
        
        if (delta < 0) {
            center.y += MAX( delta, delta * scrollResistance );
        } else {
            center.y += MIN( delta, delta * scrollResistance );
        }
        
        item.center = center;
        
        [self.dynamicAnimator updateItemUsingCurrentState:item];
        
    }];
    
    return NO;
}

@end
