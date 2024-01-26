//
//  AutocompletePlaceRealm.m
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 25/1/24.
//

#import "AutocompletePlaceRealm.h"
#import "AutocompletePlace.h"

@implementation AutocompletePlaceRealm

- (instancetype) initWithMantle: (AutocompletePlace *) autocompletePlace {
    self = [super init];
    if (self) {
        self.placeId = autocompletePlace.placeId;
        self.placeDescription = autocompletePlace.placeDescription;
        self.mainText = autocompletePlace.autocompleteFormat.mainText;
        self.secondaryText = autocompletePlace.autocompleteFormat.secondaryText;
    }
    return self;
}

@end
