//
//  AutocompleteResponse.m
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 19/1/24.
//

#import "AutocompleteResponse.h"

@implementation AutocompleteResponse

+ (NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
        @"predictions": @"predictions"
    };
}

+ (NSValueTransformer *) predictionsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass: AutocompletePlace.class];
}

@end
