//
//  PlaceResponse.m
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 20/1/24.
//

#import "PlaceResponse.h"

@implementation PlaceResponse

+ (NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
        @"result": @"result"
    };
}

+ (NSValueTransformer *) resultJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass: PlaceDetail.class];
}

@end
