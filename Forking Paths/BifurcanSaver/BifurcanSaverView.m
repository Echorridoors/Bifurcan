//
//  BifurcanSaverView.m
//  BifurcanSaver
//
//  Created by Patrick Winchell on 7/14/14.
//  Copyright (c) 2014 XXIIVV. All rights reserved.
//

#import "BifurcanSaverView.h"

@implementation BifurcanSaverView

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        
        NSString *userDefaultsValuesPath;
        NSDictionary *userDefaultsValuesDict;
        
        // load the default values for the user defaults
        userDefaultsValuesPath=[[NSBundle mainBundle] pathForResource:@"UserDefaults"
                                                               ofType:@"plist"];
        userDefaultsValuesDict=[NSDictionary dictionaryWithContentsOfFile:userDefaultsValuesPath];
        
        
        // Set the initial values in the shared user defaults controller
        [[NSUserDefaultsController sharedUserDefaultsController] setInitialValues:userDefaultsValuesDict];
        
        [self setAnimationTimeInterval:1.0];
        bifView = [[xxiivvBifView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [bifView setSound:false];
        
        [bifView setFilterType:(int)[[[[NSUserDefaultsController sharedUserDefaultsController] values] valueForKey:@"filterType"] integerValue] ];
        [self addSubview:bifView];
        [self setNeedsDisplay:YES];
        [self setWantsLayer:YES];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
    //bifView = [[xxiivvBifView alloc] initWithFrame:self.frame];
    //[self addSubview:bifView];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
     [bifView setFilterType:(int)[[[[NSUserDefaultsController sharedUserDefaultsController] values] valueForKey:@"filterType"] integerValue] ];
    [super drawRect:rect];
}

- (void)animateOneFrame
{
    [self setNeedsDisplay:YES];
    return;
}

- (BOOL)hasConfigureSheet
{
    return YES  ;
}

- (NSWindow *)configureSheet
{
    if (!configSheet)
    {
        if (![NSBundle loadNibNamed:@"ConfigureSheet" owner:self])
        {
            NSLog( @"Failed to load configure sheet." );
            NSBeep();
        }
    }
    
    return configSheet;
}

- (IBAction)cancelClick:(id)sender
{
    [[NSApplication sharedApplication] endSheet:configSheet];
}

- (IBAction) okClick: (id)sender
{
    
    [[NSApplication sharedApplication] endSheet:configSheet];
}

- (void)setFrameSize:(NSSize)newSize
{
    [super setFrameSize:newSize];
    [bifView setFrameSize:newSize];
}


@end
