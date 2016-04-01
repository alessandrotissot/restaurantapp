//
//  YRBaseViewController.m
//  YelpReviews
//
//  Created by Alessandro Tissot on 2016-03-29.
//  Copyright © 2016 Alessandro Tissot. All rights reserved.
//

#import "YRBaseViewController.h"

@interface YRBaseViewController ()

@end

@implementation YRBaseViewController

- (void) showError: (YRError *) error {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedMessage preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                          handler:^(UIAlertAction * action) {
                             [alertController dismissViewControllerAnimated:YES completion:nil];
                             
                          }];
    
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void) showSpinner {
    
    if (_spinner == NULL) {
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _spinner.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _spinner.hidesWhenStopped = YES;
    }
    
    _spinner.frame = self.view.bounds;
    _spinner.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_spinner startAnimating];
    [self.view addSubview:_spinner];
    [self.view bringSubviewToFront:_spinner];
}

- (void) hideSpinner {
    [_spinner stopAnimating];
    [_spinner removeFromSuperview];
}

@end
