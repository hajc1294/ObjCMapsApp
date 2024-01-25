//
//  ServiceClient.m
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 19/1/24.
//

#import "ServiceClient.h"
#import "Constants.h"

@implementation ServiceClient

- (instancetype) init {    
    return [super initWithBaseURL: [NSURL URLWithString: BASE_URL]];
}

#define GET_PLACE_AUTOCOMPLETE @"place/autocomplete/json?input=%@&key=%@"
- (void) getPlaceAutocomplete: (NSString *) input completion: (void(^) (NSDictionary *response, NSError *error)) completion {
    NSString *request = [NSString stringWithFormat: GET_PLACE_AUTOCOMPLETE, input, API_KEY];
    [self GET: request parameters: nil headers: nil progress: ^(NSProgress *downloadProgress) {
        NSLog(@"Loading ...");
    } success: ^(NSURLSessionDataTask *task, id response) {
        completion(response, nil);
    } failure: ^(NSURLSessionDataTask *task, NSError *error) {
        completion(nil, error);
    }];
}

#define GET_PLACE_DETAIL @"place/details/json?place_id=%@&key=%@"
- (void) getPlaceDetail: (NSString *) placeId completion: (void(^) (NSDictionary *response, NSError *error)) completion {
    NSString *request = [NSString stringWithFormat: GET_PLACE_DETAIL, placeId, API_KEY];
    [self GET: request parameters: nil headers: nil progress: ^(NSProgress *downloadProgress) {
        NSLog(@"Loading ...");
    } success: ^(NSURLSessionDataTask *task, id response) {
        completion(response, nil);
    } failure: ^(NSURLSessionDataTask *task, NSError *error) {
        completion(nil, error);
    }];
}

#define GET_DIRECTIONS @"directions/json?origin=%@&destination=%@&key=%@&sensor=false"
- (void) getDirection: (NSString *) origin destination: (NSString *) destination completion: (void(^) (NSDictionary *response, NSError *error)) completion {
    NSString *request = [NSString stringWithFormat: GET_DIRECTIONS, origin, destination, API_KEY];
    [self GET: request parameters: nil headers: nil progress: ^(NSProgress *downloadProgress) {
        NSLog(@"Loading ...");
    } success: ^(NSURLSessionDataTask *task, id response) {
        completion(response, nil);
    } failure: ^(NSURLSessionDataTask *task, NSError *error) {
        completion(nil, error);
    }];
}

@end
