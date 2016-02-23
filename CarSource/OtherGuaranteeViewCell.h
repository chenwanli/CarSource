//
//  OtherGuaranteeViewCell.h
//  CarSource
//
//  Created by apple on 15/12/21.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherGuaranteeViewCell : UITableViewCell
@property (nonatomic,strong)UIButton *userButton;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UIImageView *personalImage;
@property (nonatomic,strong)UILabel *personalLabel;
@property (nonatomic,strong)NSString *moneyStr;
@property (nonatomic,strong)NSString *userStr;
@property (nonatomic,strong)UILabel *configuration;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UIButton *credentialsBtn;
@property (nonatomic,strong)UIButton *payButton;
@property (nonatomic,strong)UIButton *deleteBtn;
@property (nonatomic,strong)UILabel *promptLabel;
- (void)initOtherGuaranteeViewCellText:(NSString *)text;
@end
