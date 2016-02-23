//
//  UlesPublishedView.h
//  CarSource
//
//  Created by apple on 16/1/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^addBtn) (NSString *addButton);
typedef void (^cancelBtn) (NSString *cancelBtn);
typedef void (^deleteBtn) (NSInteger deleteBtn);
typedef void (^imageBtn) (NSInteger imageBtn);

@interface UlesPublishedView : UIView
@property (nonatomic,strong)addBtn addBtn;
@property (nonatomic,strong)cancelBtn cancelBtn;
@property (nonatomic,strong)deleteBtn deleteBtn;
@property (nonatomic,strong)imageBtn imageBtn;
- (void)initAddImagesViewImageArray:(NSMutableArray *)imageArray;
@end
