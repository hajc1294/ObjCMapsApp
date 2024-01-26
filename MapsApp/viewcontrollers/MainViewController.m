//
//  ViewController.m
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 19/1/24.
//

#import <CoreLocation/CoreLocation.h>
#import "MainViewController.h"
#import "SearchTableViewController.h"
#import "DirectionViewModel.h"
#import "UserViewModel.h"
#import "MBProgressHUD.h"
@import GoogleMaps;

@interface MainViewController() <GMSMapViewDelegate, SearchProtocol, CLLocationManagerDelegate>

@property (nonatomic, weak) IBOutlet UIView *mapViewContainer;
@property (weak, nonatomic) IBOutlet UILabel *placeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIStackView *routeDataStackView;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (nonatomic, strong) GMSMapView *mapView;
@property (nonatomic, strong) MBProgressHUD *loadingHud;
@property (nonatomic, strong) DirectionViewModel *directionViewModel;
@property (nonatomic, strong) UserViewModel *userViewModel;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation MainViewController

- (DirectionViewModel *) directionViewModel {
    if (_directionViewModel == nil) {
        _directionViewModel = [[DirectionViewModel alloc] init];
    }
    return _directionViewModel;
}

- (UserViewModel *) userViewModel {
    if (_userViewModel == nil) {
        _userViewModel = [[UserViewModel alloc] init];
    }
    return _userViewModel;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    [self subscribeSignals];
    [self initLocation];
    [self initUI];
}

- (void) viewWillDisappear: (BOOL) animated {
    [super viewWillDisappear: animated];
    
    if (self.loadingHud != nil) {
        [self.loadingHud removeFromSuperview];
        self.loadingHud = nil;
    }
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.mapView.frame = self.mapViewContainer.bounds;
}

- (void) viewDidAppear: (BOOL) animated {
    [super viewDidAppear: animated];
    
    if (![self.userViewModel isUpdatedPosition]) {
        CLLocationCoordinate2D location = [self.userViewModel getCurrentLocation];
        [self moveCameraToRequestedPlace: location];
        [self.userViewModel alreadyUpdated];
    }
}

- (void) subscribeSignals {
    @weakify(self);
    [[self.directionViewModel.success subscribeOn: [RACScheduler mainThreadScheduler]] subscribeNext: ^(id x) {
        @strongify(self);
        [self loadRouteData];
        [self.loadingHud hideAnimated: YES];
    }];
    [[self.directionViewModel.error subscribeOn: [RACScheduler mainThreadScheduler]] subscribeNext:^(NSError *error) {
        @strongify(self);
        [self.loadingHud hideAnimated: YES];
        [self showError: error message: @"Error retrieving requested information"];
    }];
}

- (void) initLocation {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
}

- (void) initUI {
    self.loadingHud = [[MBProgressHUD alloc] initWithFrame: self.view.window.bounds];
    [self.view addSubview: self.loadingHud];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: 0 longitude: 0 zoom: 12];
    self.mapView = [GMSMapView mapWithFrame: self.mapViewContainer.bounds camera: camera];
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSURL *styleUrl = [mainBundle URLForResource:@"style" withExtension:@"json"];
    GMSMapStyle *style = [GMSMapStyle styleWithContentsOfFileURL: styleUrl error: nil];
    if (!style) {
        NSLog(@"The style definition could not be loaded");
    } else {
        self.mapView.mapStyle = style;
    }

//    [self.mapView.settings setCompassButton: YES];
//    [self.mapView.settings setMyLocationButton: YES];
    [self.mapView setMyLocationEnabled: YES];
    [self.mapView setDelegate: self];
    [self.mapViewContainer addSubview: self.mapView];
}

- (void) mapView:(GMSMapView *) mapView didTapAtCoordinate: (CLLocationCoordinate2D) coordinate {
    [self.mapView clear];
    
    GMSMarker *marker = [GMSMarker markerWithPosition: coordinate];
    marker.icon = [GMSMarker markerImageWithColor: [UIColor colorWithRed: 255.0f/255.0f green: 64.0f/255.0f blue: 128.0f/255.0f alpha: 1.0f]];
    marker.map = mapView;
    
    NSString *currentLocation = [self.userViewModel getCurrentLocationFormatted];
    NSString *customLocation = [NSString stringWithFormat: @"%f,%f", coordinate.latitude, coordinate.longitude];
    
    self.placeNameLabel.text = @"Custom location";
    self.placeDescriptionLabel.text = customLocation;
    [self.directionViewModel directionRequest: currentLocation destination: customLocation];
}

- (void) searchCallback: (PlaceDetail *) placeDetail {
    [self.mapView clear];
    self.placeNameLabel.text = placeDetail.name;
    self.placeDescriptionLabel.text = placeDetail.formattedAddress;
    
    CLLocationDegrees latitude = [placeDetail.geometry.location.lat doubleValue];
    CLLocationDegrees longitude = [placeDetail.geometry.location.lng doubleValue];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    [self addMarkerToRequestedPlace: coordinate];
    [self moveCameraToRequestedPlace: coordinate];
    [self getDirectionToRequestedPlace: [NSString stringWithFormat: @"%@,%@", placeDetail.geometry.location.lat, placeDetail.geometry.location.lng]];
}

- (void) addMarkerToRequestedPlace: (CLLocationCoordinate2D) coordinate {
    GMSMarker *marker = [GMSMarker markerWithPosition: coordinate];
    marker.icon = [GMSMarker markerImageWithColor: [UIColor colorWithRed: 255.0f/255.0f green: 64.0f/255.0f blue: 128.0f/255.0f alpha: 1.0f]];
    marker.map = self.mapView;
}

- (void) moveCameraToRequestedPlace: (CLLocationCoordinate2D) coordinate {
    dispatch_async(dispatch_get_main_queue(), ^{
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: coordinate.latitude longitude: coordinate.longitude zoom: 12];
        GMSCameraUpdate *update = [GMSCameraUpdate setCamera: camera];
        [self.mapView animateWithCameraUpdate: update];
    });
}

- (void) getDirectionToRequestedPlace: (NSString *) destination {
    NSString *currentLocation = [self.userViewModel getCurrentLocationFormatted];
    [self.directionViewModel directionRequest: currentLocation destination: destination];
}

- (void) loadRouteData {
    [self.directionViewModel getPolyline].map = self.mapView;
    
    if ([self.routeDataStackView isHidden]) {
        [self.routeDataStackView setHidden: NO];
    }
    
    self.distanceLabel.text = [self.directionViewModel getDistance];
    self.durationLabel.text = [self.directionViewModel getDuration];
}

- (void) locationManagerDidChangeAuthorization: (CLLocationManager *) manager {
    if (!(manager.authorizationStatus == kCLAuthorizationStatusAuthorizedAlways || manager.authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse)) {
        [self showError: nil message: @"We need your location to use maps functionalities"];
    }
}

- (void) locationManager: (CLLocationManager *) manager didUpdateLocations: (NSArray *) locations {
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    [self.userViewModel setCurrentLocation: coordinate];
}

- (void) showError: (NSError *) error message: (NSString *) message {
    NSLog(@"Error: %@", error);
    MBProgressHUD *errorHud = [MBProgressHUD showHUDAddedTo: self.view animated: YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        errorHud.mode = MBProgressHUDModeText;
        errorHud.label.text = message;
        errorHud.margin = 10.f;
        errorHud.removeFromSuperViewOnHide = YES;
        [errorHud hideAnimated: YES afterDelay: 2];
    });
}

- (IBAction) searchPlaceAction: (id) sender {
    SearchTableViewController *searchTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchTableViewController"];
    searchTableViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    searchTableViewController.searchProtocol = self;
    [self presentViewController: searchTableViewController animated:YES completion:nil];
}

- (IBAction) currentPositionAction: (id) sender {
    CLLocationCoordinate2D location = [self.userViewModel getCurrentLocation];
    [self moveCameraToRequestedPlace: location];
}

- (IBAction) clearMapAction: (id) sender {
    [self.mapView clear];
}

@end
