//
//  ViewController.m
//  RACProject
//
//  Created by jason on 2018/7/20.
//  Copyright © 2018年 xiaobu. All rights reserved.
//

#import "ViewController.h"
#import "GoodsViewModel.h"
#import "GoodsListCollectionViewCell.h"
#import "ShoppingCartViewController.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) GoodsViewModel *goodsVM;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    RAC(self,textLabel.text) = self.textfield.rac_textSignal;
    self.goodsVM = [[GoodsViewModel alloc] init];
    self.btn.rac_command = self.goodsVM.btnCommand;
    @weakify(self)
    [self.goodsVM.btnCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.textLabel.text = x;
        [self presentViewController:[NSClassFromString(@"ShoppingCartViewController") new] animated:YES completion:nil];
    }];
    [self layoutCollectionView];
    [self.goodsVM.requestCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        [self.collectionView reloadData];
    }];
    [self.goodsVM.requestCommand execute:@1];
//    [self.goodsVM.requestSignal subscribeNext:^(id  _Nullable x) {
//        [self.collectionView reloadData];
//    }];
}

- (void)layoutCollectionView {
    [self.collectionView registerNib:[UINib nibWithNibName:@"GoodsListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [self.goodsVM.requestCommand execute:nil];
    }];
    self.collectionView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        [self.goodsVM.requestCommand execute:nil];
    }];
    [[self.goodsVM.requestCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable executing) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];
}

#pragma mark ------------UICollectionView Delegate-------------

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.goodsVM.goodsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodsListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell bindViewModel:self.goodsVM withIndex:indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((UIScreen.mainScreen.bounds.size.width-15)/2, 200);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)setTextfieldValue:(id)sender {
    
}


@end
