//
//  YRRestaurant.h
//  YelpReviews
//
//  Created by Alessandro Tissot on 2016-03-29.
//  Copyright © 2016 Alessandro Tissot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YRReview.h"

@interface YRRestaurant : NSObject

@property NSString *restaurantId;
@property NSString *name;
@property NSString *displayPhone;
@property NSString *imageUrl;
@property NSString *address;
@property NSString *displayAddress;
@property NSString *city;
@property NSNumber *rating;
@property NSNumber *ratingCount;
@property NSString *phone;
@property NSString *snippetText;
@property NSNumber *latitude;
@property NSNumber *longitude;
@property NSArray  *reviews;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
