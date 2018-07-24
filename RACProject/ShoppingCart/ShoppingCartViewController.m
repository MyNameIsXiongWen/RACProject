//
//  ShoppingCartViewController.m
//  RACProject
//
//  Created by jason on 2018/7/24.
//  Copyright © 2018年 xiaobu. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShoppingCartViewModel.h"
#import "ShoppingCartTableViewCell.h"
#import "ShoppingCartHeaderView.h"

static NSString *const ShoppingCartCellIdentifier = @"ShoppingCartCell";
static NSString *const ShoppingCartHeaderViewIdentifier = @"ShoppingCartHeaderView";
@interface ShoppingCartViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIButton *accountButton;
@property (weak, nonatomic) IBOutlet UIButton *allSelectedBtn;
@property (nonatomic, strong) ShoppingCartViewModel *shoppingVM;

@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.shoppingVM = [[ShoppingCartViewModel alloc] init];
    [self.shoppingVM getData];
    self.accountButton.rac_command = self.shoppingVM.accountCommand;
    self.allSelectedBtn.rac_command = self.shoppingVM.allSelectCommand;
    [self.shoppingVM.accountCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.shoppingVM.allSelectCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        self.allSelectedBtn.selected = [x boolValue];
        [self.tableview reloadData];
    }];
    [self configTableView];
}

- (void)configTableView {
    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableview registerNib:[UINib nibWithNibName:@"ShoppingCartTableViewCell" bundle:nil] forCellReuseIdentifier:ShoppingCartCellIdentifier];
    [self.tableview registerClass:ShoppingCartHeaderView.class forHeaderFooterViewReuseIdentifier:ShoppingCartHeaderViewIdentifier];
    @weakify(self)
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"updateUI" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSIndexPath *indexpath = x.object;
        [self_weak_.tableview reloadSections:[NSIndexSet indexSetWithIndex:indexpath.section] withRowAnimation:UITableViewRowAnimationNone];
    }];
    [self.allSelectedBtn setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
    [self.allSelectedBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.shoppingVM.shopArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.shoppingVM.shopArray[section].goodsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ShoppingCartHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ShoppingCartHeaderViewIdentifier];
    [headerView bindViewModel:self.shoppingVM Section:section];
    [[[headerView.selectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:headerView.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [headerView selectShopModelSection:section];
    }];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ShoppingCartCellIdentifier];
    [cell bindViewModel:self.shoppingVM IndexPath:indexPath];
    [[[cell.minusButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [cell minusGoodsModelCountIndexPath:indexPath];
    }];
    [[[cell.addButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [cell addGoodsModelCountIndexPath:indexPath];
    }];
    [[[cell.selectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [cell selectGoodsModelCountIndexPath:indexPath];
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end