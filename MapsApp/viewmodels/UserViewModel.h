//
//  UserViewModel.h
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 23/1/24.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>

@interface UserViewModel : NSObject

- (void) setCurrentLocation: (CLLocationCoordinate2D) location;
- (CLLocationCoordinate2D) getCurrentLocation;
- (NSString *) getCurrentLocationFormatted;
- (void) alreadyUpdated;
- (BOOL) isUpdatedPosition;

@end
