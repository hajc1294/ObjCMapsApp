//
//  DirectionData.h
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 22/1/24.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface DirectionData : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *text;

@end
