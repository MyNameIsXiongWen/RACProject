//
//  ShoppingCartViewModel.m
//  RACProject
//
//  Created by jason on 2018/7/24.
//  Copyright © 2018年 xiaobu. All rights reserved.
//

#import "ShoppingCartViewModel.h"

@interface ShoppingCartViewModel ()

@property (nonatomic, strong, readwrite) RACCommand *allSelectCommand;
@property (nonatomic, strong, readwrite) RACCommand *accountCommand;
@property (nonatomic, assign) BOOL buttonSelected;

@end

@implementation ShoppingCartViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.accountCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [subscriber sendNext:@""];
                [subscriber sendCompleted];
                return [RACDisposable disposableWithBlock:^{
                    
                }];
            }];
        }];
        self.allSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                self.buttonSelected = !self.buttonSelected;
                for (ShoppingCartModel *cartModel in self.shopArray) {
                    cartModel.selected = self.buttonSelected;
                    for (GoodsModel *model in cartModel.goodsArray) {
                        model.selected = self.buttonSelected;
                    }
                }
                [subscriber sendNext:@(self.buttonSelected)];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return self;
}

- (void)getData {
    for (int i=0; i<4; i++) {
        ShoppingCartModel *cartModel = [ShoppingCartModel new];
        cartModel.shopName = [NSString stringWithFormat:@"店铺名称%d",i];
        cartModel.selected = NO;
        NSMutableArray *tempArray = @[].mutableCopy;
        for (int j=0; j<(arc4random()%2)+1; j++) {
            GoodsModel *model = [GoodsModel new];
            model.name = [NSString stringWithFormat:@"商品名%d",i];
            model.perPrice = [NSString stringWithFormat:@"%d",arc4random() % 100];
            model.skuAttrNames = [NSString stringWithFormat:@"商品规格%d",i];
            model.img = @"https://img.mankuhome.com/sku/5a2c3175436eacb84f83ab9e4fbcd69e3be0.jpeg";
            model.num = 1;
            model.selected = NO;
            [tempArray addObject:model];
        }
        cartModel.goodsArray = tempArray;
        [self.shopArray addObject:cartModel];
    }
}

- (NSMutableArray *)shopArray {
    if (!_shopArray) {
        _shopArray = @[].mutableCopy;
    }
    return _shopArray;
}

@end
