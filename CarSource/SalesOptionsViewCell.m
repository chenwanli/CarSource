//
//  SalesOptionsViewCell.m
//  CarSource
//
//  Created by apple on 15/12/19.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SalesOptionsViewCell.h"

@implementation SalesOptionsViewCell
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

    UIImageView *bgImage = [[UIImageView alloc]init];

    bgImage.backgroundColor = [UIColor colorWithRed:241/255.0 green:251/255.0 blue:255/255.0 alpha:1];
    [self addSubview:bgImage];

    _userButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _userButton.layer.cornerRadius = 25;
    _userButton.layer.masksToBounds = YES;
    [_userButton setBackgroundImage:[UIImage  imageNamed:@"ww.jpg"] forState:UIControlStateNormal];
    [self addSubview:_userButton];

    _telButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _telButton.layer.cornerRadius = 15;
    _telButton.layer.masksToBounds = YES;
    [_telButton setBackgroundImage:[UIImage  imageNamed:@"cat"] forState:UIControlStateNormal];
    [self addSubview:_telButton];

    _informationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _informationBtn.layer.cornerRadius = 15;
    _informationBtn.layer.masksToBounds = YES;
    [_informationBtn setBackgroundImage:[UIImage  imageNamed:@"body"] forState:UIControlStateNormal];
    [self addSubview:_informationBtn];


    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.textColor = [UIColor grayColor];
    _nameLabel.numberOfLines = 0;
    _nameLabel.font = [UIFont systemFontOfSize:16];
    [_nameLabel sizeToFit];
    [self addSubview:_nameLabel];

    _searchLabel = [[UILabel alloc]init];
    _searchLabel.textAlignment = NSTextAlignmentLeft;
    _searchLabel.textColor = [UIColor colorWithRed:246/255.0 green:67/255.0 blue:25/255.0 alpha:1];
    _searchLabel.numberOfLines = 0;
    _searchLabel.font = [UIFont systemFontOfSize:18];
    [_searchLabel sizeToFit];
    [self addSubview:_searchLabel];

    _configuration = [[UILabel alloc]init];
    _configuration.textAlignment = NSTextAlignmentLeft;
    _configuration.textColor = [UIColor grayColor];
    _configuration.numberOfLines = 0;
    _configuration.font = [UIFont systemFontOfSize:16];
    [_configuration sizeToFit];
    [self addSubview:_configuration];
    UIImageView *lineImage = [[UIImageView alloc]init];

    lineImage.backgroundColor = [UIColor colorWithRed:215/255.0 green:234/255.0 blue:255/255.0 alpha:1];
    [self addSubview:lineImage];

    UIImageView *bottomImage = [[UIImageView alloc]init];

    bottomImage.backgroundColor = [UIColor colorWithRed:215/255.0 green:234/255.0 blue:255/255.0 alpha:1];
    [self addSubview:bottomImage];

    _editorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _editorBtn.backgroundColor = [UIColor whiteColor];
    [_editorBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [_editorBtn setTitleColor:[UIColor lightGrayColor]forState:UIControlStateNormal];
    [self addSubview:_editorBtn];

    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteBtn.backgroundColor = [UIColor whiteColor];
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteBtn setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
    [self addSubview:_deleteBtn];
    

    UIImageView *segmentation  = [[UIImageView alloc]init];
    segmentation.backgroundColor = [UIColor colorWithRed:175/255.0 green:198/255.0 blue:225/255.0 alpha:1];
    [self addSubview:segmentation];


    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((40 *i) +70 , 35, 30 +5*i, 13)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"c%d",i +1]];
        [self addSubview:imageView];
    }

    [bgImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(@0);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@130);
    }];
    [_userButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@15);
        make.size.equalTo(CGSizeMake(50, 50));

    }];

    [_informationBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(30, 30));

    }];

    [_telButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-50);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(30, 30));

    }];

    [_nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(70);
        make.top.equalTo(@5);
        make.right.equalTo(self).offset(-80);
        make.height.equalTo(@30);
    }];

    [_searchLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@70);
        make.top.equalTo(@50);
        make.size.equalTo(CGSizeMake(60, 30));

    }];

    [_configuration makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(@75);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@50);
    }];
    [lineImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(@130);
        make.right.equalTo(self).offset(-0);
        make.height.equalTo(@1);
    }];

    [_editorBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@131);
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH)/2, 40));

    }];


    [_deleteBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo((SCREEN_WIDTH)/2);
        make.top.equalTo(@131);
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH)/2, 40));

    }];

    [bottomImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(@170);
        make.right.equalTo(self).offset(-0);
        make.height.equalTo(@1);
    }];
    [segmentation makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo((SCREEN_WIDTH)/2);
        make.top.equalTo(@132);
        make.width.equalTo(@1);
        make.height.equalTo(@36);
    }];



}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
