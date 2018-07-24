//
//  ShoppingCartHeaderView.m
//  RACProject
//
//  Created by jason on 2018/7/24.
//  Copyright © 2018年 xiaobu. All rights reserved.
//

#import "ShoppingCartHeaderView.h"

@interface ShoppingCartHeaderView ()

@property (nonatomic, strong) UILabel *shopNameLabel;
@property (nonatomic, strong) UILabel *totalPriceLabel;

@end

@implementation ShoppingCartHeaderView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self layoutUI];
    }
    return self;
}

- (void)layoutUI {
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.equalTo(self);
    }];
    [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selectBtn.mas_right).offset(5);
        make.top.bottom.mas_equalTo(0);
    }];
    [self.totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.bottom.mas_equalTo(0);
    }];
    [self.selectBtn setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
}

- (void)bindViewModel:(ShoppingCartViewModel *)viewModel Section:(NSInteger)section {
    self.shoppingVM = viewModel;
    ShoppingCartModel *model = viewModel.shopArray[section];
    self.shopNameLabel.text = model.shopName;
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%.2f",model.price];
    self.selectBtn.selected = model.selected;
//    RAC(self.selectBtn, selected) = RACObserve(model, selected);
//    @weakify(self);
//    [RACObserve(self.selectBtn, selected) subscribeNext:^(id  _Nullable x) {
//        if ([x boolValue]) {
//            self_weak_.totalPriceLabel.text = [NSString stringWithFormat:@"%.2f",model.price];
//        }
//    }];
}

- (void)selectShopModelSection:(NSInteger)section {
    ShoppingCartModel *model = self.shoppingVM.shopArray[section];
    model.selected = !model.selected;
    for (GoodsModel *mmm in model.goodsArray) {
        mmm.selected = model.selected;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUI" object:[NSIndexPath indexPathWithIndex:section]];
}

- (UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [[UIButton alloc] init];
        [_selectBtn setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
        [self addSubview:_selectBtn];
    }
    return _selectBtn;
}

- (UILabel *)shopNameLabel {
    if (!_shopNameLabel) {
        _shopNameLabel = [[UILabel alloc] init];
        _shopNameLabel.font = [UIFont systemFontOfSize:15];
        _shopNameLabel.textColor = [UIColor colorFromHexString:@"323232"];
        [self addSubview:_shopNameLabel];
    }
    return _shopNameLabel;
}

- (UILabel *)totalPriceLabel {
    if (!_totalPriceLabel) {
        _totalPriceLabel = [[UILabel alloc] init];
        _totalPriceLabel.font = [UIFont systemFontOfSize:12];
        _totalPriceLabel.textColor = [UIColor colorFromHexString:@"ff7e26"];
        _totalPriceLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_totalPriceLabel];
    }
    return _totalPriceLabel;
}

@end