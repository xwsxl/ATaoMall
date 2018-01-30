//
//  AirPlaneCollectionViewLayout.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/18.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AirPlaneCollectionViewLayout.h"

@interface AirPlaneCollectionViewLayout ()
@end

@implementation AirPlaneCollectionViewLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 55.0f);//头部视图的框架大小
        
        self.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/7, 40.0f);//每个cell的大小
        
        self.minimumLineSpacing = 0.0f;//每行的最小间距
        
        self.minimumInteritemSpacing = 0.0f;//每列的最小间距
        
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//网格视图的/上/左/下/右,的边距
    }
    
    return self;
}



//- (NSArray *) layoutAttributesForElementsInRect:(CGRect)rect {
//    
//    NSMutableArray *answer = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
//    UICollectionView * const cv = self.collectionView;
//    CGPoint const contentOffset = cv.contentOffset;
//    
//    NSMutableIndexSet *missingSections = [NSMutableIndexSet indexSet];
//    for (UICollectionViewLayoutAttributes *layoutAttributes in answer) {
//        if (layoutAttributes.representedElementCategory == UICollectionElementCategoryCell) {
//            [missingSections addIndex:layoutAttributes.indexPath.section];
//        }
//    }
//    for (UICollectionViewLayoutAttributes *layoutAttributes in answer) {
//        if ([layoutAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
//            [missingSections removeIndex:layoutAttributes.indexPath.section];
//        }
//    }
//    
//    [missingSections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
//        
//        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:idx];
//        
//        UICollectionViewLayoutAttributes *layoutAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
//        
//        [answer addObject:layoutAttributes];
//        
//    }];
//    
//    for (UICollectionViewLayoutAttributes *layoutAttributes in answer) {
//        
//        if ([layoutAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
//            
//            NSInteger section = layoutAttributes.indexPath.section;
//            NSInteger numberOfItemsInSection = [cv numberOfItemsInSection:section];
//            
//            NSIndexPath *firstObjectIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
//            NSIndexPath *lastObjectIndexPath = [NSIndexPath indexPathForItem:MAX(0, (numberOfItemsInSection - 1)) inSection:section];
//            
//            UICollectionViewLayoutAttributes *firstObjectAttrs;
//            UICollectionViewLayoutAttributes *lastObjectAttrs;
//            
//            if (numberOfItemsInSection > 0) {
//                firstObjectAttrs = [self layoutAttributesForItemAtIndexPath:firstObjectIndexPath];
//                lastObjectAttrs = [self layoutAttributesForItemAtIndexPath:lastObjectIndexPath];
//            } else {
//                firstObjectAttrs = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader
//                                                                        atIndexPath:firstObjectIndexPath];
//                lastObjectAttrs = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter
//                                                                       atIndexPath:lastObjectIndexPath];
//            }
//            
//            CGFloat headerHeight = CGRectGetHeight(layoutAttributes.frame);
//            CGPoint origin = layoutAttributes.frame.origin;
//            origin.y = MIN(
//                           MAX(
//                               contentOffset.y + cv.contentInset.top,
//                               (CGRectGetMinY(firstObjectAttrs.frame) - headerHeight)
//                               ),
//                           (CGRectGetMaxY(lastObjectAttrs.frame) - headerHeight)
//                           );
//            
//            layoutAttributes.zIndex = 1024;
//            layoutAttributes.frame = (CGRect){
//                .origin = origin,
//                .size = layoutAttributes.frame.size
//            };
//            
//        }
//        
//    }
//    
//    return answer;
//    
//}

//头部悬停
//- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBound {
//
//    return YES;
//
//}

@end
