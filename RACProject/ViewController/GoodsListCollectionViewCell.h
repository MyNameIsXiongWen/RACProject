//
//  GoodsListCollectionViewCell.h
//  MANKUProject
//
//  Created by jason on 2018/6/25.
//  Copyright © 2018年 MANKU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsViewModel.h"

@interface GoodsListCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *goodsContentView;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodOriginalPriceLabel;

@property (weak, nonatomic) IBOutlet UIControl *shadowView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

- (void)bindViewModel:(GoodsViewModel *)viewModel withIndex:(NSInteger)index;

@end
