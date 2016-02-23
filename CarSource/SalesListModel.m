//
//  SalesListModel.m
//  CarSource
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//
//获取发布销售车辆列表
#import "SalesListModel.h"

@implementation SalesListModel
+ (SalesListModel *)salesListModelWithDictionary:(NSDictionary *)dict{
    SalesListModel *sales = [[SalesListModel alloc]init];
    sales.addressCounties = dict[@"addressCounties"];//车身颜色/内饰颜色
    sales.authenticateTypeName = dict[@"authenticateTypeName"];//展车ID
    sales.carSeriesName = dict[@"carSeriesName"];//简介
    sales.carSeriesTypeName = dict[@"carSeriesTypeName"];//展车型
    sales.imageList = dict[@"imageList"];// 发布销售图
    sales.modelsPrice = dict[@"modelsPrice"];//销售价格
    sales.salesCarsType = dict[@"salesCarsType"];//销售类型（0 现车，1期货）
    sales.salesId = dict[@"salesId"];//销售ID
    sales.salesModelsColour = dict[@"salesModelsColour"];//销售车型颜色
    sales.salesShelfNumber = dict[@"salesShelfNumber"];//销售车架号
    sales.salesText = dict[@"salesText"];//销售详细内容
    sales.salesTime = dict[@"salesTime"];//发布销售时间
    sales.specificationText = dict[@"specificationText"];// 展车规格类型
    sales.userName = dict[@"userName"];//展车价格
    sales.userTel = dict[@"userTel"];//展车发布时间
    sales.userTypeName = dict[@"userTypeName"];//展车首图
    sales.userUrl = dict[@"userUrl"];//销售用户的头像

    return sales;
}

@end
