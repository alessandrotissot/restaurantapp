//
//  YRRestaurantListViewController.h
//  YelpReviews
//
//  Created by Alessandro Tissot on 2016-03-29.
//  Copyright © 2016 Alessandro Tissot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRBaseViewController.h"
#import "YRRestaurant.h"

@interface YRRestaurantListViewController : YRBaseViewController <UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate> {
    
    __weak IBOutlet UISegmentedControl *_sortControl;
    __weak IBOutlet UITableView *_tblRestaurants;
    __weak IBOutlet NSLayoutConstraint *searchBarHeightConstraint;
    __weak IBOutlet UIView *_sortBar;
    
    @private
    NSArray *_restaurants;
    NSArray *_filteredRestaurants;
    UISearchController *_searchController;
    CGFloat _searchBarHeight;
    int _sortOrder;
}

@end
