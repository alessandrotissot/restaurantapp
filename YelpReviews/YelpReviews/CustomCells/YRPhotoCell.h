//
//  YRPhotoCell.h
//  YelpReviews
//
//  Created by Alessandro Tissot on 2016-03-31.
//  Copyright © 2016 Alessandro Tissot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YRPhotoCell : UICollectionViewCell {
    
    __weak IBOutlet UIImageView *_imageView;
    
    @private
    NSString *_imageUrl;
}

- (void) configure: (NSString *) imageUrl;
- (UIImage *) getLoadedImage;

@end
