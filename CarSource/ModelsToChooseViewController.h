//
//  ModelsToChooseViewController.h
//  CarSource
//
//  Created by apple on 16/1/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^chooseType) (NSString *chooseType);
@interface ModelsToChooseViewController : UIViewController
@property (nonatomic,strong)chooseType chooseType;
@end
