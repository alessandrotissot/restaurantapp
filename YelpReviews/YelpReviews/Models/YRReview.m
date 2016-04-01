//
//  YRReview.m
//  YelpReviews
//
//  Created by Alessandro Tissot on 2016-03-30.
//  Copyright © 2016 Alessandro Tissot. All rights reserved.
//

#import "YRReview.h"
#import "NSDictionary+ExtractData.h"

@implementation YRReview

- (id)initWithDictionary:(NSDictionary *)dict {
    
    self = [super init];
    
    if (self) {
        self.excerpt = [dict extractStringForName:@"excerpt"];
        self.rating = [dict extractNumberFromName:@"rating"];
        self.timeCreated = [dict extractNumberFromName:@"time_created"];
        
        if ([dict[@"user"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *userDict = dict[@"user"];
            self.userName = [userDict extractStringForName:@"name"];
        }
    }
    
    return self;
}

@end
