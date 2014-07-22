//
//  xxiivvAppDelegate.m
//  Forking Paths
//
//  Created by Devine Lu Linvega on 11/2/2013.
//  Copyright (c) 2013 XXIIVV. All rights reserved.
//

#import "xxiivvAppDelegate.h"
#import "xxiivvBifView.h"

@implementation xxiivvAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self checkForExistingScreenAndInitializeIfPresent];
    [self setUpScreenConnectionNotificationHandlers];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)setUpScreenConnectionNotificationHandlers
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(handleScreenDidConnectNotification:)
                   name:UIScreenDidConnectNotification object:nil];
    [center addObserver:self selector:@selector(handleScreenDidDisconnectNotification:)
                   name:UIScreenDidDisconnectNotification object:nil];
}



- (void)checkForExistingScreenAndInitializeIfPresent
{
    if ([[UIScreen screens] count] > 1)
    {
        [self handleScreenDidConnectNotification:nil];
    }
}

- (void)handleScreenDidConnectNotification:(NSNotification*)aNotification
{
    if ([[UIScreen screens] count] > 1)
    {        
        UIScreen *newScreen = [[UIScreen screens] objectAtIndex:1];
        CGRect screenBounds = newScreen.bounds;
        [self handleScreenDidDisconnectNotification:nil];
        if (!self.secondWindow)
        {
            newScreen.overscanCompensation =  2;
            self.secondWindow = [[UIWindow alloc] initWithFrame:screenBounds];
            self.secondWindow.screen = newScreen;
            
            xxiivvBifView* bifView = [[xxiivvBifView alloc] initWithFrame:screenBounds];
            [bifView setSound:false];
            
            [self.secondWindow addSubview:bifView];
            
            [self.secondWindow addConstraint:[NSLayoutConstraint constraintWithItem:bifView
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.secondWindow
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:1.0
                                                                   constant:0]];
            
            // Height constraint, half of parent view height
            [self.secondWindow addConstraint:[NSLayoutConstraint constraintWithItem:bifView
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.secondWindow
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:1.0
                                                                   constant:0]];
            
            // Center horizontally
            [self.secondWindow addConstraint:[NSLayoutConstraint constraintWithItem:bifView
                                                                  attribute:NSLayoutAttributeCenterX
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.secondWindow
                                                                  attribute:NSLayoutAttributeCenterX
                                                                 multiplier:1.0
                                                                   constant:0.0]];
            
            // Center vertically
            [self.secondWindow addConstraint:[NSLayoutConstraint constraintWithItem:bifView
                                                                  attribute:NSLayoutAttributeCenterY
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.secondWindow
                                                                  attribute:NSLayoutAttributeCenterY
                                                                 multiplier:1.0
                                                                   constant:0.0]];
            
            self.secondWindow.hidden = NO;
            // Set the initial UI for the window.
        }
    }
}

- (void)handleScreenDidDisconnectNotification:(NSNotification*)aNotification
{
    if (self.secondWindow)
    {
        // Hide and then delete the window.
        self.secondWindow.hidden = YES;
        self.secondWindow = nil;
        
    }
    
}

@end
