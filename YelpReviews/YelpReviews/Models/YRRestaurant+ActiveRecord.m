//
//  YRRestaurant+ActiveRecord.m
//  YelpReviews
//
//  Created by Alessandro Tissot on 2016-03-30.
//  Copyright © 2016 Alessandro Tissot. All rights reserved.
//

#import "YRRestaurant+ActiveRecord.h"
#import "YRYelpClient.h"

@implementation YRRestaurant (ActiveRecord)

+ (void)search: (NSString *) query
          sort: (int) sort
       success: (void (^)(NSArray *restaurants)) success
       failure: (void (^)(YRError *error)) failure {
    
    [[YRYelpClient sharedInstance] search:@"Ethiopian" maxRows:20 sort:sort
      success:^(NSDictionary *dict) {
          NSMutableArray *restaurants = [[NSMutableArray alloc] init];
          
          if([dict[@"businesses"] isKindOfClass:[NSArray class]]) {
              NSArray *restaurantArray = dict[@"businesses"];
              for (NSDictionary *restaurantDict in restaurantArray) {
                  YRRestaurant *restaurant = [[YRRestaurant alloc] initWithDictionary: restaurantDict];
                  
                  [restaurants addObject: restaurant];
              }
              success(restaurants);
          } else {
              YRError *err = [[YRError alloc] initWithLocalizedMessage:@"The application has encountered an unknown error."];
              failure(err);
          }
      }
      failure:^(YRError *error) {
          failure(error);
      }
     ];
}

+ (void)loadRestaurant: (NSString *) restaurantId
               success: (void (^)(YRRestaurant *restaurant)) success
               failure: (void (^)(YRError *error)) failure {

    [[YRYelpClient sharedInstance] loadRestaurant:restaurantId
          success:^(NSDictionary *dict) {
              YRRestaurant *restaurant = [[YRRestaurant alloc] initWithDictionary: dict];
              success(restaurant);
          }
          failure:^(YRError *error) {
              failure(error);
          }
     ];
}
@end
