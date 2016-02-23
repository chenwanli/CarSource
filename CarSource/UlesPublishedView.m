//
//  UlesPublishedView.m
//  CarSource
//
//  Created by apple on 16/1/6.
//  Copyright © 2016年 apple. All rights reserved.
//
// 中规发布
#import "UlesPublishedView.h"
#import "MLSelectPhotoAssets.h"
#import "MLSelectPhotoPickerAssetsViewController.h"
#import "MLSelectPhotoBrowserViewController.h"

@interface UlesPublishedView ()<UITextViewDelegate,UIScrollViewDelegate>
{
    UIView *_addView;
    UIButton *_cancelButton;
    UIButton *_addButton;
    UIScrollView *_scrollView;
    NSInteger _cancel;
    UIView *_chooseView;
    UIButton *_submitButton;
}

@end

@implementation UlesPublishedView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{

    _cancel = 1;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 99)];
    _scrollView.delegate = self;
    // 设置内容大小
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,480 + (SCREEN_WIDTH - 20)/3);
    // 是否反弹
    _scrollView.bounces = NO;
    _scrollView.scrollEnabled = YES;
    _scrollView.backgroundColor = GRAY;
    _scrollView.showsHorizontalScrollIndicator = NO;
    //        _scrollView.directionalLockEnabled = YES;
    [self addSubview:_scrollView];

    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
    bgImage.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:bgImage];

    //初始化并定义大小
    UITextView *textview = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH -20, 140)];
    textview.backgroundColor=[UIColor whiteColor]; //背景色
    textview.scrollEnabled = YES;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
    textview.editable = YES;        //是否允许编辑内容，默认为“YES”
    textview.delegate = self;       //设置代理方法的实现类
    textview.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
    textview.layer.borderWidth = 1.0;
    //    textview.
    textview.font=[UIFont fontWithName:@"Arial" size:15.0]; //设置字体名字和字体大小;
    textview.returnKeyType = UIReturnKeyDefault;//return键的类型
    textview.keyboardType = UIKeyboardTypeDefault;//键盘类型
    textview.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
    //    textview.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
    textview.textColor = [UIColor blackColor];
    //    textview.text = @"UITextView详解";//设置显示的文本内容
    [_scrollView addSubview:textview];

    UILabel *addLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 170, SCREEN_WIDTH, 40)];
    addLabel.textColor = [UIColor grayColor];
    addLabel.font = [UIFont systemFontOfSize:16];
    addLabel.backgroundColor = LIGHTBLUE;
    addLabel.text = @"  添加图片";
    addLabel.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
    addLabel.layer.borderWidth = 1.0;
    [_scrollView addSubview:addLabel];

    _cancelButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton.frame = CGRectMake(SCREEN_WIDTH - 120, 170, 120, 40);
    [_cancelButton setTitle:@"取消删除" forState:UIControlStateNormal];
    [_cancelButton setTitle:@"删除" forState:UIControlStateSelected];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_cancelButton setTitleColor:COLOR forState:UIControlStateNormal];
    _cancelButton.backgroundColor = LIGHTBLUE;
    [_cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_cancelButton];

    _cancelButton.hidden = YES;

    _addView = [[UIView alloc]initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, (SCREEN_WIDTH - 20)/3 +20)];
    _addView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_addView];

    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addButton.frame = CGRectMake(10, 10, (SCREEN_WIDTH - 10)/3 - 10, (SCREEN_WIDTH - 20)/3-10);
    [_addButton setBackgroundImage:[UIImage imageNamed:@"gift"] forState:UIControlStateNormal];

    [_addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_addView addSubview:_addButton];

    _chooseView = [[UIView alloc]initWithFrame:CGRectMake(0, 240 +  (SCREEN_WIDTH - 20)/3, SCREEN_WIDTH, 132)];
    _chooseView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_chooseView];

    NSArray *arr = [[NSArray alloc]initWithObjects:@"  谁可以看", @"  选择品牌", @"  会员类型", nil];

    for (int i = 0; i < arr.count; i++) {

        UIButton *chooseBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        chooseBtn.frame = CGRectMake(0, 44 *i, SCREEN_WIDTH, 44);
        chooseBtn.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
        chooseBtn.layer.borderWidth = 1.0;
        [chooseBtn setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
        if (i == 0) {
            chooseBtn.backgroundColor = LIGHTBLUE;
        }else{
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 30, 44 *i +12, 15, 18)];
            imageView.image = [UIImage imageNamed:@"milled"];
            [_chooseView addSubview:imageView];
        }

        [chooseBtn setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
        chooseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        chooseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [chooseBtn addTarget:self action:@selector(chooseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_chooseView addSubview:chooseBtn];

    }

    _submitButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [_submitButton setTitle:@"确定发布" forState:UIControlStateNormal];
    _submitButton.frame = CGRectMake(50,400 + (SCREEN_WIDTH - 20)/3, SCREEN_WIDTH - 100, 50);
    _submitButton.titleLabel.font = [UIFont systemFontOfSize:16];

    _submitButton.layer.cornerRadius = 5;
    _submitButton.layer.masksToBounds = YES;
    //    [_submitButton setTitleColor:COLOR forState:UIControlStateNormal];
    _submitButton.backgroundColor = COLOR;
    [_submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_submitButton];

}
- (void)initAddImagesViewImageArray:(NSMutableArray *)imageArray{

    [_addView removeFromSuperview];

    _addView = [[UIView alloc]init];
    _addView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_addView];

    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addButton setBackgroundImage:[UIImage imageNamed:@"gift"] forState:UIControlStateNormal];

    [_addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_addView addSubview:_addButton];

    if (imageArray.count == 0) {
        _cancelButton.hidden = YES;
        _addView.frame = CGRectMake(0, 210, SCREEN_WIDTH, (SCREEN_WIDTH - 20)/3 +20);

        _addButton.frame = CGRectMake(10, 10, (SCREEN_WIDTH - 10)/3 - 10, (SCREEN_WIDTH - 20)/3-10);

    }

    @autoreleasepool
    {


        int totalloc=3;
        CGFloat appvieww=(SCREEN_WIDTH- 20)/3-5;
        CGFloat appviewh=(SCREEN_WIDTH- 20)/3-5;
        CGFloat margin=((SCREEN_WIDTH- 20) -totalloc*appvieww)/(totalloc+1);

        for (int i = 0; i < imageArray.count; i++) {

            int row=i/totalloc;//行号
            //1/3=0,2/3=0,3/3=1;
            int loc=i%totalloc;//列号
            CGFloat appviewx=margin+(margin+appvieww)*loc;
            CGFloat appviewy=margin+(margin+appviewh)*row;
            UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
            imageButton.frame = CGRectMake(appviewx +10, appviewy +10, (SCREEN_WIDTH - 20)/3 - 10, (SCREEN_WIDTH - 20)/3 - 10);
            // 判断类型来获取Image
            MLSelectPhotoAssets *asset = imageArray[i];

            [imageButton setBackgroundImage:[MLSelectPhotoPickerViewController getImageWithImageObj:asset] forState:UIControlStateNormal];

            [imageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            imageButton.tag = i ;

            [_addView addSubview:imageButton];

            imageButton = nil;

            if (_cancel == 1) {
                UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
                deleteButton.frame = CGRectMake(appviewx +(SCREEN_WIDTH - 20)/3 -22, appviewy +2, 30, 30);
                [deleteButton setBackgroundImage:[UIImage imageNamed:@"esc"] forState:UIControlStateNormal];
                [deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                deleteButton.tag = i +1;
                [_addView addSubview:deleteButton];
                deleteButton = nil;

            }

            if (i == imageArray.count -1) {

                _cancelButton.hidden = NO;
                int line=(i +1)/totalloc;//行号
                //1/3=0,2/3=0,3/3=1;
                int column=(i +1)%totalloc;//列号
                CGFloat x=margin+(margin+appvieww)*column;
                CGFloat y=margin+(margin+appviewh)*line;
                if (i<8) {

                    _addButton.hidden = NO;
                    _addButton.frame = CGRectMake(x+10, y +10, (SCREEN_WIDTH - 20)/3 - 10, (SCREEN_WIDTH - 20)/3 - 10);
                    _addView.frame = CGRectMake(0, 210, SCREEN_WIDTH, (SCREEN_WIDTH - 20)/3 *(line +1) +20);

                    _chooseView.frame = CGRectMake(0, 240 +  (SCREEN_WIDTH - 20)/3*(line +1), SCREEN_WIDTH, 132);

                    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,480 +(SCREEN_WIDTH - 20)/3*(line +1));
                    _submitButton.frame = CGRectMake(50,400 + (SCREEN_WIDTH - 20)/3 *(line +1), SCREEN_WIDTH - 100, 50);

                }else{
                    _addButton.hidden = YES;
                    _addView.frame = CGRectMake(0, 210, SCREEN_WIDTH, (SCREEN_WIDTH - 20)/3 *line +20);
                    _chooseView.frame = CGRectMake(0, 240 +  (SCREEN_WIDTH - 20)/3*line, SCREEN_WIDTH, 132);
                    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,480 +(SCREEN_WIDTH - 20)/3*line );
                    _submitButton.frame = CGRectMake(50,400 + (SCREEN_WIDTH - 20)/3 *line, SCREEN_WIDTH - 100, 50);

                }
            }
        }
    }
}
- (void)addButtonClick:(UIButton *)button{

    self.addBtn(nil);

}

- (void)deleteButtonClick:(UIButton *)button{

    self.deleteBtn(button.tag - 1);

}


- (void)imageButtonClick:(UIButton *)button{
    self.imageBtn(button.tag);

}
- (void)cancelButtonClick:(UIButton *)button{

    button.selected = !button.selected;

    if (button.selected) {
        _cancel = 0;
    }else{
        _cancel = 1;
    }

    self.cancelBtn(nil);


}
- (void)submitButtonClick:(UIButton *)button{

}
- (void)chooseButtonClick:(UIButton *)button{

}
//将要开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    return YES;
}

//将要结束编辑
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    return YES;
}

//开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView{

}

//结束编辑
- (void)textViewDidEndEditing:(UITextView *)textView{

}
- (BOOL)textFieldShouldReturn:(UITextView *)textView
{
    [textView resignFirstResponder];
    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    return YES;
}
//内容将要发生改变编辑
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    return YES;
}

//内容发生改变编辑
- (void)textViewDidChange:(UITextView *)textView{
}


//焦点发生改变
- (void)textViewDidChangeSelection:(UITextView *)textView{

}
////有时候我们要控件自适应输入的文本的内容的高度，只要在textViewDidChange的代理方法中加入调整控件大小的代理即可
//- (void)textViewDidChange:(UITextView *)textView{
//    //计算文本的高度
//    CGSize constraintSize;
//    constraintSize.width = textView.frame.size.width-16;
//    constraintSize.height = MAXFLOAT;
//    CGSize sizeFrame =[textView.text sizeWithFont:textView.font
//                                constrainedToSize:constraintSize
//                                    lineBreakMode:UILineBreakModeWordWrap];
//
//    //重新调整textView的高度
//    textView.frame = CGRectMake(textView.frame.origin.x,textView.frame.origin.y,textView.frame.size.width,sizeFrame.height+5);
//}


//控制输入文字的长度和内容，可通调用以下代理方法实现
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if (range.location>=100)
//    {
//        //控制输入文本的长度
//        return  NO;
//    }
//    if ([text isEqualToString:@"\n"]) {
//        //禁止输入换行
//        return NO;
//    }
//    else
//    {
//        return YES;
//    }
//}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
