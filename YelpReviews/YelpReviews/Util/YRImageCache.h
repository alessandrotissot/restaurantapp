//
//  YRImageCache.h
//  YelpReviews
//
//  Created by Alessandro Tissot on 2016-03-30.
//  Copyright © 2016 Alessandro Tissot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YRImageCache : NSObject {
    @private
    NSCache *_cache;
}

+ (YRImageCache *) sharedInstance;

- (void) cacheImage: (UIImage *) image imageUrl: (NSString *) imageUrl;
- (UIImage *) imageFromUrl: (NSString *) imageUrl;

@end
