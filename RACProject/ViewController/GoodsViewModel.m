//
//  GoodsViewModel.m
//  RACProject
//
//  Created by jason on 2018/7/21.
//  Copyright © 2018年 xiaobu. All rights reserved.
//

#import "GoodsViewModel.h"
#import "GoodsListModel.h"

@interface GoodsViewModel ()

@property (nonatomic, readwrite, strong) NSMutableArray *goodsArray;
@property (nonatomic, assign) NSInteger page;

@end

@implementation GoodsViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.page = 1;
        self.btnCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [self excuteSignal];
        }];
        self.requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
//            return [self requestSignal];
            return [[self requestSignal] takeUntil:self.rac_willDeallocSignal];
        }];
    }
    return self;
}

- (RACSignal *)excuteSignal {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"传递数据"];
        [subscriber sendCompleted];
        return nil;
    }];
}

- (RACSignal *)requestSignal {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
        NSURLSessionDataTask *task = [manager GET:@"https://api.mankuhome.com/v1/api-search/item"
                                       parameters:@{@"pageNum":@(self.page),
                                                          @"pageSize":@(20)}
                                         progress:^(NSProgress * _Nonnull downloadProgress) {
                                                              
                                                          }
                                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                              if (self.page == 1) {
                                                                  self.goodsArray = [NSArray yy_modelArrayWithClass:GoodsListModel.class json:responseObject[@"data"][@"data"]].mutableCopy;
                                                              }
                                                              else {
                                                                  [self.goodsArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:GoodsListModel.class json:responseObject[@"data"][@"data"]]];
                                                              }
                                                              self.page ++;
                                                              [subscriber sendNext:self.goodsArray];
                                                              [subscriber sendCompleted];
                                                          }
                                          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                              [subscriber sendError:error];
                                                          }];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

@end
