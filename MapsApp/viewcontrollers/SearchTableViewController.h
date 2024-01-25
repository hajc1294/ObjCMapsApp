//
//  SearchTableViewController.h
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 19/1/24.
//

#import <UIKit/UIKit.h>
#import "PlaceDetail.h"

@protocol SearchProtocol

- (void) searchCallback: (PlaceDetail *) placeDetail;

@end

@interface SearchTableViewController : UITableViewController

@property (nonatomic, weak) id<SearchProtocol> searchProtocol;


@end
