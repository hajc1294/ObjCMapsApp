//
//  AutocompletePlaceViewCell.h
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 19/1/24.
//

#import <UIKit/UIKit.h>
#import "AutocompletePlace.h"

@interface AutocompletePlaceViewCell : UITableViewCell

- (void) setUp: (AutocompletePlace *) autocompletePlace isFirst: (BOOL) isFirst isLast: (BOOL) isLast;

@end
