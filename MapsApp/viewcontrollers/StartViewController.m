//
//  StartViewController.m
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 24/1/24.
//

#import "StartViewController.h"
#import "MainViewController.h"

@implementation StartViewController


- (IBAction) continueAction: (id) sender {
    MainViewController *mainViewController = [self.storyboard instantiateViewControllerWithIdentifier: @"MainViewController"];
    mainViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self dismissViewControllerAnimated: YES completion: nil];
    [self presentViewController: mainViewController animated: YES completion: nil];
}

@end
