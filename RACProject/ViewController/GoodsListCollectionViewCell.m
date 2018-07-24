//
//  GoodsListCollectionViewCell.m
//  MANKUProject
//
//  Created by jason on 2018/6/25.
//  Copyright © 2018年 MANKU. All rights reserved.
//

#import "GoodsListCollectionViewCell.h"
#import "GoodsListModel.h"

@interface GoodsListCollectionViewCell () <UIGestureRecognizerDelegate>
@end

@implementation GoodsListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.goodsContentView.backgroundColor = [UIColor whiteColor];
    self.goodsContentView.layer.shadowOffset = CGSizeMake(0, 0);
    self.goodsContentView.layer.shadowOpacity = 0.15;
    self.goodsContentView.layer.shadowRadius = 2;
    self.goodsContentView.layer.shadowColor = UIColor.blackColor.CGColor;
    self.goodsContentView.layer.cornerRadius = 10;
    self.goodsContentView.clipsToBounds = NO;
    
    self.deleteButton.layer.cornerRadius = 25;
    self.deleteButton.layer.masksToBounds = YES;
    
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPressGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressCell:)];
    longPressGes.delegate = self;
    longPressGes.minimumPressDuration = 1;
    [self addGestureRecognizer:longPressGes];
    
    [self.deleteButton rac_signalForSelector:@selector(deleteModel)];
}

- (void)deleteModel {
    
}

- (void)longPressCell:(UILongPressGestureRecognizer *)gesture {
    self.shadowView.hidden = NO;
    self.deleteButton.hidden = NO;
}

- (void)bindViewModel:(GoodsViewModel *)viewModel withIndex:(NSInteger)index {
    GoodsViewModel *goodsvm = viewModel;
    GoodsListModel *model = goodsvm.goodsArray[index];
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:OSS_URL(model.imgSrc)] placeholderImage:[UIImage imageNamed:@""]];
    self.goodsNameLabel.text = model.name;
    
    self.shadowView.hidden = YES;
    self.deleteButton.hidden = YES;
    
    NSString *string1 = [NSString stringWithFormat:@"¥ %@",model.price];
    NSMutableAttributedString *attribute1 = [[NSMutableAttributedString alloc] initWithString:string1];
    [attribute1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, 1)];
    NSString *string2 = [NSString stringWithFormat:@"¥ %@",model.defaultSkuOriginalPrice];
    NSMutableAttributedString *attribute2 = [[NSMutableAttributedString alloc] initWithString:string2 attributes:@{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
    self.goodsPriceLabel.attributedText = attribute1;
    self.goodOriginalPriceLabel.attributedText = attribute2;
}

- (IBAction)clickShadowView:(id)sender {
    self.shadowView.hidden = YES;
    self.deleteButton.hidden = YES;
}

@end
