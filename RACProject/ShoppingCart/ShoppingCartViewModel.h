//
//  ShoppingCartViewModel.h
//  RACProject
//
//  Created by jason on 2018/7/24.
//  Copyright © 2018年 xiaobu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShoppingCartModel.h"

@interface ShoppingCartViewModel : NSObject

- (void)getData;
@property (nonatomic, strong, readonly) RACCommand *allSelectCommand;
@property (nonatomic, strong, readonly) RACCommand *accountCommand;
@property (nonatomic, strong) ShoppingCartModel *shopCartModel;

@end
