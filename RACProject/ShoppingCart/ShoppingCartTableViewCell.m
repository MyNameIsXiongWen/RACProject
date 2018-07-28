//
//  ShoppingCartTableViewCell.m
//  RACProject
//
//  Created by jason on 2018/7/24.
//  Copyright © 2018年 xiaobu. All rights reserved.
//

#import "ShoppingCartTableViewCell.h"
#import "ShoppingCartModel.h"

@implementation ShoppingCartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.countView.layer.borderColor = [UIColor colorFromHexString:@"cccccc"].CGColor;
    self.countView.layer.borderWidth = 0.5;
    self.numberTextField.layer.borderColor = [UIColor colorFromHexString:@"cccccc"].CGColor;
    self.numberTextField.layer.borderWidth = 0.5;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.selectBtn setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
    [self.numberTextField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)bindViewModel:(ShoppingCartViewModel *)viewModel IndexPath:(NSIndexPath *)indexPath {
    self.shoppingVM = viewModel;
    GoodsModel *model = viewModel.shopCartModel.shopArray[indexPath.section].goodsArray[indexPath.row];
    [self.goodsImgView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    self.goodsNameLabel.text = model.name;
    self.goodsSpecLabel.text = model.skuAttrNames;
    self.goodsPriceLabel.text = model.perPrice;
    self.numberTextField.text = [NSString stringWithFormat:@"%@",@(model.num)];
    self.selectBtn.selected = model.selected;
//    [RACObserve(self.selectBtn, selected) subscribeNext:^(id  _Nullable x) {
//        if ([x boolValue]) {
//            [viewModel.shopArray[indexPath.section] price];
//        }
//    }];
//    [RACObserve(model, num) subscribeNext:^(id  _Nullable x) {
//
//    }];
//    RAC(model,num) = [self.numberTextField rac_textSignal];
//    RAC(self.minusButton, enabled) = [RACObserve(model, num) map:^id(NSNumber * subvalue) {
//        return @(subvalue.integerValue > 1);
//    }];
}

- (void)minusGoodsModelCountIndexPath:(NSIndexPath *)indexPath {
    GoodsModel *model = self.shoppingVM.shopCartModel.shopArray[indexPath.section].goodsArray[indexPath.row];
    if (model.num > 1) {
        model.num --;
    }
    self.numberTextField.text = [NSString stringWithFormat:@"%@",@(model.num)];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUI" object:indexPath];
}

- (void)addGoodsModelCountIndexPath:(NSIndexPath *)indexPath {
    GoodsModel *model = self.shoppingVM.shopCartModel.shopArray[indexPath.section].goodsArray[indexPath.row];
    model.num ++;
    self.numberTextField.text = [NSString stringWithFormat:@"%@",@(model.num)];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUI" object:indexPath];
}

- (void)selectGoodsModelCountIndexPath:(NSIndexPath *)indexPath {
    GoodsModel *model = self.shoppingVM.shopCartModel.shopArray[indexPath.section].goodsArray[indexPath.row];
    model.selected = !model.selected;
    [self updateData:indexPath];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUI" object:indexPath];
}

- (void)updateData:(NSIndexPath *)indexPath {
    BOOL sel = YES;
    ShopModel *shopModel = self.shoppingVM.shopCartModel.shopArray[indexPath.section];
    for (GoodsModel *model in shopModel.goodsArray) {
        if (!model.selected) {
            sel = NO;
        }
    }
    shopModel.selected = sel;
    self.shoppingVM.shopCartModel.selectedCount = self.shoppingVM.shopCartModel.selectedCount;
}

- (void)textValueChanged:(UITextField *)textfield {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
