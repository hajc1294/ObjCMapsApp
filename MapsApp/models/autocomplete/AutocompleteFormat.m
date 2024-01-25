//
//  AutocompleteFormat.m
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 19/1/24.
//

#import "AutocompleteFormat.h"

@implementation AutocompleteFormat

+ (NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
        @"mainText": @"main_text",
        @"secondaryText": @"secondary_text"
    };
}

@end
