//
//  AreLookingViewCell.m
//  CarSource
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AreLookingViewCell.h"

@implementation AreLookingViewCell
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
    self.userImage.layer.cornerRadius = 25;
    self.userImage.layer.masksToBounds = YES;
    [self addSubview:self.userImage];

    _userButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_userButton];

    _telButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _telButton.layer.cornerRadius = 15;
//    _telButton.layer.masksToBounds = YES;
    [_telButton setBackgroundImage:[UIImage  imageNamed:@"cat"] forState:UIControlStateNormal];
    [self addSubview:_telButton];

    _informationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _informationBtn.layer.cornerRadius = 15;
//    _informationBtn.layer.masksToBounds = YES;
    [_informationBtn setBackgroundImage:[UIImage  imageNamed:@"body"] forState:UIControlStateNormal];
    [self addSubview:_informationBtn];

    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.textColor = [UIColor grayColor];
    self.timeLabel.numberOfLines = 0;
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.timeLabel];


    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.textColor = [UIColor grayColor];
    _nameLabel.numberOfLines = 0;
    _nameLabel.font = [UIFont systemFontOfSize:16];
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

//    for (int i = 0; i < 3; i++) {
//        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((40 *i) +70 , 35, 30 +5*i, 13)];
//        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"c%d",i +1]];
//        [self addSubview:imageView];
//    }
    [self.userImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(50, 50));

    }];

    [_userButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(50, 50));

    }];

    [self.timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@60);
        make.size.equalTo(CGSizeMake(50, 25));

    }];

    [_informationBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(40, 40));

    }];

    [_telButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-60);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(40, 40));

    }];

    [_nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(70);
        make.top.equalTo(@5);
        make.right.equalTo(self).offset(-100);
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
        make.left.equalTo(@10);
        make.bottom.equalTo(self).offset(-1);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@1);
    }];
    

}
- (void)initAuthenticateLabelArray:(NSMutableArray *)array{

    @autoreleasepool
    {
        UILabel *label = (UILabel *)[self viewWithTag:400];
        [label removeFromSuperview];


        CGFloat width = 0;
        if (![[NSString stringWithFormat:@"%@",array] isEqualToString:@"<null>"] ) {
            for (int i = 0; i < array.count; i++ ) {
                CGSize nameSize = STRING_SIZE_FONT(SCREEN_WIDTH-130, [array objectAtIndex:i], 12);
                if (i != 0) {
                    width = nameSize.width + width +10 ;
                }

                UILabel  *authenticateLabel = [[UILabel alloc]initWithFrame:CGRectMake(70 + width, 35, nameSize.width, 12)];
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
