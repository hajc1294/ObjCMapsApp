//
//  PlaceLocation.h
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 20/1/24.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface PlaceLocation : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSNumber *lat;
@property (nonatomic, copy) NSNumber *lng;

@end
