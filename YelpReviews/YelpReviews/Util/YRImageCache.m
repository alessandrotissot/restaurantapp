//
//  YRImageCache.m
//  YelpReviews
//
//  Created by Alessandro Tissot on 2016-03-30.
//  Copyright © 2016 Alessandro Tissot. All rights reserved.
//

#import "YRImageCache.h"

@implementation YRImageCache

static YRImageCache *instance = nil;

+ (YRImageCache *) sharedInstance {
    if (instance == nil) {
        instance = [[YRImageCache alloc] init];
    }
    
    return instance;
}

- (id)init {
    self = [super init];
    
    if (self) {
        _cache = [[NSCache alloc] init];
    }
    
    return self;
}

- (void) cacheImage: (UIImage *) image imageUrl: (NSString *) imageUrl {
    [_cache setObject:image forKey:imageUrl];
}

- (UIImage *) imageFromUrl: (NSString *) imageUrl {
    return [_cache objectForKey:imageUrl];
}

@end
