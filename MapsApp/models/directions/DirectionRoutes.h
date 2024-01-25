//
//  DirectionRoutes.h
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 22/1/24.
//

#import <Mantle/Mantle.h>
#import "DirectionLegs.h"
#import "DirectionPolyline.h"

@interface DirectionRoutes : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSArray<DirectionLegs *> *legs;
@property (nonatomic, copy) DirectionPolyline *overviewPolyline;

@end
