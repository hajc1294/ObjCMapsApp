//
//  PlaceLocation.m
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 20/1/24.
//

#import "PlaceLocation.h"

@implementation PlaceLocation

+ (NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
        @"lat": @"lat",
        @"lng": @"lng"
    };
}

@end
