//
//  YRError.m
//  YelpReviews
//
//  Created by Alessandro Tissot on 2016-03-29.
//  Copyright © 2016 Alessandro Tissot. All rights reserved.
//

#import "YRError.h"

@implementation YRError

- (id)initWithLocalizedMessage:(NSString *)localizedMessage
{
    self = [super init];
    
    if (self) {
        self.localizedMessage = localizedMessage;
    }
    return self;
}


@end
