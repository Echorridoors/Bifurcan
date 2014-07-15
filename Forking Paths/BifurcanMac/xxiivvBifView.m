//
//  xxiivvBifView.m
//  Bifurcan
//
//  Created by Patrick Winchell on 7/13/14.
//  Copyright (c) 2014 XXIIVV. All rights reserved.
//

#import "xxiivvBifView.h"

int modeCurrent = 0;




@implementation xxiivvBifView


- (id)initWithFrame:(rectType)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        [self startup];
        
    }
    return self;
}


-(void)awakeFromNib {
    [super awakeFromNib];
    [self startup];
}

-(void)startup {
    
    if(!left) {
        
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(tic) userInfo:nil repeats:YES];
        [runloop addTimer:timer forMode:NSRunLoopCommonModes];
        [runloop addTimer:timer forMode:NSDefaultRunLoopMode];
        
        #if TARGET_OS_IPHONE

        #else
                [runloop addTimer:timer forMode:NSEventTrackingRunLoopMode];
        #endif
        
        
        
        left = [imageType imageNamed:[NSString stringWithFormat:@"%d.left",modeCurrent+1]];
        right = [imageType imageNamed:[NSString stringWithFormat:@"%d.right",modeCurrent+1]];
    }
    
    [self playSoundNamed:@"ambience":1];
	audioPlayerAmbience.volume = 1;
	audioPlayer.volume = 1;
    
}

-(void)tic{
    [self refresh];
    [self playSoundNamed:@"click.fast":0];
}

-(void)refresh {
    
    
    #if TARGET_OS_IPHONE
    [self setNeedsDisplay];
    #else
    [self setNeedsDisplay:YES];
    #endif
    
}

-(void)nextFilter {
    modeCurrent++;
    modeCurrent%=6;
    left = [imageType imageNamed:[NSString stringWithFormat:@"%d.left",modeCurrent+1]];
    right = [imageType imageNamed:[NSString stringWithFormat:@"%d.right",modeCurrent+1]];
    [self tic];
}


- (void)drawRect:(rectType)dirtyRect
{
    
    
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
    
    #if TARGET_OS_IPHONE
        CGContextSetPatternPhase(UIGraphicsGetCurrentContext(), CGSizeMake(xoff+12.5, yoff+12.5));
    #else
        [[NSGraphicsContext currentContext] setPatternPhase:NSMakePoint(xoff+12.5, yoff+12.5)];
    #endif
    
    
    
    colorType *backColor = [colorType colorWithPatternImage:left];
    [backColor set];
    
    #if TARGET_OS_IPHONE
        UIRectFill(self.bounds);
    #else
        NSRectFill(self.bounds);
    #endif
    
    
    colorType *foreColor = [colorType colorWithPatternImage:right];
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
    
    float flipper = 1;
    
    #if TARGET_OS_IPHONE
        flipper = -1;
        yOffset-=1;
    #endif
    
    
    for(int i=0;i<15;i++) {
        if(chars[value][i]) {
            float x = i%3+xOffset;
            float y = floorf(i/3)+yOffset;
            x*=25;
            y*=25;
            x+=25;
            y+=25;
            CGRect rect = CGRectMake(self.bounds.size.width/2+x, (self.bounds.size.height/2)-y*flipper, 25, 25);
            rect.origin.x = ceilf(rect.origin.x);
            rect.origin.y = ceilf(rect.origin.y);
            
            #if TARGET_OS_IPHONE
                UIRectFill(rect);
            #else
                NSRectFill(rect);
            #endif
            
            
        }
    }
    
    
}

#if TARGET_OS_IPHONE
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self nextFilter];
}
#else
-(void)mouseUp:(NSEvent *)theEvent {
    [self nextFilter];
}
#endif

- (void)playSoundNamed:(NSString*)name :(int)loop
{
	//NSLog(@" AUDIO | Playing sound: %@",name);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        
	NSString* audioPath = [[NSBundle mainBundle] pathForResource:name ofType:@"wav"];
	NSURL* audioUrl = [NSURL fileURLWithPath:audioPath];
	
	if(loop == 1){
		audioPlayerAmbience = [[AVAudioPlayer alloc] initWithContentsOfURL:audioUrl error:nil];
		audioPlayerAmbience.volume = 1;
		audioPlayerAmbience.numberOfLoops = -1;
		[audioPlayerAmbience prepareToPlay];
		[audioPlayerAmbience play];
	}
	else{
        if(!audioPlayer || !audioPlayer.isPlaying) {
            audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioUrl error:nil];
            audioPlayer.volume = 0.5;
            audioPlayer.numberOfLoops = 0;
            [audioPlayer prepareToPlay];
            [audioPlayer play];
        }
	}
    });
}


@end
