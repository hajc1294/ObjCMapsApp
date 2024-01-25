//
//  DirectionLegs.h
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 22/1/24.
//

#import <Mantle/Mantle.h>
#import "DirectionData.h"

@interface DirectionLegs : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) DirectionData *distance;
@property (nonatomic, copy) DirectionData *duration;

@end

