//
//  DirectionPolyline.m
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 22/1/24.
//

#import "DirectionPolyline.h"

@implementation DirectionPolyline

+ (NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
        @"points": @"points"
    };
}

@end
