//
//  YRBaseViewController.h
//  YelpReviews
//
//  Created by Alessandro Tissot on 2016-03-29.
//  Copyright © 2016 Alessandro Tissot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRError.h"

@interface YRBaseViewController : UIViewController {
    @private
    UIActivityIndicatorView *_spinner;
}

- (void) showError: (YRError *) error;
- (void) showSpinner;
- (void) hideSpinner;

@end
