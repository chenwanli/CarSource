//
//  GuaranteeDetailsViewCell.m
//  CarSource
//
//  Created by apple on 16/1/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GuaranteeDetailsViewCell.h"

@interface GuaranteeDetailsViewCell ()<UITextFieldDelegate,UITextViewDelegate>{
    NSInteger _editing;
}

@end
@implementation GuaranteeDetailsViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
         _editing = 1;
        [self awakeFromNib];

    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    _typeLabel = [[UILabel alloc]init];
    _typeLabel.textColor = [UIColor grayColor];
    _typeLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_typeLabel];

    _image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 44, SCREEN_WIDTH-20, 1)];
    _image.backgroundColor = LIGHTBLUE;
    [self addSubview:_image];


    [_typeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@10);
        make.size.equalTo(CGSizeMake(70, 44));
    }];

    [_image makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.bottom.equalTo(@0);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@1);
    }];

}
- (void)initGuaranteeDetailsViewCell{

    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"milled"];
    [self addSubview:imageView];

    _chooseLabel = [[UILabel alloc]init];
    _chooseLabel.textColor = COLOR;
    _chooseLabel.textAlignment = NSTextAlignmentRight;
    _chooseLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_chooseLabel];

    
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@13);
        make.right.equalTo(self).offset(-10);
        make.size.equalTo(CGSizeMake(15, 18));
    }];
    [_chooseLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(90);
        make.bottom.equalTo(@0);
        make.right.equalTo(self).offset(-25);
        make.height.equalTo(@44);
    }];

}
- (void)initGuaranteeDetailsViewCellUnitText:(NSString *)unitText placeholder:(NSString *)placeholder{

    UILabel *unitLabel = [[UILabel alloc]init];
    unitLabel.textColor = [UIColor grayColor];
    unitLabel.text = unitText;
    unitLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:unitLabel];

    UITextField *numberField = [[UITextField alloc]init];
    numberField.font = [UIFont systemFontOfSize:15];
    numberField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    numberField.delegate = self;
    numberField.textAlignment = UIControlContentHorizontalAlignmentRight;
    //    _textField.borderStyle = UITextBorderStyleRoundedRect;
    numberField.textColor = [UIColor grayColor];
    numberField.placeholder = placeholder;
    //    _numberField.backgroundColor = [UIColor yellowColor];
    numberField.keyboardType = UIKeyboardTypeDecimalPad;
    [numberField setReturnKeyType : UIReturnKeyDone ];
    //    _numberField.clearButtonMode = UITextFieldViewModeAlways;
    [self addSubview:numberField];
    
    [numberField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@90);
        make.top.equalTo(@2);
        make.right.equalTo(self).offset(-35);
        make.height.equalTo(@40);
    }];

    [unitLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.right.equalTo(self).offset(-10);
        make.size.equalTo(CGSizeMake(20, 44));
    }];



}
- (void)initTextView{

    UIImageView *bgImage = [[UIImageView alloc]init];
    bgImage.backgroundColor = GRAY;
    [self addSubview:bgImage];

    UIImageView *whiteImage = [[UIImageView alloc]init];
    whiteImage.backgroundColor = [UIColor whiteColor];
    [self addSubview:whiteImage];


    UITextView *textview = [[UITextView alloc] init];
    textview.backgroundColor=[UIColor whiteColor]; //背景色
    textview.scrollEnabled = YES;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
    textview.editable = YES;        //是否允许编辑内容，默认为“YES”
    textview.delegate = self;       //设置代理方法的实现类
    textview.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
    textview.layer.borderWidth = 1.0;
    textview.textColor = [UIColor grayColor];
    textview.text = @"请输入其他约定的内容";
    textview.font=[UIFont fontWithName:@"Arial" size:15.0]; //设置字体名字和字体大小;
    textview.returnKeyType = UIReturnKeyDone;//return键的类型
    textview.keyboardType = UIKeyboardTypeDefault;//键盘类型
    textview.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
    //    textview.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
    textview.textColor = [UIColor grayColor];
    //    textview.text = @"UITextView详解";//设置显示的文本内容
    [self addSubview:textview];

    [bgImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@170);
    }];
    [whiteImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@10);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@150);
    }];


    [textview makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@20);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@130);
    }];


    
}
//将要开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    if (_editing == 1) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }

    return YES;
}

//开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView{
}

//将要结束编辑
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView {
    _editing = 2;
    if ([textView.text isEqualToString:@""] || textView.text == nil ) {
        _editing = 1;
        textView.text = @"请输入其他约定的内容";
        textView.textColor = [UIColor grayColor];
    }
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        return YES; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }

    return YES;
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
