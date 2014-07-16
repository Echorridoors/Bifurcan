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
        [self setAnimationTimeInterval:1.0];
        bifView = [[xxiivvBifView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [bifView setSound:false];
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
    [[NSColor blueColor] set];
    //[bifView setFrame:rect];
    NSRectFill(rect);
    [super drawRect:rect];
    //[bifView drawRect:rect];
    [[NSColor blueColor] set];
    //[bifView setFrame:rect];
    NSRectFill(rect);
}

- (void)animateOneFrame
{
    [self setNeedsDisplay:YES];
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

- (void)setFrameSize:(NSSize)newSize
{
    [super setFrameSize:newSize];
    [bifView setFrameSize:newSize];
}


@end
