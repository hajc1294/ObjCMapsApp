//
//  PlaceDetail.h
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 20/1/24.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "PlaceGeometry.h"

@interface PlaceDetail : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *formattedAddress;
@property (nonatomic, copy) PlaceGeometry *geometry;
@property (nonatomic, copy) NSString *name;

@end
