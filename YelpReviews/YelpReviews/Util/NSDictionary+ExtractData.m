//
//  NSDictionary+ExtractData.m
//  YelpReviews
//
//  Created by Alessandro Tissot on 2016-03-29.
//  Copyright © 2016 Alessandro Tissot. All rights reserved.
//

#import "NSDictionary+ExtractData.h"

@implementation NSDictionary (ExtractData)

- (NSString *) extractStringForName: (NSString *) itemName {
    NSString *ret = @"";
    
    if ([self[itemName] isKindOfClass:[NSString class]]) {
        ret = self[itemName] != nil ? self[itemName] : @"";
    } else if ([self[itemName] isKindOfClass:[NSArray class]]) {
        NSArray *values = self[itemName];
        for (NSString *value in values) {
            ret = [ret stringByAppendingString:value];
            if (value != values.lastObject) {
                ret = [ret stringByAppendingString:@"\n"];
            }
        }
    }
    
    return ret;
}

- (NSNumber *) extractNumberFromName: (NSString *) itemName {
    NSNumber *ret = [NSNumber numberWithDouble:0.0];
    
    if ([self[itemName] isKindOfClass:[NSNumber class]]) {
        ret = self[itemName];
    }
    
    return ret;
}

@end
