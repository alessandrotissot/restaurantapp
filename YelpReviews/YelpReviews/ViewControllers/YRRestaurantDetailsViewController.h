//
//  YRRestaurantDetailsViewController.h
//  YelpReviews
//
//  Created by Alessandro Tissot on 2016-03-29.
//  Copyright © 2016 Alessandro Tissot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "YRBaseViewController.h"
#import "YRRestaurant.h"

@interface YRRestaurantDetailsViewController : YRBaseViewController <UICollectionViewDataSource, UICollectionViewDelegate> {
    
    __weak IBOutlet MKMapView *_mapView;
    __weak IBOutlet UILabel *_nameLabel;
    __weak IBOutlet UILabel *_addressLabel;
    __weak IBOutlet UILabel *_ratingLabel;
    __weak IBOutlet UILabel *_phoneLabel;
    __weak IBOutlet UICollectionView *_colPhotos;
    __weak IBOutlet UIView *_restaurantTitleBar;
    __weak IBOutlet UIView *_mapTitleBar;
    __weak IBOutlet UIView *_photosTitleBar;
    
    __weak IBOutlet UIView *_headerView;
    
    @private
    YRRestaurant *_restaurant;
    NSArray *_imageUrls;
    UIImage *_selectedImage;
}

- (void) configure: (YRRestaurant *) restaurant;

@end
