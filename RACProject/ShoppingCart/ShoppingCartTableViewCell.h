//
//  ShoppingCartTableViewCell.h
//  RACProject
//
//  Created by jason on 2018/7/24.
//  Copyright © 2018年 xiaobu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartViewModel.h"

@interface ShoppingCartTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsSpecLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *countView;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (nonatomic, strong) ShoppingCartViewModel *shoppingVM;

- (void)bindViewModel:(ShoppingCartViewModel *)viewModel IndexPath:(NSIndexPath *)indexPath;
- (void)minusGoodsModelCountIndexPath:(NSIndexPath *)indexPath;
- (void)addGoodsModelCountIndexPath:(NSIndexPath *)indexPath;
- (void)selectGoodsModelCountIndexPath:(NSIndexPath *)indexPath;

@end
