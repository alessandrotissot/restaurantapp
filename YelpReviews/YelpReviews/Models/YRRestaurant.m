//
//  YRRestaurant.m
//  YelpReviews
//
//  Created by Alessandro Tissot on 2016-03-29.
//  Copyright © 2016 Alessandro Tissot. All rights reserved.
//

#import "YRRestaurant.h"
#import "NSDictionary+ExtractData.h"

@implementation YRRestaurant

- (id)initWithDictionary:(NSDictionary *)dict {
    
    self = [super init];
    
    if (self) {
        self.restaurantId = [dict extractStringForName: @"id"];
        self.name = [dict extractStringForName:@"name"];
        self.displayPhone = [dict extractStringForName:@"display_phone"];
        self.imageUrl = [dict extractStringForName:@"image_url"];
        self.phone = [dict extractStringForName:@"phone"];
        self.snippetText = [dict extractStringForName:@"snippet_text"];
        self.rating = [dict extractNumberFromName:@"rating"];
        self.ratingCount = [dict extractNumberFromName:@"review_count"];
        
        if ([dict[@"location"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *locationDict = dict[@"location"];
            self.address = [locationDict extractStringForName:@"address"];
            self.city = [locationDict extractStringForName:@"city"];
            self.displayAddress = [locationDict extractStringForName:@"display_address"];
            
            if ([locationDict[@"coordinate"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *coordinateDict = locationDict[@"coordinate"];
                
                self.latitude = [coordinateDict extractNumberFromName:@"latitude"];
                self.longitude = [coordinateDict extractNumberFromName:@"longitude"];
            }
        }
        
        NSMutableArray *tmpReviews = [[NSMutableArray alloc] init];
        
        if ([dict[@"reviews"] isKindOfClass:[NSArray class]]) {
            NSArray *reviewsArray = dict[@"reviews"];
            
            for (NSDictionary *reviewDict in reviewsArray) {
                YRReview *review = [[YRReview alloc] initWithDictionary:reviewDict];
                [tmpReviews addObject:review];
            }
        }
        
        self.reviews = [tmpReviews copy];
    }
    
    return self;
}

@end
