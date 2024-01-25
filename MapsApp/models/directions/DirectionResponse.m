//
//  DirectionResponse.m
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 22/1/24.
//

#import "DirectionResponse.h"

@implementation DirectionResponse

+ (NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
        @"routes": @"routes"
    };
}

+ (NSValueTransformer *) routesJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass: DirectionRoutes.class];
}

@end

