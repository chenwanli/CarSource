//
//  TradingViewController.m
//  CarSource
//
//  Created by apple on 16/1/8.
//  Copyright © 2016年 apple. All rights reserved.
//
//交易担保
#import "TradingViewController.h"
#import "TradingView.h"
#import "TradingViewCell.h"
#import "DetailedViewController.h"
#import "GuaranteeDetailsViewController.h"

@interface TradingViewController ()<UITableViewDataSource,UITableViewDelegate>{

    UITableView *_tradingTable;

}

@end

@implementation TradingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = GRAY;

    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"交易担保";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };

    _tradingTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _tradingTable.delegate = self;
    // 设置数据源
    _tradingTable.dataSource = self;
    _tradingTable.bounces = NO;
    _tradingTable.rowHeight = 120;
    _tradingTable.backgroundColor = [UIColor colorWithRed:235/255.0 green:236/255.0 blue:241/255.0 alpha:1];
    _tradingTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self.view addSubview:_tradingTable];

    TradingView *trading = [[TradingView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 310)];
    _tradingTable.tableHeaderView = trading;

    trading.detailed = ^(NSString *detailed){

        DetailedViewController *detailedView = [[DetailedViewController alloc]init];
        [self.navigationController pushViewController:detailedView animated:YES];

    };

    trading.depositBtn = ^(NSString *depositBtn){

        GuaranteeDetailsViewController *guarantee = [[GuaranteeDetailsViewController alloc]init];
        [self.navigationController pushViewController:guarantee animated:YES];

    };

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 12;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    TradingViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if (!cell)
    {
        cell = [[TradingViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithRed:241/255.0 green:251/255.0 blue:255/255.0 alpha:1];
    //    cell.nameLabel.text = @"XXX代理商";
    cell.configuration.text = @"宝马520LI 4356  43.56万";
    cell.moneyStr = @"1000元";
    cell.userStr = @"孤独的爱";
    cell.timeLabel.text = @"五分钟";
    [cell initOtherGuaranteeViewCellText:@"XXX代理商"];
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


}


- (void)initTradingViewController:(UIButton *)button{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
