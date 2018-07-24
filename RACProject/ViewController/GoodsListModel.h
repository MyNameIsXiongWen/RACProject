//
// GoodsListModel.h
//  ManKuIPad
//
//  Created by YKK on 2018/4/4.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsListModel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *imgSrc;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *categoryCode;
@property (nonatomic, strong) NSString *defaultSkuOriginalPrice;
@property (nonatomic, strong) NSString *typeCode;//01:成品  02：定制

@property (nonatomic, copy, nullable) NSString *operationId;//收藏id
@property (nonatomic, assign) BOOL longPress;//是否长按
@property (nonatomic, assign) BOOL ineffective;//ture：失效

@end
