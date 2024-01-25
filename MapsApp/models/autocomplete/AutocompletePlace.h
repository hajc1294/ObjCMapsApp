//
//  AutocompletePlace.h
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 19/1/24.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "AutocompleteFormat.h"

@interface AutocompletePlace : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *placeId;
@property (nonatomic, copy) NSString *placeDescription;
@property (nonatomic, strong) AutocompleteFormat *autocompleteFormat;

@end
