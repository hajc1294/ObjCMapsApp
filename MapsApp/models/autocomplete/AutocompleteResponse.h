//
//  AutocompleteResponse.h
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 19/1/24.
//

#import <Mantle/Mantle.h>
#import "AutocompletePlace.h"

@interface AutocompleteResponse : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSArray<AutocompletePlace *> *predictions;

@end
