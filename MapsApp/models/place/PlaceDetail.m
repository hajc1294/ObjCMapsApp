//
//  PlaceDetail.m
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 20/1/24.
//

#import "PlaceDetail.h"

@implementation PlaceDetail

+ (NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
        @"formattedAddress": @"formatted_address",
        @"geometry": @"geometry",
        @"name": @"name"
    };
}

+ (NSValueTransformer *) geometryJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass: PlaceGeometry.class];
}

@end
