//
//  ChooseBrandViewController.h
//  CarSource
//
//  Created by apple on 16/1/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^vehicleId) (NSString *vehicleId,NSString *vehicleName,NSString *specificationId);
@interface ChooseBrandViewController : UIViewController
@property (nonatomic,assign)NSInteger chooseBrand;
@property (nonatomic,strong)vehicleId vehicleId;
@end
