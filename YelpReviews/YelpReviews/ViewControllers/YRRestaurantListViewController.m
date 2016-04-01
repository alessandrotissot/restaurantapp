//
//  YRRestaurantListViewController.m
//  YelpReviews
//
//  Created by Alessandro Tissot on 2016-03-29.
//  Copyright © 2016 Alessandro Tissot. All rights reserved.
//

#import "YRRestaurantListViewController.h"
#import "YRError.h"
#import "YRRestaurantCell.h"
#import "YRRestaurantDetailsViewController.h"
#import "YRRestaurant+ActiveRecord.h"
#import "UIColor+YRColorScheme.h"

@interface YRRestaurantListViewController ()

@end

@implementation YRRestaurantListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sortOrder = 0;
    [self setupViews];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupViews {
    _searchBarHeight = searchBarHeightConstraint.constant;
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:NULL];
    _searchController.searchResultsUpdater = self;
    _searchController.searchBar.delegate = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    self.definesPresentationContext = YES;
    
    _searchController.searchBar.barTintColor = [UIColor searchBarColor];
    _searchController.searchBar.tintColor = [UIColor whiteColor];
    
    [_tblRestaurants setBackgroundView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    _tblRestaurants.tableHeaderView = _searchController.searchBar;
    _tblRestaurants.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.view.backgroundColor = [UIColor tabBarColor];
    _tblRestaurants.backgroundColor = [UIColor backgroundColor];
    _sortBar.backgroundColor = [UIColor titleBarColor];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor tabBarColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor titleTextColor]];
    
    NSDictionary * navBarTitleTextAttributes = @{ NSForegroundColorAttributeName : [UIColor whiteColor],
                                                  NSFontAttributeName : [UIFont fontWithName:@"Zapfino" size:14.0] };
    
    [self.navigationController.navigationBar setTitleTextAttributes:navBarTitleTextAttributes];
    
    _sortControl.tintColor = [UIColor titleTextColor];
}

- (void) loadData {
    
    [self showSpinner];
    
    [YRRestaurant search:@"Ethiopian" sort: _sortOrder
         success:^(NSArray *restaurants) {
             _restaurants = restaurants;
             _filteredRestaurants = restaurants;
             [_tblRestaurants reloadData];
             [self hideSpinner];
         } failure:^(YRError *error) {
             [self hideSpinner];
             [self showError:error];
         }
     ];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetailsSegue"]) {
        YRRestaurantDetailsViewController *vc = [segue destinationViewController];
        
        NSInteger selectedIndex = [[_tblRestaurants indexPathForSelectedRow] row];
        [vc configure:_filteredRestaurants[selectedIndex]];
    }
}

- (IBAction)sortOrderChanged:(id)sender {
    _sortOrder = (int) _sortControl.selectedSegmentIndex;
    [self loadData];
}

// ---------------------------------------------------
// MARK: UITableViewDataSource
// ---------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _filteredRestaurants.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YRRestaurantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RestaurantCell" forIndexPath:indexPath];
    
    [cell configure:_filteredRestaurants[indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

// ---------------------------------------------------
// MARK: UITableViewDelegate
// ---------------------------------------------------

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor backgroundColor];
}

// ---------------------------------------------------
// MARK: UISearchBarDelegate
// ---------------------------------------------------

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    searchBarHeightConstraint.constant = 0.0;
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBarHeightConstraint.constant = _searchBarHeight;
}

// ---------------------------------------------------
// MARK: UISearchResultsUpdating
// ---------------------------------------------------

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *filter = [searchController.searchBar.text lowercaseString];
    
    if (filter.length > 0) {
        _filteredRestaurants = [_restaurants filteredArrayUsingPredicate:
            [NSPredicate predicateWithBlock:^BOOL(id object, NSDictionary *bindings) {
                YRRestaurant *restaurant = object;
                return [[restaurant.name lowercaseString] containsString:filter] || [[restaurant.displayAddress lowercaseString] containsString:filter];
            }]
        ];
    } else {
        _filteredRestaurants = _restaurants;
    }
    
    [_tblRestaurants reloadData];
}

@end
