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
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.countDownTimeInterval];
    self.goodsSpecLabel.text = [formatter stringFromDate:date];
    self.goodsPriceLabel.text = model.perPrice;
    self.numberTextField.text = [NSString stringWithFormat:@"%@",@(model.num)];
    self.selectBtn.selected = model.selected;
    @weakify(self)
    [RACObserve(model, countDownTimeInterval) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
//        NSTimeInterval ttt = x;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.countDownTimeInterval];
        self.goodsSpecLabel.text = [formatter stringFromDate:date];
    }];
    [RACObserve(model, num) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.minusButton.enabled = [x integerValue] > 1;
    }];
}

- (void)minusGoodsModelCountIndexPath:(NSIndexPath *)indexPath {
    ShopModel *shopModel = self.shoppingVM.shopCartModel.shopArray[indexPath.section];
    GoodsModel *model = shopModel.goodsArray[indexPath.row];
    if (model.num > 1) {
        model.num --;
    }
    self.numberTextField.text = [NSString stringWithFormat:@"%@",@(model.num)];
    if (shopModel.selected) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUI" object:indexPath];
    }
}

- (void)addGoodsModelCountIndexPath:(NSIndexPath *)indexPath {
    ShopModel *shopModel = self.shoppingVM.shopCartModel.shopArray[indexPath.section];
    GoodsModel *model = shopModel.goodsArray[indexPath.row];
    model.num ++;
    self.numberTextField.text = [NSString stringWithFormat:@"%@",@(model.num)];
    if (shopModel.selected) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUI" object:indexPath];
    }
}

- (void)selectGoodsModelCountIndexPath:(NSIndexPath *)indexPath {
    ShopModel *shopModel = self.shoppingVM.shopCartModel.shopArray[indexPath.section];
    GoodsModel *model = shopModel.goodsArray[indexPath.row];
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
