//
//  AutocompleteHeaderCell.h
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 26/1/24.
//

#import <UIKit/UIKit.h>

@protocol ClearProtocol

- (void) clearCallback;

@end

@interface AutocompleteHeaderCell : UITableViewCell

@property (nonatomic, weak) id<ClearProtocol> clearProtocol;

- (void) setUp: (id<ClearProtocol>) clearProtocol;

@end
