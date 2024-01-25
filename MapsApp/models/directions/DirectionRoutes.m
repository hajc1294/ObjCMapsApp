//
//  DirectionRoutes.m
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 22/1/24.
//

#import "DirectionRoutes.h"

@implementation DirectionRoutes

+ (NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
        @"legs": @"legs",
        @"overviewPolyline": @"overview_polyline"
    };
}

+ (NSValueTransformer *) legsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass: DirectionLegs.class];
}

+ (NSValueTransformer *) overviewPolylineJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass: DirectionPolyline.class];
}

@end
