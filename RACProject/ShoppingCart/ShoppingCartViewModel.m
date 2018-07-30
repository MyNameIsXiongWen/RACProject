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
@property (nonatomic, assign) BOOL buttonSelected;

@end

@implementation ShoppingCartViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.allSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                self.buttonSelected = !self.buttonSelected;
                for (ShopModel *shopModel in self.shopCartModel.shopArray) {
                    shopModel.selected = self.buttonSelected;
                    for (GoodsModel *model in shopModel.goodsArray) {
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
    self.shopCartModel = [ShoppingCartModel new];
    self.shopCartModel.price = 0;
    self.shopCartModel.selected = NO;
    self.shopCartModel.selectedCount = 0;
    self.shopCartModel.shopArray = @[].mutableCopy;
    for (int i=0; i<4; i++) {
        ShopModel *shopModel = [ShopModel new];
        shopModel.shopName = [NSString stringWithFormat:@"店铺名称%d",i];
        shopModel.selected = NO;
        NSMutableArray *tempArray = @[].mutableCopy;
        for (int j=0; j<(arc4random()%2)+1; j++) {
            GoodsModel *model = [GoodsModel new];
            model.name = [NSString stringWithFormat:@"商品名%d",i];
            model.perPrice = [NSString stringWithFormat:@"%d",arc4random() % 100];
            model.skuAttrNames = [NSString stringWithFormat:@"商品规格%d",i];
            model.img = @"https://img.mankuhome.com/sku/5a2c3175436eacb84f83ab9e4fbcd69e3be0.jpeg";
            model.num = 1;
            model.selected = NO;
            model.countDownTimeInterval = [[NSString stringWithFormat:@"15046679%02d",arc4random()%100] integerValue];
            [tempArray addObject:model];
        }
        shopModel.goodsArray = tempArray;
        [self.shopCartModel.shopArray addObject:shopModel];
    }
    @weakify(self)
    [RACObserve(self.shopCartModel, selectedCount) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        if (self.shopCartModel.shopArray.count == [x integerValue]) {
            self.shopCartModel.selected = YES;
        }
        else {
            self.shopCartModel.selected = NO;
        }
    }];
}

- (void)countdown {
    for (ShopModel *shopM in self.shopCartModel.shopArray) {
        for (GoodsModel *goodsM in shopM.goodsArray) {
            goodsM.countDownTimeInterval--;
        }
    }
}

@end
