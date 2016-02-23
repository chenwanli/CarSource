//
//  ResourcesRequest.m
//  CarSource
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ResourcesRequest.h"
#import "AFNetworking.h"
#import "CarSerieType.h"
#import "SalesListModel.h"
#import "provincesModel.h"
#import "UserTypesModel.h"
#import "SearchCarModel.h"
#define RESULTCODE @"0"


@implementation ResourcesRequest
#pragma --
#pragma mark//获取车系详细信息
+ (void)postForCarsThatDetailedInformationRequestWithCarSeriesId:(NSString *)carSeriesId showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"carSeriesId":carSeriesId};
    //            NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@configuration/get_car_series_detail",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //                NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            showCarList(nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取信息失败" zoom:NO shadow:NO];
            }
        }else{
            NSMutableArray *carArray = [NSMutableArray array];
            CarSerieType *carSerie = [CarSerieType carSerieTypeWithDictionary:data[@"data"]];
            [carArray addObject:carSerie];
            showCarList(carArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }

    }];
}

#pragma --
#pragma mark//获取发布销售车辆列表
+ (void)postGetMySalesListRequestWithCarUserId:(NSString *)userId page:(NSString *)page showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"userId":userId,@"page":page};
//                NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@sales/get_sales_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //                NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            showCarList(nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取信息失败" zoom:NO shadow:NO];
            }
        }else{
            NSMutableArray *salesArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *salesDict in array) {
                SalesListModel *carSerie = [SalesListModel salesListModelWithDictionary:salesDict];
                [salesArray addObject:carSerie];
            }
            showCarList(salesArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }

    }];
}

#pragma --
#pragma mark//获取城市中 省 列表
+ (void)postListForProvinceInTheCityWithCarShowCarList:(showCarList)showCarList{
//    NSDictionary *parameters = @{@"userId":userId,@"page":page};
    //                NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@configuration/get_province_city_list",HTTPREQUEST] parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        //                NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            showCarList(nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取信息失败" zoom:NO shadow:NO];
            }
        }else{
            NSMutableArray *provincesArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *salesDict in array) {
                provincesModel *carSerie = [provincesModel provincesModelWithDictionary:salesDict];
                [provincesArray addObject:carSerie];
            }
            showCarList(provincesArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }
        
    }];
}

#pragma --
#pragma mark//根据用户所在区域获取发布销售车辆列表
+ (void)postAccordingToTheUsersAreaToObtainAListReleasedSalesVehiclesWithUserId:(NSString *)userId city:(NSString *)city area:(NSString *)area page:(NSString *)page showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"userId":userId,@"city":city,@"area":area,@"page":page};
//                    NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@sales/get_city_sales_car_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //                NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            showCarList(nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取信息失败" zoom:NO shadow:NO];
            }
        }else{
            NSMutableArray *salesArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *salesDict in array) {
                SalesListModel *carSerie = [SalesListModel salesListModelWithDictionary:salesDict];
                [salesArray addObject:carSerie];
            }
            showCarList(salesArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }
        
    }];
}

#pragma --
#pragma mark//获取用户类型
+ (void)postGetTheUserTypesRequestWithShowCarList:(showCarList)showCarList{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@users/user_type",HTTPREQUEST] parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        //                NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            showCarList(nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取信息失败" zoom:NO shadow:NO];
            }
        }else{
            NSMutableArray *userArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *userDict in array) {

                UserTypesModel *carSerie = [UserTypesModel userTypesModelWithDictionary:userDict];
                [userArray addObject:carSerie];
            }
            showCarList(userArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }
        
    }];
}

#pragma --
#pragma mark//根据用户会员类型获取发布销售车辆列表
+ (void)postDependingOnTheTypeOfUserMembersToObtainAListReleasedSalesVehiclesReleasedSalesVehiclesWithUserId:(NSString *)userId userITyped:(NSString *)userITyped  page:(NSString *)page showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"userId":userId,@"userITyped":userITyped,@"page":page};
    //                    NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@sales/get_sales_userType_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //                NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            showCarList(nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取信息失败" zoom:NO shadow:NO];
            }
        }else{
            NSMutableArray *salesArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *salesDict in array) {
                SalesListModel *carSerie = [SalesListModel salesListModelWithDictionary:salesDict];
                [salesArray addObject:carSerie];
            }
            showCarList(salesArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }

    }];
}

#pragma --
#pragma mark//根据车品牌获取发布销售车辆列表
+ (void)postAccordingToTheCarBrandToObtainAListReleasedSalesVehiclesWithUserId:(NSString *)userId specificationId:(NSString *)specificationId  brandId:(NSString *)brandId page:(NSString *)page showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"userId":userId,@"specificationId":specificationId,@"brandId":brandId, @"page":page};
    //                    NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@sales/get_sales_brand_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //                NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                        NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            showCarList(nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取信息失败"zoom:NO shadow:NO];
            }
        }else{
            NSMutableArray *salesArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *salesDict in array) {
                SalesListModel *carSerie = [SalesListModel salesListModelWithDictionary:salesDict];
                [salesArray addObject:carSerie];
            }
            showCarList(salesArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }
        
    }];
}

#pragma --
#pragma mark//获取默认寻车列表
+ (void)postGetTheDefaultSearchListRequestWithPage:(NSString *)page showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"page":page};
    //                NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@search_car/get_search_car_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //                NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            showCarList(nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取信息失败" zoom:NO shadow:NO];
            }
        }else{
            NSMutableArray *salesArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *salesDict in array) {
                SearchCarModel *carSerie = [SearchCarModel searchCarModelWithDictionary:salesDict];
                [salesArray addObject:carSerie];
            }
            showCarList(salesArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }
        
    }];
}

#pragma --
#pragma mark//获取指定地区 寻车列表
+ (void)postToObtainAListSpecifiedAreasForCarRequestWithCity:(NSString *)city area:(NSString *)area page:(NSString *)page showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"city":city,@"area":area,@"page":page};
    //                NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@search_car/get_city_search_car_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //                NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            showCarList(nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取信息失败" zoom:NO shadow:NO];
            }
        }else{
            NSMutableArray *salesArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *salesDict in array) {
                SearchCarModel *carSerie = [SearchCarModel searchCarModelWithDictionary:salesDict];
                [salesArray addObject:carSerie];
            }
            showCarList(salesArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }

    }];
}

#pragma --
#pragma mark//获取指定品牌寻车列表
+ (void)postToObtainAListSpecifiedBrandForTheCarRequestWithBrandId:(NSString *)brandId specificationId:(NSString *)specificationId page:(NSString *)page showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"brandId":brandId,@"specificationId":specificationId,@"page":page};
    //                NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@search_car/get_brand_search_car_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //                NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            showCarList(nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取信息失败" zoom:NO shadow:NO];
            }
        }else{
            NSMutableArray *salesArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *salesDict in array) {
                SearchCarModel *carSerie = [SearchCarModel searchCarModelWithDictionary:salesDict];
                [salesArray addObject:carSerie];
            }
            showCarList(salesArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }

    }];
}


#pragma --
#pragma mark//添加中规寻车
+ (void)postAddRulesFoundInCarsRequestWithUserId:(NSString *)userId text:(NSString *)text userTypeId:(NSString *)userTypeId seriesTypeId:(NSString *)seriesTypeId  showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"userId":userId,@"text":text,@"userTypeId":userTypeId,@"seriesTypeId":seriesTypeId};
                    NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@search_car/add_default_search_car",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //                NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //        NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            showCarList(nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取信息失败" zoom:NO shadow:NO];
            }
        }else{
//            NSMutableArray *salesArray = [NSMutableArray array];
//            NSMutableArray *array = data[@"data"];
//            for (NSDictionary *salesDict in array) {
//                SearchCarModel *carSerie = [SearchCarModel searchCarModelWithDictionary:salesDict];
//                [salesArray addObject:carSerie];
//            }
//            showCarList(salesArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }
        
    }];
}

+ (void)checkNetWorkStatus{
    /**
     *  AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     *  AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     *  AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G
     *  AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络Wifi
     */
    // 如果要检测网络状态的变化, 必须要用检测管理器的单例startMoitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status == AFNetworkReachabilityStatusNotReachable){
            //            NSLog(@"网络连接已断开，请检查您的网络！");
            SHOW_ALERT( @"网络连接已断开，请检查您的网络！")
        }else{
            SHOW_ALERT( @"服务器异常")
        }
    }];
    
}

@end
