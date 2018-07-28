//
//  ShoppingCartModel.m
//  RACProject
//
//  Created by jason on 2018/7/24.
//  Copyright © 2018年 xiaobu. All rights reserved.
//

#import "ShoppingCartModel.h"

@implementation ShoppingCartModel

- (CGFloat)price {
    CGFloat totalprice = 0;
    for (ShopModel *shopmodel in self.shopArray) {
        for (GoodsModel *model in shopmodel.goodsArray) {
            if (model.selected) {
                totalprice += model.num * model.perPrice.floatValue;
            }
        }
    }
    return totalprice;
}

- (NSInteger)selectedCount {
    NSInteger number = 0;
    for (ShopModel *shopmodel in self.shopArray) {
        if (shopmodel.selected) {
            number ++;
        }
    }
    return number;
}

- (NSInteger)selectedGoodsCount {
    NSInteger number = 0;
    for (ShopModel *shopmodel in self.shopArray) {
        for (GoodsModel *model in shopmodel.goodsArray) {
            if (model.selected) {
                number += model.num;
            }
        }
    }
    return number;
}

@end

@implementation ShopModel

- (CGFloat)price {
    CGFloat totalprice = 0;
    for (GoodsModel *model in self.goodsArray) {
        if (model.selected) {
            totalprice += model.num * model.perPrice.floatValue;
        }
    }
    return totalprice;
}

- (NSInteger)selectedCount {
    NSInteger number = 0;
    for (GoodsModel *model in self.goodsArray) {
        if (model.selected) {
            number += model.num;
        }
    }
    return number;
}

@end

@implementation GoodsModel

@end
