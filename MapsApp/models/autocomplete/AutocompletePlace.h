//
//  AutocompletePlace.h
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 19/1/24.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "AutocompleteFormat.h"
@class AutocompletePlaceRealm;

@interface AutocompletePlace : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *placeId;
@property (nonatomic, copy) NSString *placeDescription;
@property (nonatomic, strong) AutocompleteFormat *autocompleteFormat;

- (instancetype) initWithRealm: (AutocompletePlaceRealm *) autocompletePlaceRealm;

@end
