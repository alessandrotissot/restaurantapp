//
//  YRImageView.h
//  YelpReviews
//
//  Created by Alessandro Tissot on 2016-04-01.
//  Copyright © 2016 Alessandro Tissot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YRImageView : UIViewController <UIScrollViewDelegate> {
    __weak IBOutlet UIImageView *_imgView;
    __weak IBOutlet UIScrollView *_scrollView;
    
    @private
    UIImage * _image;
}

- (void) configure: (UIImage *) image;

@end
