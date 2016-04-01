//
//  YRError.h
//  YelpReviews
//
//  Created by Alessandro Tissot on 2016-03-29.
//  Copyright © 2016 Alessandro Tissot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YRError : NSObject

@property NSString *localizedMessage;

- (id)initWithLocalizedMessage:(NSString *)localizedMessage;

@end
