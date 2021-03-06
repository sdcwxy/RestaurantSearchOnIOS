//
//  DetailViewHeaderTableViewCell.h
//  RestaurantSearchOnIOS
//
//  Created by zhonglis on 10/22/17.
//  Copyright © 2017 steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YelpDataModel.h"

@interface DetailViewHeaderTableViewCell : UITableViewCell

- (void)updateBasedOnDataModel:(YelpDataModel *)dataModel;

- (instancetype)initWithDataModel:(YelpDataModel *)dataModel;

@end
