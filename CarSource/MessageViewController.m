//
//  MessageViewController.m
//  CarSource
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageViewCell.h"
#import "TheSessionView.h"
#import "MyFriendsView.h"

@interface MessageViewController ()<UIScrollViewDelegate>{
    UIButton *_btn;
    UIScrollView *_scrollView;
}

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.view.backgroundColor = [UIColor whiteColor];



    [self initMessageViewController];
}


- (void)initMessageViewController{


    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 104)];
    titleView.backgroundColor = COLOR;
    [self.view addSubview:titleView];

    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 80, 40)];
    titleLabel.text = @"车消息";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:titleLabel];

    UIButton *addButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(SCREEN_WIDTH-80, 20, 80, 40);
    [addButton setTitle:@"添加好友" forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];


    NSArray *array = [[NSArray alloc]initWithObjects:@"会话", @"好友", nil];

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT - 104-49)];
    // 是否支持滑动最顶端
    //    scrollView.scrollsToTop = NO;
    _scrollView.delegate = self;
    // 设置内容大小
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2,SCREEN_HEIGHT - 104 -49);
    // 是否反弹
    _scrollView.bounces = NO;
    // 是否分页
    _scrollView.pagingEnabled = YES;
    // 是否滚动
    //    scrollView.scrollEnabled = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    // 是否同时运动,lock
    _scrollView.directionalLockEnabled = YES;
    [self.view addSubview:_scrollView];

    TheSessionView *session = [[TheSessionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 104-49)];
    session.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:session];


    MyFriendsView *friends = [[MyFriendsView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 104-49)];
    friends.backgroundColor = [UIColor greenColor];
    [_scrollView addSubview:friends];
    for (int i = 0; i < array.count; i++) {
        UIButton *typeButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        typeButton.frame = CGRectMake(SCREEN_WIDTH/2 *i, 64, SCREEN_WIDTH/2, 40);
        [typeButton setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        typeButton.titleLabel.font = [UIFont systemFontOfSize:18];
        typeButton.tag = i +1;
        [typeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [typeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [typeButton addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:typeButton];

        if (i == 0) {
            [self typeButtonClick:typeButton];
        }
    }
}
- (void)addButtonClick:(UIButton *)button{
    
}
- (void)typeButtonClick:(UIButton *)button{
    _btn.selected = NO;
    button.selected = YES;
    _btn = button;

    if (button.tag == 1) {
        CGPoint position = CGPointMake(0, 0);

        [_scrollView setContentOffset:position animated:YES];
    }else{
        CGPoint position = CGPointMake(SCREEN_WIDTH, 0);

        [_scrollView setContentOffset:position animated:YES];
    }
}
// scrollView 已经滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    NSLog(@"scrollViewDidScroll  %f",scrollView.contentOffset.x );

    if (scrollView.contentOffset.x == SCREEN_WIDTH) {
        UIButton *button = (UIButton *) [self.view viewWithTag:2];
        _btn.selected = NO;
        button.selected = YES;
        _btn = button;


    }else{
        UIButton *button = (UIButton *) [self.view viewWithTag:1];
        _btn.selected = NO;
        button.selected = YES;
        _btn = button;

    }
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
