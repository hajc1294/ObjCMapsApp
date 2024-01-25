//
//  PlacesViewModel.m
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 19/1/24.
//

#import "PlacesViewModel.h"
#import "ServiceClient.h"
#import "AutocompleteResponse.h"

@interface PlacesViewModel()

@property (nonatomic, strong) ServiceClient *serviceClient;
@property (nonatomic, copy) AutocompleteResponse *autocompleteResponse;
@property (nonatomic, copy) PlaceResponse *placeResponse;
@property (nonatomic, strong) RACSignal *autocompleteSuccess;
@property (nonatomic, strong) RACSignal *detailSuccess;
@property (nonatomic, strong) RACSignal *error;

@end

@implementation PlacesViewModel

- (ServiceClient *) serviceClient {
    if (_serviceClient == nil) {
        _serviceClient = [[ServiceClient alloc] init];
    }
    return _serviceClient;
}

- (instancetype) init {
    self = [super init];
    if (self) {
        self.autocompleteSuccess = [[RACSubject subject] setNameWithFormat: @"%@ -autocompleteSuccess", self];
        self.detailSuccess = [[RACSubject subject] setNameWithFormat: @"%@ -detailSuccess", self];
        self.error = [[RACSubject subject] setNameWithFormat: @"%@ -error", self];
    }
    return self;
}

- (void) autocompletePlacesRequest: (NSString *) input {
    @weakify(self);
    [self.serviceClient getPlaceAutocomplete: input completion: ^(NSDictionary *response, NSError *error) {
        @strongify(self);
        if (error == nil) {
            self.autocompleteResponse = [MTLJSONAdapter modelOfClass: AutocompleteResponse.class fromJSONDictionary: response error: nil];
            [(RACSubject *) self.autocompleteSuccess sendNext: nil];
        } else {
            [(RACSubject *) self.error sendNext: error];
        }
    }];
}

- (void) placeDetailRequest: (NSString *) placeId {
    @weakify(self);
    [self.serviceClient getPlaceDetail: placeId completion: ^(NSDictionary *response, NSError *error) {
        @strongify(self);
        if (error == nil) {
            self.placeResponse = [MTLJSONAdapter modelOfClass: PlaceResponse.class fromJSONDictionary: response error: nil];
            [(RACSubject *) self.detailSuccess sendNext: nil];
        } else {
            [(RACSubject *) self.error sendNext: error];
        }
    }];
}

- (id) elementAt: (NSUInteger) index {
    return [self.autocompleteResponse.predictions objectAtIndex: index];
}

- (PlaceDetail *) getPlaceDetail {
    return self.placeResponse.result;
}

- (NSString *) placeIdFor: (NSUInteger) index {
    return [self.autocompleteResponse.predictions objectAtIndex: index].placeId;
}

- (NSArray *) getPredictions {
    return self.autocompleteResponse.predictions;
}

- (NSInteger) dataSize {
    return self.autocompleteResponse.predictions.count;
}

- (BOOL) isEmpty {
    return self.autocompleteResponse.predictions.count == 0;
}

- (void) clear {
    self.autocompleteResponse = nil;
}

@end
