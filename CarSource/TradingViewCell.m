//
//  TradingViewCell.m
//  CarSource
//
//  Created by apple on 16/1/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TradingViewCell.h"
#import "YYKit.h"

@implementation TradingViewCell

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
    _userButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _userButton.layer.cornerRadius = 25;
    _userButton.layer.masksToBounds = YES;
    [_userButton setBackgroundImage:[UIImage  imageNamed:@"ww.jpg"] forState:UIControlStateNormal];
    [self addSubview:_userButton];

    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.textColor = [UIColor grayColor];
    _nameLabel.numberOfLines = 0;
    _nameLabel.font = [UIFont systemFontOfSize:16];
    [_nameLabel sizeToFit];
    [self addSubview:_nameLabel];

    _personalLabel = [[UILabel alloc]init];
    _personalLabel.textAlignment = NSTextAlignmentCenter;
    _personalLabel.textColor = [UIColor redColor];
    _personalLabel.numberOfLines = 0;
    _personalLabel.text = @"个人";
    _personalLabel.backgroundColor = [UIColor colorWithRed:239/255.0 green:232/255.0 blue:65/255.0 alpha:1];
    _personalLabel.font = [UIFont systemFontOfSize:10];
    [_personalLabel sizeToFit];
    [self addSubview:_personalLabel];

    //    _personalImage = [[UIImageView alloc]init];
    //    _personalImage.backgroundColor = [UIColor redColor];
    //    [self addSubview:_personalImage];

    _configuration = [[UILabel alloc]init];
    _configuration.textAlignment = NSTextAlignmentLeft;
    _configuration.textColor = [UIColor grayColor];
    _configuration.numberOfLines = 0;
    _configuration.font = [UIFont systemFontOfSize:16];
    [_configuration sizeToFit];
    [self addSubview:_configuration];

    _timeLabel = [[UILabel alloc]init];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.textColor = [UIColor lightGrayColor];
    _timeLabel.numberOfLines = 0;
    _timeLabel.font = [UIFont systemFontOfSize:13];
    [_timeLabel sizeToFit];
    [self addSubview:_timeLabel];

    _credentialsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_credentialsBtn setTitle:@"已付款" forState:UIControlStateNormal];
    _credentialsBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    _credentialsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_credentialsBtn setTitleColor:[UIColor colorWithRed:248/255.0 green:0/255.0 blue:0/255.0 alpha:1]forState:UIControlStateNormal];
    [self addSubview:_credentialsBtn];

    UIImageView *lineImage = [[UIImageView alloc]init];
    lineImage.backgroundColor = [UIColor colorWithRed:215/255.0 green:234/255.0 blue:255/255.0 alpha:1];
    [self addSubview:lineImage];

    [_userButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@15);
        make.size.equalTo(CGSizeMake(50, 50));
    }];


    [_configuration makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(70);
        make.top.equalTo(@55);
        make.right.equalTo(self).offset(-60);
        make.height.equalTo(@50);
    }];

    [_credentialsBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(@60);
        make.size.equalTo(CGSizeMake(50, 30));
    }];

    [_timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(@90);
        make.size.equalTo(CGSizeMake(60, 20));
    }];

    [lineImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.bottom.equalTo(self).offset(@0);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@1);
    }];
    
}
- (void)initOtherGuaranteeViewCellText:(NSString *)text {

    CGSize nameSize = STRING_SIZE_FONT(SCREEN_WIDTH-120, text, 16);
    _nameLabel.text = text;

    _nameLabel.frame = CGRectMake(70, 5, nameSize.width +10, 25);

    _personalLabel.frame = CGRectMake(nameSize.width +90, 12, 30, 12);


    NSMutableAttributedString *mStr = [NSMutableAttributedString new];
    {
        NSMutableAttributedString *omg = [[NSMutableAttributedString alloc] initWithString:@"定金"];
        omg.font = [UIFont systemFontOfSize:14];
        omg.color = [UIColor grayColor];
        [mStr appendAttributedString:omg];
    }

    {
        NSMutableAttributedString *omg = [[NSMutableAttributedString alloc] initWithString:_moneyStr];
        omg.font = [UIFont systemFontOfSize:15];
        omg.color = [UIColor colorWithRed:248/255.0 green:0/255.0 blue:0/255.0 alpha:1];
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
        NSMutableAttributedString *omg = [[NSMutableAttributedString alloc] initWithString:@"卖家"];
        omg.font = [UIFont systemFontOfSize:14];
        omg.color = [UIColor grayColor];

        [mStr appendAttributedString:omg];

    }

    {
        NSMutableAttributedString *omg = [[NSMutableAttributedString alloc] initWithString:_userStr];
        omg.font = [UIFont systemFontOfSize:15];
        omg.color = [UIColor colorWithRed:77/255.0 green:170/255.0 blue:236/255.0 alpha:1];
        //        omg.underlineColor = omg.color;
        omg.underlineStyle = NSUnderlineStyleNone;


        YYTextHighlight *highlight = [YYTextHighlight new];

        highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect)
        {
            NSLog(@"---- view %@ \n",containerView);
            //            self.user(nil);
            //
            //            NSLog(@"--- NSAttributedString text - %@\n",text);
            //            NSLog(@"------ range - %@\n",NSStringFromRange(range));
            //            NSLog(@"rect - %@\n",NSStringFromCGRect(rect));

        };
        [omg setTextHighlight:highlight range:omg.rangeOfAll];
        [mStr appendAttributedString:omg];
    }
    YYLabel *label = [YYLabel new];
    label.attributedText = mStr;
    label.left = 70;
    label.width = SCREEN_WIDTH -80 ;
    label.height = 25;
    label.top = 30;
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
        NSLog(@"---- view %@ \n",containView);

    };

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
