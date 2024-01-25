//
//  PlaceResponse.h
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 20/1/24.
//

#import <Mantle/Mantle.h>
#import "PlaceDetail.h"

@interface PlaceResponse : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) PlaceDetail *result;

@end
