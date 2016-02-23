//
//  GuaranteeDetailsViewController.m
//  CarSource
//
//  Created by apple on 16/1/11.
//  Copyright © 2016年 apple. All rights reserved.
//
//担保详情
#import "GuaranteeDetailsViewController.h"
#import "GuaranteeDetailsViewCell.h"
#import "DetailsHeaderView.h"
#import "DetailsFooterView.h"
#import "MLSelectPhotoAssets.h"
#import "MLSelectPhotoPickerAssetsViewController.h"
#import "MLSelectPhotoBrowserViewController.h"
#import "ModelsToChooseViewController.h"
#import "InteriorColorViewController.h"

@interface GuaranteeDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>{

    NSMutableArray *_detailsArray;
    NSString *_carStr;
    NSString *_colorStr;


}
@property (nonatomic,strong)DetailsFooterView *footerView;
@property (nonatomic,strong)NSMutableArray *imageArray;
@property (nonatomic,strong)UITableView *detailsTable;
@end

@implementation GuaranteeDetailsViewController
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = GRAY;
    _detailsArray = [[NSMutableArray alloc]initWithObjects:@"交易车型",@"车辆颜色",@"成交价格",@"定金担保", nil];
    self.imageArray = [[NSMutableArray alloc]init];
    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"担保详情";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };

    _detailsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _detailsTable.delegate = self;
    // 设置数据源
    _detailsTable.dataSource = self;
    _detailsTable.bounces = NO;
    _detailsTable.backgroundColor = [UIColor whiteColor];
    _detailsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _detailsTable.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self.view addSubview:_detailsTable];

    DetailsHeaderView *headerView = [[DetailsHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 98)];
    _detailsTable.tableHeaderView = headerView;

    [self initDetailsFooterViewHeight:(SCREEN_WIDTH - 20)/3 +180];

}
- (void)initDetailsFooterViewHeight:(CGFloat)height{
    [self.footerView removeFromSuperview];

    self.footerView = [[DetailsFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    __weak typeof(self) weakSelf = self;
    self.footerView.addImage = ^(NSString *addImage){

        [weakSelf selectPhotos];

    };
    self.footerView.canceldelete = ^(NSString *canceldelete){
//        [weakSelf initDetailsFooterViewHeight:[weakSelf salesHeightViewArray:weakSelf.imageArray]+180];
        [weakSelf.footerView initAddImageArray:weakSelf.imageArray height:[weakSelf salesHeightViewArray:weakSelf.imageArray] cancel:YES];
    };

    self.footerView.deleteImage = ^(NSInteger deleteImage){

        [weakSelf.imageArray removeObjectAtIndex:deleteImage];

        CGFloat  height = [weakSelf salesHeightViewArray:weakSelf.imageArray];
        [weakSelf initDetailsFooterViewHeight: height+180];
        
        [weakSelf.footerView initAddImageArray:weakSelf.imageArray height:height cancel:NO];

    };

    self.footerView.toViewImage = ^(NSInteger toViewImage){

        MLSelectPhotoBrowserViewController *browserVc = [[MLSelectPhotoBrowserViewController alloc] init];
        browserVc.currentPage = toViewImage;
        browserVc.photos = weakSelf.imageArray;
        weakSelf.navigationController.navigationBarHidden = NO;
        [weakSelf.navigationController pushViewController:browserVc animated:YES];
    };


    _detailsTable.tableFooterView = self.footerView;

}
- (CGFloat)salesHeightViewArray:(NSMutableArray *)arr{

    if (arr.count != 0) {
        for (int i = 0; i < arr.count; i++) {
            if (i == arr.count -1) {
                int line= (i + 1)/3;//行号
                //1/3=0,2/3=0,3/3=1;
                if (arr.count<9) {
                    return (SCREEN_WIDTH - 20)/3*(line +1);

                }else{

                    return (SCREEN_WIDTH - 20)/3*line;
                }
            }
        }

    }else{

        return (SCREEN_WIDTH - 20)/3;
    }

    return 0;
}

#pragma mark - 选择相册
- (void)selectPhotos {
    // 创建控制器
    MLSelectPhotoPickerViewController *pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
    // 默认显示相册里面的内容SavePhotos
    pickerVc.topShowPhotoPicker = YES;
    pickerVc.status = PickerViewShowStatusCameraRoll;

    if (_imageArray.count == 0) {
        pickerVc.maxCount = 9;
    }else{
        pickerVc.maxCount = 9 - _imageArray.count;
    }

    [pickerVc showPickerVc:self];
    __weak typeof(self) weakSelf = self;
    pickerVc.callBack = ^(NSArray *assets){

        if (assets.count != 0) {
            [weakSelf.imageArray addObjectsFromArray:assets];
            CGFloat  height = [weakSelf salesHeightViewArray:weakSelf.imageArray];
            [weakSelf initDetailsFooterViewHeight:height +180];
            [weakSelf.footerView initAddImageArray:weakSelf.imageArray height:height cancel:NO];

        }
    };
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    GuaranteeDetailsViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if (!cell)
    {
        cell = [[GuaranteeDetailsViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        switch (indexPath.row) {
            case 0:
            {
                [cell initGuaranteeDetailsViewCell];
            }
                break;
            case 1:
            {
                [cell initGuaranteeDetailsViewCell];
            }
                break;
            case 2:
            {
                [cell initGuaranteeDetailsViewCellUnitText:@"万" placeholder:@"请输入报价"];
            }
                break;
            case 3:
            {
                [cell initGuaranteeDetailsViewCellUnitText:@"元" placeholder:@"请输入定金金额"];

            }
                break;
            case 4:
            {
                [cell initTextView];
            }
                break;

            default:
                break;
        }


    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.row == 4) {
        cell.typeLabel.hidden = YES;
        cell.image.hidden = YES;
    }else{
        cell.typeLabel.text = [_detailsArray objectAtIndex:indexPath.row];
    }

    switch (indexPath.row) {
        case 0:
        {
            cell.chooseLabel.text = _carStr;
        }
            break;

        case 1:
        {
            cell.chooseLabel.text = _colorStr;
        }
            break;
        case 2:
        {

        }
            break;
        case 3:
        {

        }
            break;
        case 4:
        {

        }
            break;

        default:
            break;
    }


    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) {
        case 0:
        {
            ModelsToChooseViewController *modelsView = [[ModelsToChooseViewController alloc]init];
            [self.navigationController pushViewController:modelsView animated:YES];

            modelsView.chooseType = ^(NSString *chooseType){
                _carStr = chooseType;
                [tableView reloadData];
            };
            

        }
            break;
        case 1:
        {
            InteriorColorViewController *interior = [[InteriorColorViewController alloc]init];
            [self.navigationController pushViewController:interior animated:YES];

            interior.interiorColor = ^(NSString *appearance, NSString *interiorColor,NSString *appearanceId, NSString *interiorColorId){
                _colorStr = interiorColor;
                [tableView reloadData];
            };



        }
            break;


        default:
            break;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) {
        return 170;
    }else{
        return 44;
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
