//
//  AutocompleteHeaderCell.m
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 26/1/24.
//

#import "AutocompleteHeaderCell.h"

@implementation AutocompleteHeaderCell

- (void) setUp: (id<ClearProtocol>) clearProtocol {
    self.clearProtocol = clearProtocol;
}

- (IBAction) clearAction: (id) sender {
    [self.clearProtocol  clearCallback];
}

@end
