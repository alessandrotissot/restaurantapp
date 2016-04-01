//
//  YRReview.h
//  YelpReviews
//
//  Created by Alessandro Tissot on 2016-03-30.
//  Copyright © 2016 Alessandro Tissot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YRReview : NSObject

@property NSString *userName;
@property NSString *excerpt;
@property NSNumber *rating;
@property NSNumber *timeCreated;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
