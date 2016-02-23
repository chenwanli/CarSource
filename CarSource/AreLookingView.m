//
//  AreLookingView.m
//  CarSource
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AreLookingView.h"
#import "AreLookingViewCell.h"
#import "SearchCarModel.h"
#import "SearchCarUserModel.h"

@interface AreLookingView ()<UITableViewDataSource,UITableViewDelegate>{

    UITableView *_areTable;
    UIButton *_btn;
    NSInteger _requestCount; // 1。表示默认列表数据 2 表示选择品牌 3选择地区
    NSInteger _state;
    NSInteger _stateCount;
    NSInteger _count;
    NSInteger _mjRefresh;
    NSMutableArray *_lookingArray;
    NSString *_provincesIdStr;
    NSString *_areaStr;
    NSString *_vehicleId;
    NSString *_specificationId;
}

@end
@implementation AreLookingView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{

    _mjRefresh = 1;
    _count = 1;
    _state = 1;
    _stateCount = 1;
    _requestCount = 1;

    _areTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 113) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _areTable.delegate = self;
    // 设置数据源
    _areTable.dataSource = self;
    _areTable.rowHeight = 130;
    _areTable.backgroundColor = [UIColor whiteColor];
    _areTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self addSubview:_areTable];

    _lookingArray = [[NSMutableArray alloc]init];

    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    bgView.backgroundColor = [UIColor whiteColor];
    UIButton *brandButton = [UIButton buttonWithType:UIButtonTypeCustom];

    brandButton.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 40);
    [brandButton setTitle:@"选择品牌" forState:UIControlStateNormal];
    brandButton.backgroundColor = [UIColor whiteColor];

    [brandButton setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
    brandButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [brandButton setTitleColor:[UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1]forState:UIControlStateSelected];
    brandButton.tag = 10;
    [brandButton addTarget:self action:@selector(brandButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:brandButton];

    UIButton *areaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    areaButton.backgroundColor = [UIColor whiteColor];
    areaButton.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 40);
    [areaButton setTitle:@"选择区域" forState:UIControlStateNormal];
    [areaButton setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
    areaButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [areaButton setTitleColor:[UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1]forState:UIControlStateSelected];
    areaButton.tag = 11;
    [areaButton addTarget:self action:@selector(brandButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:areaButton];


    UIImageView *image  = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 2, 1, 36)];
    image.backgroundColor = [UIColor colorWithRed:175/255.0 green:198/255.0 blue:225/255.0 alpha:1];
    [bgView addSubview:image];
    UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
    lineImage.backgroundColor = LIGHTBLUE;
    [bgView addSubview:lineImage];

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 10)];
    imageView.backgroundColor = GRAY;
    [bgView addSubview:imageView];

    _areTable.tableHeaderView = bgView;



}
- (void)initinstallationMJRefresh{
    if (_mjRefresh == 1) {
        _mjRefresh = 2;
         [self installationMJRefresh_2_GIF];
    }

}
- (void)provincesStr:(NSString *)provincesStr provincesIdStr:(NSString *)provincesIdStr areaStr:(NSString *)areaStr//选择区域
{
    UIButton *button = (UIButton *)[self viewWithTag:11];
    [button setTitle:provincesStr forState:UIControlStateNormal];
    _requestCount = 3;
    _provincesIdStr = provincesIdStr;
    _areaStr = areaStr;

    [self installationMJRefresh_2_GIF];
}
- (void)initVehicleId:(NSString *)vehicleId vehicleName:(NSString *)vehicleName specificationId:(NSString *)specificationId//选择品牌
{
    UIButton *button = (UIButton *)[self viewWithTag:10];
    [button setTitle:vehicleName forState:UIControlStateNormal];
    _vehicleId = vehicleId;
    _specificationId = specificationId;
    _requestCount = 2;
    [self installationMJRefresh_2_GIF];
}
- (void)installationMJRefresh_2_GIF
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 1; i<21; i++) {
        [arr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.tiff",i]]];
    }

    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData:)];
    // 隐藏刷新状态的文字
    //    footer.refreshingTitleHidden = YES;
    // 设置刷新图片
    [footer setImages:arr forState:MJRefreshStateRefreshing];
    [footer setImages:arr forState:MJRefreshStateIdle];
    [footer setImages:arr forState:MJRefreshStatePulling];
    _areTable.mj_footer = footer;

    [header setImages:arr forState:MJRefreshStateIdle];
    [header setImages:arr forState:MJRefreshStatePulling];
    [header setImages:arr forState:MJRefreshStateRefreshing];

    _areTable.mj_header = header;
    // 马上进入刷新状态
    [_areTable.mj_header beginRefreshing];

}
- (void)refresh
{
    _count = 1;
//    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];

    switch (_requestCount) {
        case 1:
        {
            [ResourcesRequest postGetTheDefaultSearchListRequestWithPage:@"1" showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {
                _stateCount = 2;
                if ([errorMessage isEqualToString:@"0"]){
                    [_lookingArray removeAllObjects];
                     _state = 2;
                    for (SearchCarModel *searchCar in saleArray) {
                        [_lookingArray addObject:searchCar];
                    }
                    
                }

            }];
        }
            break;
        case 2:
        {
            [ResourcesRequest postToObtainAListSpecifiedBrandForTheCarRequestWithBrandId:_vehicleId specificationId:_specificationId page:@"1" showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {

                _stateCount = 2;
                if ([errorMessage isEqualToString:@"0"]){
                    [_lookingArray removeAllObjects];
                    _state = 2;
                    for (SearchCarModel *searchCar in saleArray) {
                        [_lookingArray addObject:searchCar];
                    }

                }

            }];
        }
            break;
        case 3:
        {
            [ResourcesRequest postToObtainAListSpecifiedAreasForCarRequestWithCity:_provincesIdStr area:_areaStr page:@"1" showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {
                _stateCount = 2;
                if ([errorMessage isEqualToString:@"0"]){
                    [_lookingArray removeAllObjects];
                    _state = 2;
                    for (SearchCarModel *searchCar in saleArray) {
                        [_lookingArray addObject:searchCar];
                    }

                }
                
            }];

        }
            break;
        default:
            break;
    }

    // 为了看效果 延长3秒
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        if (_state == 2) {
            _state = 1;
            [_areTable reloadData];
        }
        if (_stateCount == 2) {
            _stateCount = 1;
            [_areTable.mj_header endRefreshing];
        }

    });

}

- (void)loadMoreData:(MJRefreshAutoGifFooter *)footer{
    _count ++;
    //    NSLog(@"_count  = %ld",_count);

    switch (_requestCount) {
        case 1:
        {
            [ResourcesRequest postGetTheDefaultSearchListRequestWithPage:[NSString stringWithFormat:@"%ld",(long)_count]  showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {
                _stateCount = 2;
                if ([errorMessage isEqualToString:@"0"]){
                    if (saleArray.count != 0) {
                        for (SearchCarModel *searchCar in saleArray) {
                            [_lookingArray addObject:searchCar];
                        }
                        _state = 2;
                    }

                }else{
                    [footer endRefreshingWithNoMoreData];
                }

            }];


        }
            break;
        case 2:
        {
            [ResourcesRequest postToObtainAListSpecifiedBrandForTheCarRequestWithBrandId:_vehicleId specificationId:_specificationId page:[NSString stringWithFormat:@"%ld",(long)_count]  showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {

                _stateCount = 2;
                if ([errorMessage isEqualToString:@"0"]){
                    if (saleArray.count != 0) {
                        for (SearchCarModel *searchCar in saleArray) {
                            [_lookingArray addObject:searchCar];
                        }
                        _state = 2;
                    }

                }else{
                    [footer endRefreshingWithNoMoreData];
                }

            }];

        }
            break;
        case 3:
        {
            [ResourcesRequest postToObtainAListSpecifiedAreasForCarRequestWithCity:_provincesIdStr area:_areaStr page:[NSString stringWithFormat:@"%ld",(long)_count] showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {
                _stateCount = 2;
                if ([errorMessage isEqualToString:@"0"]){
                    if (saleArray.count != 0) {
                        for (SearchCarModel *searchCar in saleArray) {
                            [_lookingArray addObject:searchCar];
                        }
                        _state = 2;
                    }

                }else{
                    [footer endRefreshingWithNoMoreData];
                }

            }];

        }
            break;
        default:
            break;
    }

    // 为了看效果 延长3秒
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_state == 2) {
            _state = 1;
            [_areTable reloadData];
        }
        if (_stateCount == 2) {
            _stateCount = 1;
            [_areTable.mj_footer endRefreshing];
        }
        
    });
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _lookingArray.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    AreLookingViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if (!cell)
    {
        cell = [[AreLookingViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithRed:241/255.0 green:251/255.0 blue:255/255.0 alpha:1];

    SearchCarModel *searchCar = [_lookingArray objectAtIndex:indexPath.row];
    SearchCarUserModel *userModel = [searchCar.searchCarUser objectAtIndex:indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@",userModel.userName];
    cell.searchLabel.text = @"急寻";
    cell.configuration.text = [NSString stringWithFormat:@"%@",searchCar.searchCarText];
    [cell.userImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,userModel.userUrl]] placeholderImage:[UIImage imageNamed:@"005.jpg"]];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithFormat:@"%@",searchCar.searchCarTime] doubleValue] / 1000];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-dd"];
    NSString *dateString = [dateFormat stringFromDate:date];
    cell.timeLabel.text = dateString;
    [cell initAuthenticateLabelArray:userModel.userAuthenticateList];

    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
- (void)brandButtonClick:(UIButton *)button{
    _btn.selected = NO;
    button.selected = YES;
    _btn = button;

    self.brandTag(button.tag -10);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
