//
//  YRRestaurantDetailsViewController.m
//  YelpReviews
//
//  Created by Alessandro Tissot on 2016-03-29.
//  Copyright © 2016 Alessandro Tissot. All rights reserved.
//

#import "YRRestaurantDetailsViewController.h"
#import "YRRestaurant.h"
#import "YRError.h"
#import "YRAnnotation.h"
#import "YRRestaurant+ActiveRecord.h"
#import "YRYelpClient.h"
#import "YRPhotoCell.h"
#import "UIColor+YRColorScheme.h"
#import "YRImageView.h"

@interface YRRestaurantDetailsViewController ()

@end

@implementation YRRestaurantDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    [self setupMap];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) configure: (YRRestaurant *) restaurant {
    _restaurant = restaurant;
}

- (void) setupViews {
    
    self.view.backgroundColor = [UIColor backgroundColor];
    _headerView.backgroundColor = [UIColor backgroundColor];
    
    _mapTitleBar.backgroundColor = [UIColor titleBarColor];
    _restaurantTitleBar.backgroundColor = [UIColor titleBarColor];
    _photosTitleBar.backgroundColor = [UIColor titleBarColor];
    
}

- (void) setupMap {
    [_mapView setZoomEnabled:YES];
    [_mapView setScrollEnabled:YES];
    _mapView.showsUserLocation = NO;
    
    CLLocationCoordinate2D coordinate = {.latitude = _restaurant.latitude.doubleValue, .longitude = _restaurant.longitude.doubleValue};
    MKCoordinateSpan span = {.latitudeDelta = 0.05, .longitudeDelta = 0.05};
    MKCoordinateRegion region = {coordinate, span};
    
    [_mapView setRegion:region];
    [_mapView setCenterCoordinate:coordinate animated:YES];
    
    YRAnnotation *annotation = [[YRAnnotation alloc] init];
    annotation.coordinate = coordinate;
    annotation.title = _restaurant.name;
    [_mapView addAnnotation:annotation];
}

- (void) loadData {
    
    _imageUrls = [[NSArray alloc] init];
    
    _nameLabel.text = _restaurant.name;
    _addressLabel.text = _restaurant.displayAddress;
    _phoneLabel.text = _restaurant.displayPhone;
    _ratingLabel.text = [NSString stringWithFormat:@"Average rating: %0.1f", _restaurant.rating.doubleValue];
    
    YRYelpClient *client = [YRYelpClient sharedInstance];
    
    [client loadUserImages:_restaurant.restaurantId
           success:^(NSArray *imageUrls) {
               _imageUrls = imageUrls;
               [_colPhotos reloadData];
           } failure:^(YRError *error) {
               
           }
     ];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showImageSegue"]) {
        YRImageView *vc = [segue destinationViewController];
        [vc configure:_selectedImage];
    }
}

// ---------------------------------------------------
// MARK: UICollectionViewDataSource
// ---------------------------------------------------

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageUrls.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YRPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    
    [cell configure:_imageUrls[indexPath.row]];
    
    return cell;
}

// ---------------------------------------------------
// MARK: UICollectionViewDelegate
// ---------------------------------------------------

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YRPhotoCell *cell = (YRPhotoCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    _selectedImage = [cell getLoadedImage];
    
    [self performSegueWithIdentifier:@"showImageSegue" sender:self];
}

@end
