//
//  DirectionViewModel.m
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 20/1/24.
//

#import <GoogleMaps/GMSPath.h>
#import "DirectionViewModel.h"
#import "ServiceClient.h"
#import "DirectionResponse.h"

@interface DirectionViewModel()

@property (nonatomic, strong) ServiceClient *serviceClient;
@property (nonatomic, copy) DirectionResponse *directionResponse;
@property (nonatomic, copy) DirectionRoutes *directionRoutes;
@property (nonatomic, strong) RACSignal *success;
@property (nonatomic, strong) RACSignal *error;

@end

@implementation DirectionViewModel

- (ServiceClient *) serviceClient {
    if (_serviceClient == nil) {
        _serviceClient = [[ServiceClient alloc] init];
    }
    return _serviceClient;
}


- (instancetype) init {
    self = [super init];
    if (self) {
        self.success = [[RACSubject subject] setNameWithFormat: @"%@ -success", self];
        self.error = [[RACSubject subject] setNameWithFormat: @"%@ -error", self];
    }
    return self;
}

- (void) directionRequest: (NSString *) origin destination: (NSString *) destination {
    @weakify(self);
    [self.serviceClient getDirection: origin destination: destination completion: ^(NSDictionary *response, NSError *error) {
        @strongify(self);
        if (error == nil) {
            self.directionResponse = [MTLJSONAdapter modelOfClass: DirectionResponse.class fromJSONDictionary: response error: nil];
            if (![self isEmpty]) {
                self.directionRoutes = self.directionResponse.routes[0];
                [(RACSubject *) self.success sendNext: nil];
            } else {
                [(RACSubject *) self.error sendNext: error];
            }
        } else {
            [(RACSubject *) self.error sendNext: error];
        }
    }];
}

- (GMSPolyline *) getPolyline {
    GMSPolyline *polyline = [GMSPolyline polylineWithPath: [GMSPath pathFromEncodedPath: self.directionRoutes.overviewPolyline.points]];
    polyline.strokeColor = [UIColor whiteColor];
    polyline.strokeWidth = 4.f;
    return polyline;
}

- (NSString *) getDistance {
    return self.directionRoutes.legs[0].distance.text;
}

- (NSString *) getDuration {
    return self.directionRoutes.legs[0].duration.text;
}

- (BOOL) isEmpty {
    return self.directionResponse.routes.count == 0;
}


@end
