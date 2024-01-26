//
//  SearchTableViewController.m
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 19/1/24.
//

#import "SearchTableViewController.h"
#import "AutocompletePlaceViewCell.h"
#import "PlacesViewModel.h"
#import "MBProgressHUD.h"

@interface SearchTableViewController()

@property (nonatomic, weak) IBOutlet UITextField *searchTextField;
@property (nonatomic, strong) MBProgressHUD *loadingHud;
@property (nonatomic, strong) PlacesViewModel *placesViewModel;

@end

@implementation SearchTableViewController

- (PlacesViewModel *) placesViewModel {
    if (_placesViewModel == nil) {
        _placesViewModel = [[PlacesViewModel alloc] init];
    }
    return _placesViewModel;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self subscribeSignals];
    [self initUI];
    [self.placesViewModel autocompletePlacesRealm];
}

- (void) viewWillDisappear: (BOOL) animated {
    [super viewWillDisappear: animated];
    
    if (self.loadingHud != nil) {
        [self.loadingHud removeFromSuperview];
        self.loadingHud = nil;
    }
}

- (void) subscribeSignals {
    @weakify(self);
    [[self.searchTextField.rac_textSignal throttle: 1] subscribeNext: ^(NSString *text) {
        @strongify(self);
        if (![text isEqual: @""]) {
            [self.loadingHud showAnimated: YES];
            [self.placesViewModel autocompletePlacesRequest: text];
        }
    }];
    [[self.placesViewModel.autocompleteSuccess subscribeOn: [RACScheduler mainThreadScheduler]] subscribeNext: ^(id x) {
        @strongify(self);
        [self.tableView reloadData];
        [self.loadingHud hideAnimated: YES];
    }];
    [[self.placesViewModel.detailSuccess subscribeOn: [RACScheduler mainThreadScheduler]] subscribeNext: ^(id x) {
        @strongify(self);
        [self.loadingHud hideAnimated: YES];
        [self dismissViewControllerAnimated: YES completion:^{
            [self.searchProtocol searchCallback: [self.placesViewModel getPlaceDetail]];
        }];
    }];
    [[self.placesViewModel.error subscribeOn: [RACScheduler mainThreadScheduler]] subscribeNext:^(NSError *error) {
        @strongify(self);
        [self.loadingHud hideAnimated: YES];
        [self showError: error];
    }];
}

- (void) initUI {
    self.searchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Search place ..." attributes: @{NSForegroundColorAttributeName: UIColor.whiteColor}];
    self.loadingHud = [[MBProgressHUD alloc] initWithFrame: self.view.window.bounds];
    [self.view addSubview: self.loadingHud];
}

- (void) showError: (NSError *) error {
    NSLog(@"Error: %@", error);
    MBProgressHUD *errorHud = [MBProgressHUD showHUDAddedTo: self.view animated: YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        errorHud.mode = MBProgressHUDModeText;
        errorHud.label.text = @"Error retrieving requested information";
        errorHud.margin = 10.f;
        errorHud.removeFromSuperViewOnHide = YES;
        [errorHud hideAnimated: YES afterDelay: 2];
    });
}

- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath {
    if ([self.placesViewModel isEmpty]) {
        return [tableView dequeueReusableCellWithIdentifier: @"EmptyViewCell" forIndexPath: indexPath];
    } else {
        AutocompletePlaceViewCell *autocompletePlaceViewCell = [tableView dequeueReusableCellWithIdentifier: @"AutocompletePlaceViewCell" forIndexPath: indexPath];
        [autocompletePlaceViewCell setUp: [self.placesViewModel elementAt: indexPath.row] isFirst: indexPath.row == 0 isLast: indexPath.row == [self.placesViewModel dataSize] - 1];
        return autocompletePlaceViewCell;
    }
}

- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section {
    return [self.placesViewModel isEmpty] ? 1 : [self.placesViewModel dataSize];
}

- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath {
    return [self.placesViewModel isEmpty] ? 400 : 70;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    self.loadingHud = [MBProgressHUD showHUDAddedTo: self.view animated: YES];
    NSString *placeId = [self.placesViewModel placeIdFor: indexPath.row];
    [self.placesViewModel placeDetailRequest: placeId];
}

- (IBAction) dismissAction: (id) sender {
    [self dismissViewControllerAnimated: YES completion: nil];
}

- (IBAction) clearAction: (id) sender {
    self.searchTextField.text = @"";
    [self.placesViewModel clear];
    [self.tableView reloadData];
}

@end
