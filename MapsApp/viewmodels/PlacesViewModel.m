//
//  PlacesViewModel.m
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 19/1/24.
//

#import "PlacesViewModel.h"
#import "ServiceClient.h"
#import "AutocompleteResponse.h"
#import "AutocompletePlaceRealm.h"
#import "Realm.h"

@interface PlacesViewModel()

@property (nonatomic, strong) RLMRealm *realm;
@property (nonatomic, strong) ServiceClient *serviceClient;
@property (nonatomic, copy) NSArray<AutocompletePlace *> *predictions;
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
        self.realm = [RLMRealm defaultRealm];
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
            AutocompleteResponse *autocompleteResponse = [MTLJSONAdapter modelOfClass: AutocompleteResponse.class fromJSONDictionary: response error: nil];
            self.predictions = autocompleteResponse.predictions;
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

- (void) saveAutocompletePlace: (AutocompletePlace *) autocompletePlace {
    AutocompletePlaceRealm *autocompletePlaceRealm = [[AutocompletePlaceRealm alloc] initWithMantle: autocompletePlace];
    [self.realm transactionWithBlock: ^{
        [self.realm addObject: autocompletePlaceRealm];
    }];
}

- (void) autocompletePlacesRealm {
    RLMResults<AutocompletePlaceRealm *> *savedAutocompletePlaceRealm = [AutocompletePlaceRealm allObjects];
    NSMutableArray *savedPredictions = [[NSMutableArray alloc] init];
    
    for (AutocompletePlaceRealm *autocompleteRealm in savedAutocompletePlaceRealm) {
        AutocompletePlace *autocompletePlace = [[AutocompletePlace alloc] initWithRealm: autocompleteRealm];
        [savedPredictions addObject: autocompletePlace];
    }
    
    self.predictions = savedPredictions;
    [(RACSubject *) self.autocompleteSuccess sendNext: nil];
}

- (id) elementAt: (NSUInteger) index {
    return [self.predictions objectAtIndex: index];
}

- (PlaceDetail *) getPlaceDetail {
    return self.placeResponse.result;
}

- (NSString *) placeIdFor: (NSUInteger) index {
    AutocompletePlace *autocompletePlace = [self.predictions objectAtIndex: index];
    [self saveAutocompletePlace: autocompletePlace];
    return autocompletePlace.placeId;
}

- (NSArray *) getPredictions {
    return self.predictions;
}

- (NSInteger) dataSize {
    return self.predictions.count;
}

- (BOOL) isEmpty {
    return self.predictions.count == 0;
}

- (void) clear {
    self.predictions = [[NSArray alloc] init];
}

@end
