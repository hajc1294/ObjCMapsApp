//
//  UserViewModel.m
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 23/1/24.
//

#import "UserViewModel.h"

@interface UserViewModel()

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic) BOOL updatedPosition;

@end

@implementation UserViewModel

- (void) setCurrentLocation: (CLLocationCoordinate2D) coordinate {
    self.coordinate = coordinate;
}

- (CLLocationCoordinate2D) getCurrentLocation {
    return self.coordinate;
}

- (NSString *) getCurrentLocationFormatted {
    return [NSString stringWithFormat:@"%f,%f", self.coordinate.latitude, self.coordinate.longitude];
}

- (void) alreadyUpdated {
    self.updatedPosition = YES;
}

- (BOOL) isUpdatedPosition {
    return self.updatedPosition;
}

@end
