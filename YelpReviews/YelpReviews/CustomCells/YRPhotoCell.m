//
//  YRPhotoCell.m
//  YelpReviews
//
//  Created by Alessandro Tissot on 2016-03-31.
//  Copyright © 2016 Alessandro Tissot. All rights reserved.
//

#import "YRPhotoCell.h"
#import "YRYelpClient.h"
#import "YRImageCache.h"

@implementation YRPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(imageLoaded:)
                                                 name:@"ColCellImageLoaded"
                                               object:nil];
}

- (void) configure: (NSString *) imageUrl {
    
    _imageUrl = imageUrl;
    
    UIImage *image = [[YRImageCache sharedInstance] imageFromUrl:imageUrl];
    
    if (image != NULL) {
        _imageView.image = image;
    } else {
        [[YRYelpClient sharedInstance] downloadImage:imageUrl
             success:^(UIImage *image) {
                 [[YRImageCache sharedInstance] cacheImage:image imageUrl:imageUrl];
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"ColCellImageLoaded" object:self];
             }
             failure:^(YRError *error) {
             }
         ];
    }
}

- (void) imageLoaded:(NSNotification *) notification {
    
    if ([[notification name] isEqualToString:@"ColCellImageLoaded"]) {
        UIImage *image = [[YRImageCache sharedInstance] imageFromUrl:_imageUrl];
        
        if (image != NULL) {
            _imageView.image = image;
        }
    }
}

- (UIImage *) getLoadedImage {
    return _imageView.image;
}

@end
