//
//  main.m
//  MapsApp
//
//  Created by Jean Carlo Hernández Arguedas on 19/1/24.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main (int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
