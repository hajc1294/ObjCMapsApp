//
//  DirectionResponse.h
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 22/1/24.
//

#import <Mantle/Mantle.h>
#import "DirectionRoutes.h"

@interface DirectionResponse : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSArray<DirectionRoutes *> *routes;

@end

