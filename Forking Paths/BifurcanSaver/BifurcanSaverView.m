//
//  BifurcanSaverView.m
//  BifurcanSaver
//
//  Created by Patrick Winchell on 7/14/14.
//  Copyright (c) 2014 XXIIVV. All rights reserved.
//

#import "BifurcanSaverView.h"

static NSString * const MyModuleName = @"com.XXIIVV.bifurcansaver";

@implementation BifurcanSaverView

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        
        NSString *userDefaultsValuesPath;
        
        
        ScreenSaverDefaults *defaults;
        
        defaults = [ScreenSaverDefaults defaultsForModuleWithName:MyModuleName];
        
        // Register our default values
        [defaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
                                    @0, @"filterType",
                                    nil]];
        
        
        
        [self setAnimationTimeInterval:1.0];
        bifView = [[xxiivvBifView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [bifView setSound:false];
        
        
        [bifView setFilterType:(int)[defaults integerForKey:@"filterType"] ];
        [defaults synchronize];
        [self addSubview:bifView];
        [self setNeedsDisplay:YES];
        [self setWantsLayer:YES];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
    ScreenSaverDefaults *defaults;
    
    defaults = [ScreenSaverDefaults defaultsForModuleWithName:MyModuleName];
    
    
    [bifView setFilterType:(int)[defaults integerForKey:@"filterType"] ];
    //bifView = [[xxiivvBifView alloc] initWithFrame:self.frame];
    //[self addSubview:bifView];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    
    ScreenSaverDefaults *defaults;
    
    defaults = [ScreenSaverDefaults defaultsForModuleWithName:MyModuleName];
    
    
     [bifView setFilterType:(int)[defaults integerForKey:@"filterType"] ];
    [super drawRect:rect];
}

- (void)animateOneFrame
{
    ScreenSaverDefaults *defaults;
    
    defaults = [ScreenSaverDefaults defaultsForModuleWithName:MyModuleName];
    
    
    [bifView setFilterType:(int)[defaults integerForKey:@"filterType"] ];
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
        
        ScreenSaverDefaults *defaults;
        
        defaults = [ScreenSaverDefaults defaultsForModuleWithName:MyModuleName];
        
        [popupList selectItemAtIndex:[defaults integerForKey:@"filterType"]];
        
        [[NSApplication sharedApplication] endSheet:configSheet];
        
    }
    
    return configSheet;
}

- (IBAction)cancelClick:(id)sender
{
    [[NSApplication sharedApplication] endSheet:configSheet];
}

- (IBAction) okClick: (id)sender
{
    
    ScreenSaverDefaults *defaults;
    
    defaults = [ScreenSaverDefaults defaultsForModuleWithName:MyModuleName];
    
    [defaults setInteger:[popupList selectedTag] forKey:@"filterType"];
    //NSLog(@"butts:%d",[popupList selectedTag]);
    [defaults synchronize];
    [[NSApplication sharedApplication] endSheet:configSheet];
}

- (void)setFrameSize:(NSSize)newSize
{
    [super setFrameSize:newSize];
    ScreenSaverDefaults *defaults;
    
    defaults = [ScreenSaverDefaults defaultsForModuleWithName:MyModuleName];
    
    
    [bifView setFilterType:(int)[defaults integerForKey:@"filterType"] ];
    [bifView setFrameSize:newSize];
}


@end
