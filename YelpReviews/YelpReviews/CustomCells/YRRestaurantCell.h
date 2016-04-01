//
//  YRRestaurantCell.h
//  YelpReviews
//
//  Created by Alessandro Tissot on 2016-03-29.
//  Copyright © 2016 Alessandro Tissot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRRestaurant.h"

@interface YRRestaurantCell : UITableViewCell {
    
    __weak IBOutlet UIImageView *_imgView;
    __weak IBOutlet UIActivityIndicatorView *_spinner;
    __weak IBOutlet UILabel *_nameLabel;
    __weak IBOutlet UILabel *_addressLabel;
    __weak IBOutlet UILabel *_phoneLabel;
    __weak IBOutlet UILabel *_ratingLabel;
    __weak IBOutlet UILabel *_reviewLabel;
    
    @private
    YRRestaurant *_restaurant;
}


- (void) configure: (YRRestaurant *) restaurant;

@end
