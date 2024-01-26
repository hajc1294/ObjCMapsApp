//
//  AutocompletePlaceViewCell.m
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 19/1/24.
//

#import "AutocompletePlaceViewCell.h"

@interface AutocompletePlaceViewCell()

@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet UILabel *placeNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *placeDescriptionLabel;
@property (nonatomic, weak) IBOutlet UIView *rightIconView;
@property (nonatomic, weak) IBOutlet UILabel *dividerLabel;

@end

@implementation AutocompletePlaceViewCell

- (void) awakeFromNib {
    [super awakeFromNib];
}

- (void) setUp: (AutocompletePlace *) autocompletePlace isFirst: (BOOL) isFirst isLast: (BOOL) isLast {
    self.placeNameLabel.text = autocompletePlace.autocompleteFormat.mainText;
    
    if (autocompletePlace.autocompleteFormat.secondaryText == nil) {
        self.placeDescriptionLabel.text = autocompletePlace.autocompleteFormat.mainText;
    } else {
        self.placeDescriptionLabel.text = autocompletePlace.autocompleteFormat.secondaryText;
    }
    
    self.containerView.layer.cornerRadius = (isFirst || isLast) ? 23.0 : 0;
    [self.dividerLabel setHidden: isLast];
    if (isFirst && isLast) {
        self.containerView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner;
    } else if (isFirst) {
        self.containerView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    } else if (isLast) {
        self.containerView.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner;
    }
}

@end
