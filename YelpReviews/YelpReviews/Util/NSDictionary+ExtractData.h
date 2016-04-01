//
//  NSDictionary+ExtractData.h
//  YelpReviews
//
//  Created by Alessandro Tissot on 2016-03-29.
//  Copyright © 2016 Alessandro Tissot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ExtractData)

- (NSString *) extractStringForName: (NSString *) itemName;
- (NSNumber *) extractNumberFromName: (NSString *) itemName;

@end
