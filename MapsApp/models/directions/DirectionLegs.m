//
//  DirectionLegs.m
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 22/1/24.
//

#import "DirectionLegs.h"

@implementation DirectionLegs

+ (NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
        @"distance": @"distance",
        @"duration": @"duration"
    };
}

+ (NSValueTransformer *) distanceJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass: DirectionData.class];
}


+ (NSValueTransformer *) durationJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass: DirectionData.class];
}

@end
