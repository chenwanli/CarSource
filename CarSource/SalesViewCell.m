//
//  SalesViewCell.m
//  CarSource
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SalesViewCell.h"

@implementation SalesViewCell
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

    self.userImage = [[UIImageView alloc]init];
    [self addSubview:self.userImage];

    _userButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _userButton.layer.cornerRadius = 15;
//    _userButton.layer.masksToBounds = YES;
//    [_userButton setBackgroundImage:[UIImage  imageNamed:@"h1.jpg"] forState:UIControlStateNormal];
    [self addSubview:_userButton];

    _telButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_telButton setBackgroundImage:[UIImage  imageNamed:@"cat"] forState:UIControlStateNormal];
    [self addSubview:_telButton];

    _informationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_informationBtn setBackgroundImage:[UIImage  imageNamed:@"body"] forState:UIControlStateNormal];
    [self addSubview:_informationBtn];


    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1];
    _nameLabel.numberOfLines = 0;
    _nameLabel.font = [UIFont systemFontOfSize:16];
    [_nameLabel sizeToFit];
    [self addSubview:_nameLabel];

    _addressLabel = [[UILabel alloc]init];
    _addressLabel.textAlignment = NSTextAlignmentLeft;
    _addressLabel.textColor = [UIColor lightGrayColor];
    _addressLabel.numberOfLines = 0;
    _addressLabel.font = [UIFont systemFontOfSize:14];
    [_addressLabel sizeToFit];
    [self addSubview:_addressLabel];

//    _salesView = [[UIView alloc]init];
//    [self addSubview:_salesView];

    _configuration = [[UILabel alloc]init];
    _configuration.textAlignment = NSTextAlignmentLeft;
    _configuration.textColor = [UIColor grayColor];
//    _configuration.backgroundColor = [UIColor greenColor];
    _configuration.numberOfLines = 0;
    _configuration.font = [UIFont systemFontOfSize:15];
    [_configuration sizeToFit];
    [self addSubview:_configuration];

    _displayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _displayBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_displayBtn setTitleColor:[UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1]forState:UIControlStateNormal];
    [self addSubview:_displayBtn];


    _lineImage = [[UIImageView alloc]init];
    _lineImage.backgroundColor = [UIColor colorWithRed:215/255.0 green:234/255.0 blue:255/255.0 alpha:1];
    [self addSubview:_lineImage];

//    for (int i = 0; i < 3; i++) {
//        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((40 *i) +50 , 35, 30 +5*i, 13)];
//        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"c%d",i +1]];
//        [self addSubview:imageView];
//    }
//
   

    [_lineImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@0);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@1);
    }];

    [self.userImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@15);
        make.size.equalTo(CGSizeMake(30, 30));

    }];

    [_userButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@15);
        make.size.equalTo(CGSizeMake(30, 30));

    }];

    [_informationBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(30, 30));

    }];

    [_telButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-60);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(30, 30));

    }];



}
- (void)initAuthenticateLabelText:(NSString *)text{

    @autoreleasepool
    {
        UILabel *label = (UILabel *)[self viewWithTag:400];
        [label removeFromSuperview];

     NSArray *array = [text componentsSeparatedByString:@","];

    CGFloat width = 0;
        if (![[NSString stringWithFormat:@"%@",array] isEqualToString:@""]) {
            for (int i = 0; i < array.count; i++ ) {
                CGSize nameSize = STRING_SIZE_FONT(SCREEN_WIDTH-130, [array objectAtIndex:i], 12);
                if (i != 0) {
                    width = nameSize.width + width +10 ;
                }

                UILabel  *authenticateLabel = [[UILabel alloc]initWithFrame:CGRectMake(50 + width, 34, nameSize.width, 12)];
                authenticateLabel.textColor = [UIColor colorWithRed:224/255.0 green:83/255.0 blue:29/255.0 alpha:1];
                authenticateLabel.backgroundColor = [UIColor colorWithRed:237/255.0 green:231/255.0 blue:65/255.0 alpha:1];
                authenticateLabel.tag = 400;
                authenticateLabel.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:i]];
                authenticateLabel.textAlignment = NSTextAlignmentCenter;
                authenticateLabel.font = [UIFont systemFontOfSize:10];
                [self addSubview:authenticateLabel];
                
            }

        }
    }

}
- (void)salesViewCellNameText:(NSString *)text salesHeightView:(CGFloat)salesHeight configurationHeight:(CGFloat)height isOpen:(BOOL)isOpen salesArray:(NSMutableArray *)salesArray{

    CGSize nameSize = STRING_SIZE_FONT(SCREEN_WIDTH-130, text, 16);
    _nameLabel.frame = CGRectMake(50, 5, nameSize.width +10, 30);
    _addressLabel.frame = CGRectMake(nameSize.width +50, 5, 120, 30);

    if (![[NSString stringWithFormat:@"%@",salesArray] isEqualToString:@"<null>"]) {
        @autoreleasepool
        {

            for (UIView *view in self.subviews)
            {
                if (view.tag == 200)
                {
                    [view removeFromSuperview];
                }

                UIImageView *imageView = (UIImageView *)[self viewWithTag:300];
                [imageView removeFromSuperview];
            }
            int totalloc=3;
            CGFloat appvieww=(SCREEN_WIDTH- 60)/3-5;
            CGFloat appviewh=(SCREEN_WIDTH- 60)/3-5;
            CGFloat margin=((SCREEN_WIDTH- 60) -totalloc*appvieww)/(totalloc+1);

            for (int i = 0; i < salesArray.count; i++) {

                int row=i/totalloc;//行号
                //1/3=0,2/3=0,3/3=1;
                int loc=i%totalloc;//列号
                CGFloat appviewx=margin+(margin+appvieww)*loc;
                CGFloat appviewy=margin+(margin+appviewh)*row;
                UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
                imageButton.frame = CGRectMake(appviewx +50, appviewy +height + 70, (SCREEN_WIDTH - 60)/3 - 5, (SCREEN_WIDTH - 60)/3 - 5);
                // 判断类型来获取Image
                //                [imageButton setBackgroundImage:[UIImage imageNamed:@"h3.jpg"] forState:UIControlStateNormal];

                [imageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                imageButton.tag = 200;

                [self addSubview:imageButton];
                imageButton = nil;

                UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(appviewx +50, appviewy +height + 70, (SCREEN_WIDTH - 60)/3 - 5, (SCREEN_WIDTH - 60)/3 - 5)];
                image.tag = 300;
                [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,[salesArray objectAtIndex:i]]] placeholderImage:[UIImage imageNamed:@"005.jpg"]];
                
                [self addSubview:image];
                image = nil;
                
            }
            
        }

    }
        if (isOpen)
    {
        [_displayBtn setTitle:@"[点击收起]" forState:UIControlStateNormal];
         _displayBtn.frame = CGRectMake(40, height +48, 100, 30);
    }
    else
    {
        [_displayBtn setTitle:@"[查看更多]" forState:UIControlStateNormal];
         _displayBtn.frame = CGRectMake(40, height +45, 100, 30);
    }


    _configuration.frame = CGRectMake(50, 55, SCREEN_WIDTH - 60, height);

//     _salesView.frame = CGRectMake(50, height + 100, SCREEN_WIDTH-100, salesHeight);



}
- (void)imageButtonClick:(UIButton *)button{

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
