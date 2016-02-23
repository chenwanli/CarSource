//
//  ResourcesViewCell.m
//  CarSource
//
//  Created by apple on 16/1/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ResourcesViewCell.h"
#import "YYKit.h"

@implementation ResourcesViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier text:(NSString *)text
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self awakeFromNib];

         [self initResourcesViewCellText:text];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code

    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 37, 70, 10)];
    _timeLabel.text = @"12-12";
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.textColor = [UIColor grayColor];
    _timeLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_timeLabel];

    _userButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _userButton.layer.cornerRadius = 25;
    _userButton.layer.masksToBounds = YES;
    [_userButton setBackgroundImage:[UIImage  imageNamed:@"ww.jpg"] forState:UIControlStateNormal];
    [self addSubview:_userButton];

    _telButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_telButton setBackgroundImage:[UIImage  imageNamed:@"cat"] forState:UIControlStateNormal];
    [self addSubview:_telButton];

    _informationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_informationBtn setBackgroundImage:[UIImage  imageNamed:@"body"] forState:UIControlStateNormal];
    [self addSubview:_informationBtn];

    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.textColor = BLACK;
    _nameLabel.numberOfLines = 0;
    _nameLabel.font = [UIFont systemFontOfSize:18];
    [_nameLabel sizeToFit];
    [self addSubview:_nameLabel];

    UIImageView *lineImage = [[UIImageView alloc]init];

    lineImage.backgroundColor = [UIColor colorWithRed:215/255.0 green:234/255.0 blue:255/255.0 alpha:1];
    [self addSubview:lineImage];

    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((40 *i) +70 , 35, 30 +5*i, 13)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"c%d",i +1]];
        [self addSubview:imageView];
    }
    [_userButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(50, 50));

    }];
    [_timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.top.equalTo(@70);
        make.size.equalTo(CGSizeMake(60, 30));

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
        make.right.equalTo(self).offset(-100);
        make.height.equalTo(@30);
    }];

    [lineImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.bottom.equalTo(self).offset(@0);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@1);
    }];



}
- (void)initResourcesViewCellText:(NSString *)text {
    @autoreleasepool
    {

        NSMutableAttributedString *mStr = [NSMutableAttributedString new];
        {
            NSMutableAttributedString *omg = [[NSMutableAttributedString alloc] initWithString:@"急寻"];
            omg.font = [UIFont systemFontOfSize:20];
            omg.color = [UIColor colorWithRed:246/255.0 green:67/255.0 blue:25/255.0 alpha:1];
            [mStr appendAttributedString:omg];
        }
        {
            NSMutableAttributedString *omg = [[NSMutableAttributedString alloc] initWithString:@""];
            omg.font = [UIFont systemFontOfSize:15];
            omg.color = [UIColor colorWithRed:248/255.0 green:0/255.0 blue:0/255.0 alpha:1];;
            //        omg.underlineColor = omg.color;
            omg.underlineStyle = NSUnderlineStyleNone;
            YYTextHighlight *highlight = [YYTextHighlight new];

            highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect)
            {
                //            NSLog(@"---- view %@ \n",containerView);
                //            NSLog(@"--- NSAttributedString text - %@\n",text);
                //            NSLog(@"------ range - %@\n",NSStringFromRange(range));
                //            NSLog(@"rect - %@\n",NSStringFromCGRect(rect));

            };
            [omg setTextHighlight:highlight range:omg.rangeOfAll];
            [mStr appendAttributedString:omg];
        }


        {
            NSMutableAttributedString *omg = [[NSMutableAttributedString alloc] initWithString:text];
            omg.font = [UIFont systemFontOfSize:15];
            omg.color = [UIColor grayColor];

            [mStr appendAttributedString:omg];

        }

        YYLabel *label = [YYLabel new];
        label.attributedText = mStr;
        label.left = 70;
        label.width = SCREEN_WIDTH -80 ;
        label.height = 60;
        label.top = 50;
        label.textAlignment = NSTextAlignmentLeft;
        label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        label.numberOfLines = 0;
        [self addSubview:label];

        /*
         If the 'highlight.tapAction' is not nil, the label will invoke 'highlight.tapAction'
         and ignore 'label.highlightTapAction'.

         If the 'highlight.tapAction' is nil, you can use 'highlightTapAction' to handle
         all tap action in this label.
         */
        label.highlightTapAction = ^(UIView *containView,NSAttributedString *text,NSRange rang,CGRect rect)
        {
//            NSLog(@"---- view %@ \n",containView);

        };
    }
}
- (NSMutableAttributedString *)appendingString
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"\n\n"];
    str.font = [UIFont systemFontOfSize:5];
    return str;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
