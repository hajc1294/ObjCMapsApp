//
//  PlaceGeometry.m
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 20/1/24.
//

#import "PlaceGeometry.h"

@implementation PlaceGeometry

+ (NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
        @"location": @"location"
    };
}

+ (NSValueTransformer *) locationJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass: PlaceLocation.class];
}

@end
