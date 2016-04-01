//
//  YRRestaurant+ActiveRecord.h
//  YelpReviews
//
//  Created by Alessandro Tissot on 2016-03-30.
//  Copyright © 2016 Alessandro Tissot. All rights reserved.
//

#import "YRRestaurant.h"
#import "YRError.h"

@interface YRRestaurant (ActiveRecord)

+ (void)search: (NSString *) query
          sort: (int) sort
       success: (void (^)(NSArray *restaurants)) success
       failure: (void (^)(YRError *error)) failure;

+ (void)loadRestaurant: (NSString *) restaurantId
               success: (void (^)(YRRestaurant *restaurant)) success
               failure: (void (^)(YRError *error)) failure;
@end
