//
//  YelpNetWorking.h
//  RestaurantSearchOnIOS
//
//  Created by zhonglis on 10/22/17.
//  Copyright © 2017 steve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YelpDataModel.h"

@import CoreLocation;

typedef void (^RestaurantCompletionBlock)(NSArray <YelpDataModel *>* dataModelArray);

@interface YelpNetWorking : NSObject

+ (YelpNetWorking *)sharedInstance;

- (void)fetchRestaurantsBasedOnLocation:(CLLocation *)location term:(NSString *)term completionBlock:(RestaurantCompletionBlock)completionBlock;

@end

