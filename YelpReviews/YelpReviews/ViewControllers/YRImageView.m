//
//  YRImageView.m
//  YelpReviews
//
//  Created by Alessandro Tissot on 2016-04-01.
//  Copyright © 2016 Alessandro Tissot. All rights reserved.
//

#import "YRImageView.h"

@implementation YRImageView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView.minimumZoomScale = 1.0;
    _scrollView.maximumZoomScale = 3.0;
    _scrollView.delegate = self;
    
    _imgView.image = _image;
}

- (void) configure: (UIImage *) image {
    _image = image;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imgView;
}

@end
