//
//  ResourcesViewController.m
//  CarSource
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ResourcesViewController.h"
#import "SalesView.h"
#import "AreLookingView.h"

@interface ResourcesViewController ()<UIScrollViewDelegate>{
    UIButton *_salesBtn;
    UIButton *_lookingBtn;
    UIScrollView *_scrollView;
    NSInteger _integer;
    SalesView *_sales;
    AreLookingView *_looking;
}

@end

@implementation ResourcesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//     self.view.backgroundColor = [UIColor redColor];
    _integer = 1;
    [self initResourcesViewTitle];
    [self initButton];

}
- (void)initResourcesViewTitle{

    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    titleView.backgroundColor = COLOR;
    [self.view addSubview:titleView];

    UIButton *guaranteeBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    guaranteeBtn.frame = CGRectMake(10, 20, 70, 40);
    [guaranteeBtn setTitle:@"交易担保" forState:UIControlStateNormal];
    guaranteeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [guaranteeBtn addTarget:self action:@selector(guaranteeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:guaranteeBtn];


    _salesBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    _salesBtn.frame = CGRectMake(SCREEN_WIDTH/2 - 65, 20, 60, 40);
    [_salesBtn setTitle:@"销售" forState:UIControlStateNormal];
    _salesBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    _salesBtn.tag = 100;
    [_salesBtn addTarget:self action:@selector(salesButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_salesBtn];

    _lookingBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    _lookingBtn.frame = CGRectMake(SCREEN_WIDTH/2 +5, 20, 60, 40);
    [_lookingBtn setTitle:@"求购" forState:UIControlStateNormal];
    [_lookingBtn setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
    _lookingBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    _lookingBtn.tag = 101;
    [_lookingBtn addTarget:self action:@selector(salesButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_lookingBtn];

    UIButton *releaseBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    releaseBtn.frame = CGRectMake(SCREEN_WIDTH - 60, 20, 50, 40);
    [releaseBtn setTitle:@"发布" forState:UIControlStateNormal];
    releaseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [releaseBtn addTarget:self action:@selector(releaseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:releaseBtn];

}
- (void)initButton{

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 109)];
    // 是否支持滑动最顶端
    //    scrollView.scrollsToTop = NO;
    _scrollView.delegate = self;
    // 设置内容大小
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2,SCREEN_HEIGHT - 109);
    // 是否反弹
    _scrollView.bounces = NO;
    // 是否分页
    _scrollView.pagingEnabled = YES;
    // 是否滚动
    //    scrollView.scrollEnabled = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.directionalLockEnabled = YES;
    [self.view addSubview:_scrollView];


    _sales = [[SalesView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _scrollView.frame.size.height)];
//    sales.backgroundColor = [UIColor blueColor];
    [_scrollView addSubview:_sales];
    __weak ResourcesViewController *resourcesView = self;
    _sales.brandTag = ^(NSInteger brandTag){
        resourcesView.brandTag(brandTag);
    };


    _looking = [[AreLookingView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, _scrollView.frame.size.height)];
//    looking.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:_looking];

    _looking.brandTag = ^(NSInteger brand){

        resourcesView.brand(brand);

    };

}
- (void)initProvincesStr:(NSString *)provincesStr provincesIdStr:(NSString *)provincesIdStr areaStr:(NSString *)areaStr isAop:(BOOL)isAop{

    if (isAop == YES) {
        [_sales provincesStr:provincesStr provincesIdStr:provincesIdStr areaStr:areaStr];
    }else{
        [_looking provincesStr:provincesStr provincesIdStr:provincesIdStr areaStr:areaStr];
    }

}
- (void)initMemberType:(NSString *)memberType memberTypeId:(NSString *)memberTypeId{
    [_sales initMemberType:memberType memberTypeId:memberTypeId];
}
- (void)initVehicleId:(NSString *)vehicleId vehicleName:(NSString *)vehicleName specificationId:(NSString *)specificationId isAop:(BOOL)isAop{
    if (isAop == YES) {
        [_sales initVehicleId:vehicleId vehicleName:vehicleName specificationId:specificationId];
    }else{
        [_looking initVehicleId:vehicleId vehicleName:vehicleName specificationId:specificationId];
    }

}

- (void)releaseButtonClick:(UIButton *)button{

//    NSLog(@"_integer = %ld",_integer);
    self.releaseTag(_integer);
}
- (void)guaranteeButtonClick:(UIButton *)button{

    self.guarantee(nil);

}
- (void)salesButtonClick:(UIButton *)button{

    if (button.tag == 100) {

        _integer = 1;
        [_salesBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        [_lookingBtn setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
        CGPoint position = CGPointMake(0, 0);
        [_scrollView setContentOffset:position animated:YES];

    }else{
        _integer = 2;
        [_salesBtn setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
        [_lookingBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        CGPoint position = CGPointMake(SCREEN_WIDTH, 0);
        [_scrollView setContentOffset:position animated:YES];
        [_looking initinstallationMJRefresh];

    }


}
// scrollView 已经滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    NSLog(@"scrollViewDidScroll  %f",scrollView.contentOffset.x );

    if (scrollView.contentOffset.x == SCREEN_WIDTH) {
        _integer = 2;
        [_looking initinstallationMJRefresh];
        [_salesBtn setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
        [_lookingBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    }else{
        _integer = 1;
        [_salesBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        [_lookingBtn setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
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
