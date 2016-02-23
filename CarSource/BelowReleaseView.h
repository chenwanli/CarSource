//
//  BelowReleaseView.h
//  CarSource
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^colorButton) (NSString *colorButton);
typedef void (^addImage) (NSString *addStr);
typedef void (^canceldelete) (NSString *cancelButton);
typedef void (^deleteImage) (NSInteger deleteImage);
typedef void (^toViewImage) (NSInteger toViewImage);
typedef void (^typeBtn) (NSString *typeBtn);
@interface BelowReleaseView : UIView
@property (nonatomic,strong)addImage addImage;
@property (nonatomic,strong)canceldelete canceldelete;
@property (nonatomic,strong)deleteImage deleteImage;
@property (nonatomic,strong)toViewImage toViewImage;
@property (nonatomic,strong)typeBtn typeBtn;
@property (nonatomic,strong)colorButton colorButton;
@property (nonatomic,strong)UIButton *typeButton;
@property (nonatomic,strong)UIButton *colorBtn;
- (void)initAddImageArray:(NSMutableArray *)imageArray;
@end
