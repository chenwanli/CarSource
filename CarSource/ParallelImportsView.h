//
//  ParallelImportsView.h
//  CarSource
//
//  Created by apple on 16/1/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^addImage) (NSString *addStr);
typedef void (^canceldelete) (NSString *cancelButton);
typedef void (^deleteImage) (NSInteger deleteImage);
typedef void (^toViewImage) (NSInteger toViewImage);
typedef void (^models) (NSString *models);
typedef void (^colorBtn) (NSString *colorBtn);

@interface ParallelImportsView : UIView
@property (nonatomic,strong)addImage addImage;
@property (nonatomic,strong)canceldelete canceldelete;
@property (nonatomic,strong)deleteImage deleteImage;
@property (nonatomic,strong)toViewImage toViewImage;
@property (nonatomic,strong)UIButton *typeButton;
@property (nonatomic,strong)UIButton *colorButton;
@property (nonatomic,strong)models models;
@property (nonatomic,strong)colorBtn colorBtn;
- (void)initAddImageArray:(NSMutableArray *)imageArray;

@end
