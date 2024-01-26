//
//  AutocompleteFormat.h
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 19/1/24.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface AutocompleteFormat : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *mainText;
@property (nonatomic, copy) NSString *secondaryText;

- (instancetype) initWithMainText: (NSString *) mainText secondaryTex: (NSString *) secondaryText;

@end
