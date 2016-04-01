//
//  YelpClient.m
//  YelpReviews
//
//  Created by Alessandro Tissot on 2016-03-29.
//  Copyright © 2016 Alessandro Tissot. All rights reserved.
//

#import "YRYelpClient.h"

@interface YRYelpClient ()
- (NSArray *) extractPhotoUrlsFromHtml: (NSString *) html;
@end

@implementation YRYelpClient

static YRYelpClient *instance = nil;

NSString *consumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString *consumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString *accessToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString *accessSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

+ (YRYelpClient *) sharedInstance {
    if (instance == nil) {
        instance = [[YRYelpClient alloc] init];
    }
    
    return instance;
}

- (id)init {
    NSURL *baseUrl = [[NSURL alloc] initWithString:@"https://api.yelp.com/v2/"];
    
    self = [super initWithBaseURL:baseUrl consumerKey:consumerKey consumerSecret:consumerSecret];
    
    BDBOAuth1Credential *token = [[BDBOAuth1Credential alloc] initWithToken:accessToken secret:accessSecret expiration:nil];
    
    [self.requestSerializer saveAccessToken:token];
    
    return self;
}

- (void)search: (NSString *) query
      maxRows: (int) maxRows
         sort: (int) sort
      success: (void (^)(NSDictionary *dict)) success
      failure: (void (^)(YRError *error)) failure {
    
    NSDictionary *parameters = @{@"term":query, @"limit":[[NSNumber alloc] initWithInt:maxRows], @"ll":@"43.761539,-79.411079", @"sort": [[NSNumber alloc] initWithInt:sort]};
    
    [self GET:@"search" parameters:parameters
     
        success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
              if([responseObject isKindOfClass:[NSDictionary class]]) {
                  success(responseObject);
              } else {
                  YRError *err = [[YRError alloc] initWithLocalizedMessage:@"The application has encountered an unknown error."];
                  failure(err);
              }
        }
     
        failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            YRError *err = [[YRError alloc] initWithLocalizedMessage:error.localizedDescription];
            failure(err);
        }
     ];
}

- (void)loadRestaurant: (NSString *) restaurantId
               success: (void (^)(NSDictionary *dict)) success
               failure: (void (^)(YRError *error)) failure {
    
    NSDictionary *parameters = @{@"cc":@"CA", @"lang":@"en"};
    
    NSString *path = [NSString stringWithFormat:@"business/%@",restaurantId];
    [self GET:path parameters:parameters
     
      success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
          if([responseObject isKindOfClass:[NSDictionary class]]) {
              success(responseObject);
          } else {
              YRError *err = [[YRError alloc] initWithLocalizedMessage:@"The application has encountered an unknown error."];
              failure(err);
          }
      }
     
      failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
          YRError *err = [[YRError alloc] initWithLocalizedMessage:error.localizedDescription];
          failure(err);
      }
     ];
}

- (void) downloadImage: (NSString *) imageUrl
               success: (void (^)(UIImage *image)) success
               failure: (void (^)(YRError *error)) failure {
    
    NSURL *url = [[NSURL alloc] initWithString:imageUrl];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    
    [requestOperation
        setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            if([responseObject isKindOfClass:[UIImage class]]) {
                success(responseObject);
            } else {
                YRError *err = [[YRError alloc] initWithLocalizedMessage:@"The application has encountered an unknown error."];
                failure(err);
            }
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            YRError *err = [[YRError alloc] initWithLocalizedMessage:error.localizedDescription];
            failure(err);
        }
    ];
    
    [requestOperation start];
}

- (void)loadUserImages: (NSString *) restaurantId
               success: (void (^)(NSArray *imageUrls)) success
               failure: (void (^)(YRError *error)) failure {
    
    // The Yelp API 2.0 does not provide a service to retrieve the user images. Hence this
    // function will parse the site HTML to find the images.
    NSString *path = [NSString stringWithFormat:@"https://www.yelp.com/biz_photos/%@", restaurantId];
     
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

    [manager GET:path parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSArray *imageUrls = [self extractPhotoUrlsFromHtml: operation.responseString ];
             success(imageUrls);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             YRError *err = [[YRError alloc] initWithLocalizedMessage:error.localizedDescription];
             failure(err);
         }
     ];
}

- (NSArray *) extractPhotoUrlsFromHtml: (NSString *) html {
    
    NSMutableArray *photoUrls = [[NSMutableArray alloc] init];
    
    int photosToExtract = 10;
    
    NSString *userPhotoToken = @"src_high_res\": \"";
    NSUInteger htmlLength = html.length;
    
    NSRange searchRange = NSMakeRange(0, htmlLength);
    NSRange startRange;
    NSRange endRange;
    
    do {
        startRange = [html rangeOfString:userPhotoToken options:0 range:searchRange];
        
        if (startRange.location != NSNotFound) {
            searchRange.location = startRange.location + startRange.length;
            searchRange.length = htmlLength - searchRange.location;
            
            endRange = [html rangeOfString:@"\"" options:0 range:searchRange];
            
            if (endRange.location != NSNotFound) {
                NSRange pathRange = NSMakeRange(searchRange.location, endRange.location - searchRange.location);
                NSString *photoUrl = [NSString stringWithFormat:@"http:%@", [html substringWithRange:pathRange]];
                
                [photoUrls addObject:photoUrl];
                photosToExtract--;
            }
        }
        
    } while (photosToExtract > 0 && startRange.location != NSNotFound && searchRange.location < htmlLength);
        
    return [photoUrls copy];
}

@end
