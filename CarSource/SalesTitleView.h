//
//  SalesTitleView.h
//  CarSource
//
//  Created by apple on 16/1/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^brandBtn) (NSInteger brandBtn);
@interface SalesTitleView : UIView
@property (nonatomic,strong)brandBtn brandBtn;
- (void)provincesStr:(NSString *)provincesStr;
- (void)memberTypeStr:(NSString *)memberTypeStr;
- (void)vehicleStr:(NSString *)vehicleStr;
@end
