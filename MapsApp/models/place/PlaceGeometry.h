//
//  PlaceGeometry.h
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 20/1/24.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "PlaceLocation.h"

@interface PlaceGeometry : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) PlaceLocation *location;

@end
