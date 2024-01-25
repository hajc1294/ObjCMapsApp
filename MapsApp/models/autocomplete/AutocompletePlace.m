//
//  AutocompletePlace.m
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 19/1/24.
//

#import "AutocompletePlace.h"

@implementation AutocompletePlace

+ (NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
        @"placeId": @"place_id",
        @"placeDescription": @"description",
        @"autocompleteFormat": @"structured_formatting"
    };
}

+ (NSValueTransformer *) autocompleteFormatJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass: AutocompleteFormat.class];
}

@end
