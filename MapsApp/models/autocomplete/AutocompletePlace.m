//
//  AutocompletePlace.m
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 19/1/24.
//

#import "AutocompletePlace.h"
#import "AutocompletePlaceRealm.h"

@implementation AutocompletePlace

- (instancetype) initWithRealm: (AutocompletePlaceRealm *) autocompletePlaceRealm {
    self = [super init];
    if (self) {
        AutocompleteFormat *autocompleteFormat = [[AutocompleteFormat alloc] initWithMainText: autocompletePlaceRealm.mainText secondaryTex: autocompletePlaceRealm.secondaryText];
        self.placeId = autocompletePlaceRealm.placeId;
        self.placeDescription = autocompletePlaceRealm.placeDescription;
        self.autocompleteFormat = autocompleteFormat;
    }
    return self;
}

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
