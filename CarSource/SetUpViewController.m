//
//  SetUpViewController.m
//  CarSource
//
//  Created by apple on 15/12/19.
//  Copyright © 2015年 apple. All rights reserved.
//
//设置
#import "SetUpViewController.h"
#import "SetUpView.h"
#import "ChangeViewController.h"

@interface SetUpViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_setupTable;
    NSMutableArray *_setUpArray;
    UILabel *_cacheLabel;

}

@end

@implementation SetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _setUpArray = [[NSMutableArray alloc]initWithObjects:@"修改密码",@"意见反馈",@"清除缓存", nil];
    self.view.backgroundColor = [UIColor whiteColor];
    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"设置";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };
    _setupTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _setupTable.delegate = self;
    // 设置数据源
    _setupTable.dataSource = self;
    _setupTable.bounces = NO;
    _setupTable.backgroundColor = [UIColor colorWithRed:235/255.0 green:236/255.0 blue:241/255.0 alpha:1];
//    _setupTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self.view addSubview:_setupTable];

    SetUpView *setUp = [[SetUpView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240)];

    _setupTable.tableFooterView = setUp;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _setUpArray.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];

        if (indexPath.row == 2) {
            _cacheLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -150, 0, 140, 44)];
            _cacheLabel.textAlignment = NSTextAlignmentRight;
            _cacheLabel.textColor = [UIColor lightGrayColor];
            _cacheLabel.font = [UIFont systemFontOfSize:16];
            [cell addSubview:_cacheLabel];

        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.text = [_setUpArray objectAtIndex:indexPath.row];
    if (indexPath.row == 2) {
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    _cacheLabel.text = @"666K";
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            ChangeViewController * changeView = [[ChangeViewController alloc]init];
            [self.navigationController pushViewController:changeView animated:YES];
        }
            break;
        case 1:
        {

        }
            break;
        case 2:
        {

        }
            break;

        default:
            break;
    }
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
