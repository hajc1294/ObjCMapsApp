//
//  PlacesViewModel.h
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 19/1/24.
//

#import <ReactiveObjC/ReactiveObjC.h>
#import "PlaceResponse.h"

@interface PlacesViewModel : NSObject

@property (nonatomic, strong, readonly) RACSignal *autocompleteSuccess;
@property (nonatomic, strong, readonly) RACSignal *detailSuccess;
@property (nonatomic, strong, readonly) RACSignal *error;

- (void) autocompletePlacesRequest: (NSString *) input;
- (void) autocompletePlacesRealm;
- (void) placeDetailRequest: (NSString *) placeId;
- (id) elementAt: (NSUInteger) index;
- (PlaceDetail *) getPlaceDetail;
- (NSString *) placeIdFor: (NSUInteger) index;
- (NSArray *) getPredictions;
- (NSInteger) dataSize;
- (BOOL) isEmpty;
- (void) clear;

@end
