//
//  MyProfileViewController.m
//  CarSource
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MyProfileViewController.h" 
#import "MyProfileView.h"
#import "MyProfileViewCell.h"

@interface MyProfileViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,UIActionSheetDelegate>{
    UITableView *_profileTable;
    NSArray *_profileArray;
    MyProfileView *_profile;
}

@end

@implementation MyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor yellowColor];
    _profileArray = [[NSArray alloc]initWithObjects:@"展厅",@"钱包",@"服务",@"设置", nil];

    _profileTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _profileTable.delegate = self;
    // 设置数据源
    _profileTable.dataSource = self;
    _profileTable.bounces = NO;
    _profileTable.rowHeight = 60;
    _profileTable.backgroundColor = [UIColor colorWithRed:235/255.0 green:236/255.0 blue:241/255.0 alpha:1];
    _profileTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self.view addSubview:_profileTable];

    _profile = [[MyProfileView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
    _profileTable.tableHeaderView = _profile;

    MyProfileViewController *profileView = self;
    _profile.next = ^(NSString *next){
        
        [LCCoolHUD showLoading:@"正在加载" inView:profileView.view];
         LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];
        [RequestClass postUserDataRequestWithUserId:login.userId Completion:^(NSMutableArray *saleArray, NSString *errorMessage) {
             [LCCoolHUD hideInView:profileView.view];
            if ([errorMessage isEqualToString:@"0"]) {
                 profileView.nextArray(saleArray);
            }
        }];


    };
    _profile.buttonTag = ^(NSInteger btnTag){
        profileView.btnTag(btnTag);
    };
    _profile.userBtn = ^(NSString *userBtn){

    };
    _profile.loginBtn = ^(NSString *loginBtn){
        profileView.loginBtn(loginBtn);
    };

    _profile.bgButton = ^(NSString *bgButton){

        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要更改背景图片" delegate:profileView cancelButtonTitle:@"取消"otherButtonTitles:@"确定",nil];
        [alert show];
    };
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self photoAvatar];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _profileArray.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    MyProfileViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if (!cell)
    {
        cell = [[MyProfileViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithRed:235/255.0 green:236/255.0 blue:241/255.0 alpha:1];
    cell.pofileImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"the%ld",(long)indexPath.row +1]];
    cell.pofileLabel.text = [_profileArray objectAtIndex:indexPath.row];
    cell.balanceLabel.hidden = YES;
    if (indexPath.row == 1) {
        cell.balanceLabel.hidden = NO;
        cell.balanceLabel.text = @"余额：888元";
    }

    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    self.row(indexPath.row +1);
}

#pragma --

#pragma mark 选中图片之后执行的方法和取消调用相机或相册之后执行的方法
- (void)photoAvatar
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"打开相机",@"打开相册", nil];
    [actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //    NSLog(@"index   %d",buttonIndex);

    int type = 0;

    switch (buttonIndex) {
        case 0:
            // 打开相机
            type = UIImagePickerControllerSourceTypeCamera;

            // 判断相机来源 是否支持
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"打开照相机失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alertView show];

                return;
            }
            break;
        case 1:
            // 打开相册
            type = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        case 2:
            //取消
            return;
            break;
        default:
            break;
    }

    // 创建picker
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.sourceType = type;
    pickerController.delegate = self;
    [pickerController setAllowsEditing:YES];
    [self presentViewController:pickerController animated:YES completion:nil];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
     LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];
    [LCCoolHUD showLoading:@"正在上传" inView:self.view];

    [RequestClass postModifyTheUserBackgroundRequestWithUserId:login.userId image:image Completion:^(NSMutableArray *saleArray, NSString *errorMessage) {
        [LCCoolHUD hideInView:self.view];
        if ([errorMessage isEqualToString:@"0"] ) {

            [LCCoolHUD showSuccess:@"上传成功" zoom:YES shadow:YES];
            NSMutableArray *array = [[NSMutableArray alloc]init];
            for (LoginModel *user in saleArray) {
                login.userBackGround = user.userBackGround;
                [array addObject:login];
            }
            [Serialization initSerializationArray:array];
            [_profile initBackgroundImageView];
        }

    }];
    [picker dismissViewControllerAnimated:YES completion:nil];

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
