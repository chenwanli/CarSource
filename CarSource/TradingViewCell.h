//
//  TradingViewCell.h
//  CarSource
//
//  Created by apple on 16/1/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TradingViewCell : UITableViewCell
@property (nonatomic,strong)UIButton *userButton;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UIImageView *personalImage;
@property (nonatomic,strong)UILabel *personalLabel;
@property (nonatomic,strong)NSString *moneyStr;
@property (nonatomic,strong)NSString *userStr;
@property (nonatomic,strong)UILabel *configuration;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UIButton *credentialsBtn;
- (void)initOtherGuaranteeViewCellText:(NSString *)text;
@end
