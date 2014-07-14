//
//  xxiivvBifView.m
//  Bifurcan
//
//  Created by Patrick Winchell on 7/13/14.
//  Copyright (c) 2014 XXIIVV. All rights reserved.
//

#import "xxiivvBifView.h"

@implementation xxiivvBifView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        
        
    }
    return self;
}

-(void)refresh {
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect
{
    if(!left) {
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(refresh) userInfo:nil repeats:YES];
        left = [NSImage imageNamed:[NSString stringWithFormat:@"%d.left",1]];
        right = [NSImage imageNamed:[NSString stringWithFormat:@"%d.right",1]];
    }
    
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    
    /*int mywidth = self.bounds.size.width;
    int myheight = self.bounds.size.height;
    int xoff = mywidth%25;
    int yoff = myheight%25;
    mywidth-=mywidth%25;
    myheight-=myheight%25;
    
    CGRectMake(xoff/2, yoff/2, mywidth, myheight);*/
    float xoff =fmodf(self.bounds.size.width/2 , 25) ;
    float yoff =fmodf(self.bounds.size.height/2 , 25) ;
    [[NSGraphicsContext currentContext]
     setPatternPhase:NSMakePoint(xoff+12.5, yoff+12.5)];
    NSColor *backColor = [NSColor colorWithPatternImage:left];
    [backColor set];
    NSRectFill(self.bounds);
    
    NSColor *foreColor = [NSColor colorWithPatternImage:right];
    [foreColor set];
    NSDate *currentTime = [NSDate date];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"HH"]; // @"hh-mm"
	NSString *t_hour = [dateFormatter stringFromDate: currentTime];
	[dateFormatter setDateFormat:@"mm"]; // @"hh-mm"
	NSString *t_minu = [dateFormatter stringFromDate: currentTime];
	[dateFormatter setDateFormat:@"ss"]; // @"hh-mm"
	NSString *t_seco = [dateFormatter stringFromDate: currentTime];
	
	//NSLog(@"TAC: %@", t_seco);
	
	
	[self drawCharacter:1:[[t_hour substringWithRange:NSMakeRange(0, 1)] intValue]];
	[self drawCharacter:2:[[t_hour substringWithRange:NSMakeRange(1, 1)] intValue]];
	[self drawCharacter:3:[[t_minu substringWithRange:NSMakeRange(0, 1)] intValue]];
	[self drawCharacter:4:[[t_minu substringWithRange:NSMakeRange(1, 1)] intValue]];
	[self drawCharacter:5:[[t_seco substringWithRange:NSMakeRange(0, 1)] intValue]];
	[self drawCharacter:6:[[t_seco substringWithRange:NSMakeRange(1, 1)] intValue]];
    
}


static BOOL chars[10][15] = {
    {
        true,true,true,
        true,false,true,
        true,false,true,
        true,false,true,
        true,true,true
    },
    {
        false,true,false,
        false,true,false,
        false,true,false,
        false,true,false,
        false,true,false
    },
    {
        true,true,true,
        false,false,true,
        true,true,true,
        true,false,false,
        true,true,true
    },
    {
        true,true,true,
        false,false,true,
        true,true,true,
        false,false,true,
        true,true,true
    },
    {
        true,false,true,
        true,false,true,
        true,true,true,
        false,false,true,
        false,false,true
    },
    {
        true,true,true,
        true,false,false,
        true,true,true,
        false,false,true,
        true,true,true
    },
    {
        true,false,false,
        true,false,true,
        true,true,true,
        true,false,true,
        true,true,true
    },
    {
        true,true,true,
        false,false,true,
        false,false,true,
        false,false,true,
        false,true,true
    },
    {
        true,true,true,
        true,false,true,
        true,true,true,
        true,false,true,
        true,true,true
    },
    {
        true,true,true,
        true,false,true,
        true,true,true,
        false,false,true,
        false,false,true
    }
};


-(void)drawCharacter :(int)character :(int)value {
    
    
    float xOffset = 0;
    float yOffset = 0;
    if(character%2==0)
        xOffset = 4;
    yOffset = floorf((character-1)/2)*6;
    xOffset-=4.5;
    yOffset-=8.5;
    
    for(int i=0;i<15;i++) {
        if(chars[value][i]) {
            float x = i%3+xOffset;
            float y = floorf(i/3)+yOffset;
            x*=25;
            y*=25;
            x+=25;
            y+=25;
            CGRect rect = CGRectMake(self.bounds.size.width/2+x, self.bounds.size.height/2-y, 25, 25);
            NSRectFill(rect);
        }
    }
    
    
}

@end
