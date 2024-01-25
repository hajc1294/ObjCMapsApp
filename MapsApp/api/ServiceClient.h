//
//  ServiceClient.h
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 19/1/24.
//

#import <AFNetworking/AFNetworking.h>

@interface ServiceClient : AFHTTPSessionManager

- (void) getPlaceAutocomplete: (NSString *) input completion: (void(^) (NSDictionary *response, NSError *error)) completion;
- (void) getPlaceDetail: (NSString *) placeId completion: (void(^) (NSDictionary *response, NSError *error)) completion;
- (void) getDirection: (NSString *) origin destination: (NSString *) destination completion: (void(^) (NSDictionary *response, NSError *error)) completion;

@end
