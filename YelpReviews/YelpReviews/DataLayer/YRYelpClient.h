//
//  YRYelpClient.h
//  YelpReviews
//
//  Created by Alessandro Tissot on 2016-03-29.
//  Copyright © 2016 Alessandro Tissot. All rights reserved.
//

#import <BDBOAuth1Manager/BDBOAuth1RequestOperationManager.h>
#import "YRRestaurant.h"
#import "YRError.h"

@interface YRYelpClient : BDBOAuth1RequestOperationManager

+ (YRYelpClient *) sharedInstance;

- (void)search: (NSString *) query
      maxRows: (int) maxRows
         sort: (int) sort
      success: (void (^)(NSDictionary *dict)) success
      failure: (void (^)(YRError *error)) failure;

- (void) downloadImage: (NSString *) imageUrl
               success: (void (^)(UIImage *image)) success
               failure: (void (^)(YRError *error)) failure;

- (void)loadRestaurant: (NSString *) restaurantId
               success: (void (^)(NSDictionary *dict)) success
               failure: (void (^)(YRError *error)) failure;


- (void)loadUserImages: (NSString *) restaurantId
               success: (void (^)(NSArray *images)) success
               failure: (void (^)(YRError *error)) failure;

@end
