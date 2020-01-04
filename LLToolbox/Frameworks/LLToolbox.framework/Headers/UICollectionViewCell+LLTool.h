//
//  UICollectionViewCell+LLTool.h
//  LLToolbox
//
//  Created by 骆亮 on 2019/12/25.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewCell (LLTool)

+ (__kindof UICollectionViewCell *)cellFromClassWithCollectionView:(UICollectionView *)collectionView IndexPath:(NSIndexPath *)indexPath;
+ (__kindof UICollectionViewCell *)cellFromXibWithCollectionView:(UICollectionView *)collectionView IndexPath:(NSIndexPath *)indexPath;

@end




@interface UICollectionReusableView (LLTool)

+ (__kindof UIView *)viewFromClassWithCollectionView:(UICollectionView *)collectionView IndexPath:(NSIndexPath *)indexPath kind:(NSString*)kind;
+ (__kindof UIView *)viewFromXibWithCollectionView:(UICollectionView *)collectionView IndexPath:(NSIndexPath *)indexPath kind:(NSString*)kind;

@end

