//
//  EntrustViewCell.m
//  CarSource
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "EntrustViewCell.h"
#import "YYKit.h"

@implementation EntrustViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _typeStr = @"";
        _userStr = @"";

//        [self awakeFromNib];
        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"voice"]];

        [self addSubview:image];
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 37, 70, 10)];
        _timeLabel.text = @"12-12 18:30";
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_timeLabel];

        [image makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@5);
            make.top.equalTo(@10);
            make.size.equalTo(CGSizeMake(30, 25));
        }];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code

    
    NSMutableAttributedString *mStr = [NSMutableAttributedString new];
    {
        NSMutableAttributedString *omg = [[NSMutableAttributedString alloc] initWithString:@"恭喜用户"];
        omg.font = [UIFont systemFontOfSize:14];
        omg.color = [UIColor grayColor];
        [mStr appendAttributedString:omg];
    }

    {
        NSMutableAttributedString *omg = [[NSMutableAttributedString alloc] initWithString:_userStr];
        omg.font = [UIFont systemFontOfSize:15];
        omg.color = [UIColor colorWithRed:0/255.0 green:174/255.0 blue:203/255.0 alpha:1];
        omg.underlineColor = omg.color;
        omg.underlineStyle = NSUnderlineStyleSingle;
        YYTextHighlight *highlight = [YYTextHighlight new];

        highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect)
        {
//            NSLog(@"---- view %@ \n",containerView);
            //            NSLog(@"--- NSAttributedString text - %@\n",text);
            //            NSLog(@"------ range - %@\n",NSStringFromRange(range));
            //            NSLog(@"rect - %@\n",NSStringFromCGRect(rect));

            [SkinManager sharedSkinManager].countTest = 1;

            
        };
        [omg setTextHighlight:highlight range:omg.rangeOfAll];
        [mStr appendAttributedString:omg];
    }


    {
        NSMutableAttributedString *omg = [[NSMutableAttributedString alloc] initWithString:@"委托车信源找到了一辆"];
        omg.font = [UIFont systemFontOfSize:14];
        omg.color = [UIColor grayColor];

        [mStr appendAttributedString:omg];

    }

    {
        NSMutableAttributedString *omg = [[NSMutableAttributedString alloc] initWithString:_typeStr];
        omg.font = [UIFont systemFontOfSize:15];
        omg.color = [UIColor colorWithRed:249/255.0 green:99/255.0 blue:0/255.0 alpha:1];
        omg.underlineColor = omg.color;
        omg.underlineStyle = NSUnderlineStyleSingle;


        YYTextHighlight *highlight = [YYTextHighlight new];

        highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect)
        {
            NSLog(@"---- view %@ \n",containerView);
            [SkinManager sharedSkinManager].countTest = 1;
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
    label.left = 40;
    label.width = SCREEN_WIDTH -50 ;
    label.height = 45;
    label.top = 0;
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
