//
//  UICollectionViewCell+LLTool.m
//  LLToolbox
//
//  Created by 骆亮 on 2019/12/25.
//

#import "UICollectionViewCell+LLTool.h"

@implementation UICollectionViewCell (LLTool)

+ (__kindof UICollectionViewCell *)cellFromClassWithCollectionView:(UICollectionView *)collectionView IndexPath:(NSIndexPath *)indexPath{
    [collectionView registerClass:self.class forCellWithReuseIdentifier:NSStringFromClass(self.class)];
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self.class) forIndexPath:indexPath];
    return cell;
}

+ (__kindof UICollectionViewCell *)cellFromXibWithCollectionView:(UICollectionView *)collectionView IndexPath:(NSIndexPath *)indexPath{
    UINib* nib = [UINib nibWithNibName:NSStringFromClass(self.class) bundle:NSBundle.mainBundle];
    [collectionView registerNib:nib forCellWithReuseIdentifier:NSStringFromClass(self.class)];
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self.class) forIndexPath:indexPath];
    return cell;
}

@end





@implementation UICollectionReusableView (LLTool)

+ (__kindof UIView *)viewFromClassWithCollectionView:(UICollectionView *)collectionView IndexPath:(NSIndexPath *)indexPath kind:(NSString *)kind{
    [collectionView registerClass:self.class forSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(self.class)];
    UIView* view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(self.class) forIndexPath:indexPath];
    return view;
}

+ (__kindof UIView *)viewFromXibWithCollectionView:(UICollectionView *)collectionView IndexPath:(NSIndexPath *)indexPath kind:(NSString *)kind{
    UINib* nib = [UINib nibWithNibName:NSStringFromClass(self.class) bundle:NSBundle.mainBundle];
    [collectionView registerNib:nib forSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(self.class)];
    UIView* view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(self.class) forIndexPath:indexPath];
    return view;
}

@end


