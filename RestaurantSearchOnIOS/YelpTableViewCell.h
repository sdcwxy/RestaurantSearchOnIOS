//
//  YelpTableViewCell.h
//  RestaurantSearchOnIOS
//
//  Created by zhonglis on 10/22/17.
//  Copyright © 2017 steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YelpDataModel.h"

@interface YelpTableViewCell : UITableViewCell

- (void)updateBasedOnDataModel:(YelpDataModel *)dataModel;

@end
