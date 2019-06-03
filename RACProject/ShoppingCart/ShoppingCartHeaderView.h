//
//  ShoppingCartHeaderView.h
//  RACProject
//
//  Created by jason on 2018/7/24.
//  Copyright © 2018年 xiaobu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartViewModel.h"

@interface ShoppingCartHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) UIButton *selectBtn;
- (void)bindViewModel:(ShoppingCartViewModel *)viewModel Section:(NSInteger)section;
- (void)selectShopModelSection:(NSInteger)section;
- (void)clickHeaderOfSection:(NSInteger)section;

@end
