//
//  AutocompleteFormat.m
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 19/1/24.
//

#import "AutocompleteFormat.h"

@implementation AutocompleteFormat

- (instancetype) initWithMainText: (NSString *) mainText secondaryTex: (NSString *) secondaryText {
    self = [super init];
    if (self) {
        self.mainText = mainText;
        self.secondaryText = secondaryText;
    }
    return self;
}

+ (NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
        @"mainText": @"main_text",
        @"secondaryText": @"secondary_text"
    };
}

@end
