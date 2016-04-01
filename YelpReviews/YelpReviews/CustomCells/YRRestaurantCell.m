//
//  YRRestaurantCell.m
//  YelpReviews
//
//  Created by Alessandro Tissot on 2016-03-29.
//  Copyright © 2016 Alessandro Tissot. All rights reserved.
//

#import "YRRestaurantCell.h"
#import "YRYelpClient.h"
#import "YRImageCache.h"
#import "UIColor+YRColorScheme.h"

@implementation YRRestaurantCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(imageLoaded:)
                                                 name:@"CellImageLoaded"
                                               object:nil];
    
    self.contentView.backgroundColor = [UIColor backgroundColor];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)prepareForReuse {
    _imgView.image = nil;
}

- (void) configure: (YRRestaurant *) restaurant {
    
    self.separatorInset = UIEdgeInsetsZero;
    self.layoutMargins = UIEdgeInsetsZero;
    
    _restaurant = restaurant;
    
    _nameLabel.text = restaurant.name;
    _addressLabel.text = restaurant.displayAddress;
    _phoneLabel.text = restaurant.displayPhone;
    _reviewLabel.text = restaurant.snippetText;
    _ratingLabel.text = [NSString stringWithFormat:@"Average rating: %0.1f", restaurant.rating.doubleValue];
    
    _spinner.hidesWhenStopped = YES;
    [_spinner startAnimating];
    
    UIImage *image = [[YRImageCache sharedInstance] imageFromUrl:restaurant.imageUrl];
    
    if (image != NULL) {
        [_spinner stopAnimating];
        _imgView.image = image;
    } else {
        [[YRYelpClient sharedInstance] downloadImage:restaurant.imageUrl
            success:^(UIImage *image) {
                [[YRImageCache sharedInstance] cacheImage:image imageUrl:restaurant.imageUrl];
                
                // Notify all cells that the image was loaded. As user can scroll the cells and
                // the cells can be reused, the cells that originated the network call may be
                // now used to display a different restaurant. Also the restaurant displayed in
                // this cell may now being displayed in another cell.
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CellImageLoaded" object:self];
            }
            failure:^(YRError *error) {
            }
         ];
    }
}

- (void) imageLoaded:(NSNotification *) notification {
    
    if ([[notification name] isEqualToString:@"CellImageLoaded"]) {
        UIImage *image = [[YRImageCache sharedInstance] imageFromUrl:_restaurant.imageUrl];
        
        if (image != NULL) {
            [_spinner stopAnimating];
            _imgView.image = image;
        }
    }
}
@end
