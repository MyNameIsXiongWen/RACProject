//
//  ShoppingCartModel.h
//  RACProject
//
//  Created by jason on 2018/7/24.
//  Copyright © 2018年 xiaobu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ShopModel;
@interface ShoppingCartModel : NSObject

@property (nonatomic, strong) NSMutableArray <ShopModel *>*shopArray;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) NSInteger selectedCount;
@property (nonatomic, assign) NSInteger selectedGoodsCount;
@property (nonatomic, assign) BOOL selected;//选择状态

@end

@class GoodsModel;
@interface ShopModel : NSObject

@property (nonatomic, strong) NSMutableArray <GoodsModel *>*goodsArray;
@property (nonatomic, copy) NSString *shopName;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) BOOL hideRowContent;
@property (nonatomic, assign) NSInteger selectedCount;
@property (nonatomic, assign) BOOL selected;//选择状态

@end

@interface GoodsModel : NSObject

@property (nonatomic, copy) NSString *perPrice;//单价
@property (nonatomic, copy) NSString *allPrice;//总价
@property (nonatomic, copy) NSString *name;//商品名称
@property (nonatomic, copy) NSString *img;//图片
@property (nonatomic, assign) NSInteger num;//数量
@property (nonatomic, copy) NSString *skuAttrNames; //sku 信息
@property (nonatomic, assign) BOOL selected;//选择状态
@property (nonatomic, copy) NSString *countDownTime;
@property (nonatomic, assign) NSTimeInterval countDownTimeInterval;

@end
