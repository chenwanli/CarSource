//
//  CertificationViewController.m
//  CarSource
//
//  Created by apple on 16/1/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CertificationViewController.h"
#import "CertificationViewCell.h"
#import "MLSelectPhotoPickerAssetsViewController.h"
#import "MLSelectPhotoBrowserViewController.h"
#import "ModelsToChooseViewController.h"


@interface CertificationViewController ()<UITableViewDataSource,UITableViewDelegate>{

    NSArray *_typeArray;
}
@property (nonatomic,strong) NSMutableArray *cardArray;
@property (nonatomic,strong) NSMutableArray *businessArray;
@property (nonatomic,strong) NSMutableArray *proveArray;
@property (nonatomic,assign) CGFloat card;
@property (nonatomic,assign) CGFloat business;
@property (nonatomic,assign) CGFloat prove;
@property (nonatomic,strong) UITableView *certification;
@property (nonatomic,strong) CertificationViewCell *cell;
@property (nonatomic,strong) UIButton *cancelButton;
@property (nonatomic,assign) NSInteger cancel;
@end

@implementation CertificationViewController
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    if ([[UIDevice currentDevice] systemVersion].floatValue>=7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    self.cardArray = [[NSMutableArray alloc]init];
    self.businessArray = [[NSMutableArray alloc]init];
    self.proveArray = [[NSMutableArray alloc]init];
    self.card = 0;
    self.business = 0;
    self.prove = 0;

    _typeArray = [[NSArray alloc]initWithObjects:@"姓名",@"证件号码",@"身份证",@"名片",@"其他证明", nil];
    self.certification = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT -64) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
   self.certification.delegate = self;
    // 设置数据源
   self.certification.dataSource = self;
    self.certification.bounces = NO;
    //    _commissionedTable.scrollEnabled = NO;
    self.certification.backgroundColor = [UIColor whiteColor];
//    _certification.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self.view addSubview:self.certification];

    [self initCertificationView];
}

- (void)initCertificationView{
    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"申请认证";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };

    self.cancelButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame = CGRectMake(SCREEN_WIDTH - 100, 10, 100, 54);
    [self.cancelButton setTitle:@"取消删除" forState:UIControlStateNormal];
    [self.cancelButton setTitle:@"删除" forState:UIControlStateSelected];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelButton];
    self.cancelButton.hidden = YES;
    self.cancel = 1;

    UIView *submitView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    submitView.backgroundColor = GRAY;

    UIButton *submitButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    submitButton.frame = CGRectMake(50,30, SCREEN_WIDTH - 100, 50);
    submitButton.titleLabel.font = [UIFont systemFontOfSize:16];
    submitButton.layer.cornerRadius = 5;
    submitButton.layer.masksToBounds = YES;
    //    [_submitButton setTitleColor:COLOR forState:UIControlStateNormal];
    submitButton.backgroundColor = COLOR;
    [submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [submitView addSubview:submitButton];

    self.certification.tableFooterView = submitView;
    

}
- (void)submitButtonClick:(UIButton *)button{

}

- (void)cancelButtonClick:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected) {
        self.cancel = 0;
    }else{
        self.cancel = 1;
    }

    [self.certification reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _typeArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    self.cell = [tableView cellForRowAtIndexPath:indexPath];

    if (!self.cell)
    {
        self.cell = [[CertificationViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
         __weak typeof(self) weakSelf = self;
        switch (indexPath.row) {
            case 0:
            {
                [self.cell initCertificationViewCellNameText:@"请填写您身份证上的名字"];
            }
                break;
            case 1:
            {
                [self.cell initCertificationViewCellNameText:@"请填写您身份证上的号码"];
            }
                break;
            case 2:
            {
                if (self.cardArray.count == 0) {
                     self.card = 0;
                    [self.cell certificationViewCell];
                }else{

                    [self.cell initAddImageArray:self.cardArray height:(SCREEN_WIDTH - 20)/3 cancel:self.cancel];
                    self.cell.deleteBtn = ^(NSInteger deleteBtn){
                        [weakSelf.cardArray removeObjectAtIndex:deleteBtn];
                         weakSelf.card = [weakSelf imageHeightViewArray:weakSelf.cardArray]+50;
                        [weakSelf.cell initAddImageArray:weakSelf.cardArray height:(SCREEN_WIDTH - 20)/3 cancel:weakSelf.cancel];
                        [weakSelf.certification reloadData];
                    };

                    self.cell.imageBtn = ^(NSInteger image){
                        [weakSelf initMLSelectPhotoBrowserViewControllerImage:image  array:weakSelf.cardArray];
                    };
                }

            }
                break;

            case 3:
            {
                if (_businessArray.count == 0) {
                     self.business = 0;
                     [self.cell certificationViewCell];
                }else{
                     [self.cell initAddImageArray:self.businessArray height:(SCREEN_WIDTH - 20)/3 cancel:self.cancel];
                    self.cell.deleteBtn = ^(NSInteger deleteBtn){
                        [weakSelf.businessArray removeObjectAtIndex:deleteBtn];
                         weakSelf.business = [weakSelf imageHeightViewArray:weakSelf.businessArray]+50;
                        [weakSelf.cell initAddImageArray:weakSelf.businessArray height:(SCREEN_WIDTH - 20)/3 cancel:weakSelf.cancel];
                        [weakSelf.certification reloadData];
                    };
                    self.cell.imageBtn = ^(NSInteger image){
                        [weakSelf initMLSelectPhotoBrowserViewControllerImage:image  array:weakSelf.businessArray];
                    };
                }

            }
                break;

            case 4:
            {
                if (self.proveArray.count == 0) {
                     self.prove = 0;
                     [self.cell certificationViewCell];
                }else{
                     [self.cell initAddImageArray:self.proveArray height:(SCREEN_WIDTH - 20)/3 cancel:self.cancel];
                    self.cell.deleteBtn = ^(NSInteger deleteBtn){
                        [weakSelf.proveArray removeObjectAtIndex:deleteBtn];
                         weakSelf.prove = [weakSelf imageHeightViewArray:weakSelf.proveArray]+50;
                        [weakSelf.cell initAddImageArray:weakSelf.proveArray height:(SCREEN_WIDTH - 20)/3 cancel:weakSelf.cancel];
                        [weakSelf.certification reloadData];
                    };
                    self.cell.imageBtn = ^(NSInteger image){
                        [weakSelf initMLSelectPhotoBrowserViewControllerImage:image  array:weakSelf.proveArray];
                    };

                }
            }
                break;
            default:
                break;
        }
    }
    self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.cell.backgroundColor = [UIColor whiteColor];

    self.cell.numberLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row +1];
    self.cell.typeLabel.text = [_typeArray objectAtIndex:indexPath.row];

    if (indexPath.row != 0 && indexPath.row != 1) {
        self.cell.addButton.tag = indexPath.row;
        [self.cell.addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (self.cardArray.count != 0 || self.businessArray.count != 0 || self.proveArray.count != 0) {
            self.cancelButton.hidden = NO;
        }else{
            self.cancelButton.hidden = YES;
        }

    }

    return self.cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            return 50;
        }
            break;
        case 1:
        {
            return 50;
        }
            break;
        case 2:
        {
            if (self.card == 0) {
                 return (SCREEN_WIDTH - 20)/3+ 20;
            }else{
                return self.card +20;
            }

        }
            break;
        case 3:
        {
            if (self.business == 0) {
                return (SCREEN_WIDTH - 20)/3+ 20;
            }else{
                return self.business +20;
            }


        }
            break;
        case 4:
        {
            if (self.prove == 0) {
                return (SCREEN_WIDTH - 20)/3+ 20;
            }else{
                return self.prove +20;
            }


        }
            break;

        default:
            break;
    }
    return 0;
}
- (void)addButtonClick:(UIButton *)button{
    [self selectPhotosButtonTag:button.tag];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    return YES;
}
#pragma mark - 选择相册
- (void)selectPhotosButtonTag:(NSInteger )tag {
    // 创建控制器
    MLSelectPhotoPickerViewController *pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
    // 默认显示相册里面的内容SavePhotos
    pickerVc.topShowPhotoPicker = YES;
    pickerVc.status = PickerViewShowStatusCameraRoll;

    switch (tag) {
        case 2:
        {
            if (_cardArray.count == 0) {
                pickerVc.maxCount = 9;
            }else{
                pickerVc.maxCount = 9 - _cardArray.count;
            }

        }
            break;
        case 3:
        {
            if (_businessArray.count == 0) {
                pickerVc.maxCount = 9;
            }else{
                pickerVc.maxCount = 9 - _businessArray.count;
            }

        }
            break;
        case 4:
        {
            if (_proveArray.count == 0) {
                pickerVc.maxCount = 9;
            }else{
                pickerVc.maxCount = 9 - _proveArray.count;
            }

        }
            break;

        default:
            break;
    }
    [pickerVc showPickerVc:self];
    __weak typeof(self) weakSelf = self;
    pickerVc.callBack = ^(NSArray *assets){

        switch (tag) {
            case 2:
            {
                [weakSelf.cardArray addObjectsFromArray:assets];
                weakSelf.card = [weakSelf imageHeightViewArray:weakSelf.cardArray]+50;
            }
                break;
            case 3:
            {
                 [weakSelf.businessArray addObjectsFromArray:assets];
                 weakSelf.business = [weakSelf imageHeightViewArray:weakSelf.businessArray] +50;
            }
                break;
            case 4:
            {
                 [weakSelf.proveArray addObjectsFromArray:assets];
                 weakSelf.prove = [weakSelf imageHeightViewArray:weakSelf.proveArray]+50;
                
            }
                break;
                
            default:
                break;
        }

        [weakSelf.certification reloadData];
    };
}
- (CGFloat)imageHeightViewArray:(NSMutableArray *)arr{

    if (arr.count != 0) {
        for (int i = 0; i < arr.count; i++) {
            if (i == arr.count -1) {
                int line= (i + 1)/3;//行号
                if (arr.count < 9) {
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
- (void)initMLSelectPhotoBrowserViewControllerImage:(NSInteger)image array:(NSMutableArray *)array{
    MLSelectPhotoBrowserViewController *browserVc = [[MLSelectPhotoBrowserViewController alloc] init];
    browserVc.currentPage = image;
    browserVc.photos = array;
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:browserVc animated:YES];

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
