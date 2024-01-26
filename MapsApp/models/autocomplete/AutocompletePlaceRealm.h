//
//  AutocompletePlaceRealm.h
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 25/1/24.
//

#import <Foundation/Foundation.h>
#import "Realm.h"
@class AutocompletePlace;

@interface AutocompletePlaceRealm : RLMObject

@property NSString *placeId;
@property NSString *placeDescription;
@property NSString *mainText;
@property NSString *secondaryText;

- (instancetype) initWithMantle: (AutocompletePlace *) autocompletePlace;

@end
