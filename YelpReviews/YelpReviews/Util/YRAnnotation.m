//
//  YRAnnotation.m
//  YelpReviews
//
//  Created by Alessandro Tissot on 2016-03-30.
//  Copyright © 2016 Alessandro Tissot. All rights reserved.
//

#import "YRAnnotation.h"

@implementation YRAnnotation

- (id)initWithLocation:(CLLocationCoordinate2D)coord
{
    self = [super init];
    if (self) {
        self.coordinate = coord;
    }
    return self;
}

@end
