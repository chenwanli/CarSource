//
//  CertificationViewCell.m
//  CarSource
//
//  Created by apple on 16/1/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CertificationViewCell.h"
#import "MLSelectPhotoAssets.h"
#import "MLSelectPhotoPickerAssetsViewController.h"
#import "MLSelectPhotoBrowserViewController.h"


@interface CertificationViewCell (){

}
@end
@implementation CertificationViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self awakeFromNib];

    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code

    self.numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 17, 16, 16)];
    self.numberLabel.layer.cornerRadius = 8;
    self.numberLabel.layer.masksToBounds = YES;
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.numberLabel.textColor = [UIColor whiteColor];
    self.numberLabel.font = [UIFont systemFontOfSize:13];
    self.numberLabel.backgroundColor = [UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1];
    [self addSubview:self.numberLabel];

    self.typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(36, 10, 70, 30)];
    self.typeLabel.textColor = [UIColor grayColor];
    self.typeLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.typeLabel];

    [self.numberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@17);
        make.size.equalTo(CGSizeMake(16, 16));
    }];
    [self.typeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@36);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(70, 30));
    }];


}
- (void)initCertificationViewCellNameText:(NSString *)nameText{

    UITextField *phoneField = [[UITextField alloc]init];
    phoneField.font = [UIFont systemFontOfSize:14];
    phoneField.placeholder = nameText;
    phoneField.delegate = self;
    phoneField.textColor = [UIColor grayColor];
    phoneField.layer.borderColor = [UIColor colorWithRed:227/255.0 green:241/255.0 blue:255/255.0 alpha:1].CGColor;
    phoneField.layer.borderWidth = 1.0;
//    phoneField.textAlignment = UIControlContentHorizontalAlignmentCenter;
//    phoneField.borderStyle = UITextBorderStyleLine;
//    phoneField.backgroundColor = [UIColor colorWithRed:227/255.0 green:241/255.0 blue:255/255.0 alpha:1];
    [phoneField setReturnKeyType : UIReturnKeyDone ];
    phoneField.clearButtonMode = UITextFieldViewModeAlways;
    [self addSubview:phoneField];


    [phoneField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@126);
        make.top.equalTo(@10);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@30);
    }];

}
- (void)certificationViewCell{
    [self.addView removeFromSuperview];

    self.addView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH - 20)/3 +20)];
    [self addSubview:self.addView];


    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addButton.frame = CGRectMake(126, 10, (SCREEN_WIDTH - 10)/3 - 10, (SCREEN_WIDTH - 20)/3-10);
    [self.addButton setBackgroundImage:[UIImage imageNamed:@"gift"] forState:UIControlStateNormal];

//    [self.addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_addView addSubview:self.addButton];

}
- (void)initAddImageArray:(NSMutableArray *)imageArray height:(NSInteger)height cancel:(NSInteger )cancel{

    [_addView removeFromSuperview];

    _addView = [[UIView alloc]init];
    [self addSubview:_addView];

    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addButton.frame = CGRectMake(10, 10, height - 10, height-10);
    [_addButton setBackgroundImage:[UIImage imageNamed:@"gift"] forState:UIControlStateNormal];

//    [_addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_addView addSubview:_addButton];

    @autoreleasepool
    {

        int totalloc=3;
        CGFloat appvieww=height-5;
        CGFloat appviewh=height-5;
        CGFloat margin=((SCREEN_WIDTH- 20) -totalloc*appvieww)/(totalloc+1);

        for (int i = 0; i < imageArray.count; i++) {

            int row=i/totalloc;//行号
            //1/3=0,2/3=0,3/3=1;
            int loc=i%totalloc;//列号
            CGFloat appviewx=margin+(margin+appvieww)*loc;
            CGFloat appviewy=margin+(margin+appviewh)*row;
            UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
            imageButton.frame = CGRectMake(appviewx +10, appviewy +10, height - 10, height - 10);
            // 判断类型来获取Image
            MLSelectPhotoAssets *asset = imageArray[i];

            [imageButton setBackgroundImage:[MLSelectPhotoPickerViewController getImageWithImageObj:asset] forState:UIControlStateNormal];

            [imageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            imageButton.tag = i ;

            [_addView addSubview:imageButton];

            imageButton = nil;

            if (cancel == 1) {
                UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
                deleteButton.frame = CGRectMake(appviewx +height -22, appviewy -2, 30, 30);
                [deleteButton setBackgroundImage:[UIImage imageNamed:@"esc"] forState:UIControlStateNormal];
                [deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                deleteButton.tag = i +1;
                [_addView addSubview:deleteButton];
                deleteButton = nil;

            }

            if (i == imageArray.count -1) {

//                _cancelButton.hidden = NO;
                int line=(i +1)/totalloc;//行号
                //1/3=0,2/3=0,3/3=1;
                int column=(i +1)%totalloc;//列号
                CGFloat x=margin+(margin+appvieww)*column;
                CGFloat y=margin+(margin+appviewh)*line;
                if (i<8) {

                    _addButton.hidden = NO;
                    _addView.frame = CGRectMake(0, 40, SCREEN_WIDTH, height*(line +1) +20);
                    _addButton.frame = CGRectMake(x+10, y +10, height - 10, height - 10);

                }else{
                    _addButton.hidden = YES;
                    _addView.frame = CGRectMake(0, 40, SCREEN_WIDTH, height*line +20);
                }
            }
        }
    }
    
}
- (void)imageButtonClick:(UIButton *)button{
    self.imageBtn(button.tag);
}
- (void)deleteButtonClick:(UIButton *)button{
    self.deleteBtn(button.tag -1);
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    return YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
