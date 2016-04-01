//
//  UIColor+YRColorScheme.m
//  YelpReviews
//
//  Created by Alessandro Tissot on 2016-03-31.
//  Copyright © 2016 Alessandro Tissot. All rights reserved.
//

#import "UIColor+YRColorScheme.h"

@implementation UIColor (YRColorScheme)

+ (UIColor *) tabBarColor {
    return [UIColor colorWithRed:195.0/255.0 green:47.0/255.0 blue:29.0/255.0 alpha:1.0];
}

+ (UIColor *) titleBarColor {
    return [UIColor colorWithRed:207.0/255.0 green:51.0/255.0 blue:29.0/255.0 alpha:1.0];
}

+ (UIColor *) backgroundColor {
    return [UIColor colorWithRed:213.0/255.0 green:193.0/255.0 blue:148.0/255.0 alpha:1.0];
}

+ (UIColor *) titleTextColor {
    return [UIColor backgroundColor];
}

+ (UIColor *) searchBarColor {
    return [UIColor colorWithRed:233.0/255.0 green:153.0/255.0 blue:28.0/255.0 alpha:1.0];
}

@end
