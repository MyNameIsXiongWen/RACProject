//
//  GoodsViewModel.h
//  RACProject
//
//  Created by jason on 2018/7/21.
//  Copyright © 2018年 xiaobu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsViewModel : NSObject

@property (nonatomic, strong) RACCommand *btnCommand;
@property (nonatomic, strong) RACCommand *requestCommand;
@property (nonatomic, readonly, strong) NSMutableArray *goodsArray;

@property (nonatomic, strong) RACSignal *requestSignal;

@end
