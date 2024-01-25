//
//  DirectionViewModel.h
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 20/1/24.
//

#import <ReactiveObjC/ReactiveObjC.h>
#import <GoogleMaps/GMSPolyline.h>

@interface DirectionViewModel : NSObject

@property (nonatomic, strong, readonly) RACSignal *success;
@property (nonatomic, strong, readonly) RACSignal *error;

- (void) directionRequest: (NSString *) origin destination: (NSString *) destination;
- (GMSPolyline *) getPolyline;
- (NSString *) getDistance;
- (NSString *) getDuration;
- (BOOL) isEmpty;

@end
