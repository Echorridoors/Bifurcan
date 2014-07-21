//
//  xxiivvBifView.m
//  Bifurcan
//
//  Created by Patrick Winchell on 7/13/14.
//  Copyright (c) 2014 XXIIVV. All rights reserved.
//

#import "xxiivvBifView.h"




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

-(void)setSound:(bool)shouldSound {
    soundEnabled = shouldSound;
    if(soundEnabled) {
        [self playSoundNamed:@"ambience":1];
         audioPlayerAmbience.volume = 1;
         audioPlayer.volume = 1;
    }
    else {
        if(audioPlayerAmbience) {
            [audioPlayerAmbience stop];
        }
        if(audioPlayer) {
            [audioPlayer stop];
        }
    }
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self startup];
}

-(imageType*) getImage:(NSString*)name { //imageNamed: doesn't work in screensavers
    imageType* image = [imageType imageNamed:name];
    if(!image) {
        NSBundle *programBundle = [NSBundle bundleForClass:[self class]];
        NSString *path = [programBundle pathForResource:name ofType:@"png"];
       // NSLog(@"path%@",name);
        image =  [[imageType alloc] initWithContentsOfFile:path];
    }
    
    return image;
    
}

-(void)startup {
    
    if(!srcleft) {
        
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(tic) userInfo:nil repeats:YES];
        [runloop addTimer:timer forMode:NSRunLoopCommonModes];
        [runloop addTimer:timer forMode:NSDefaultRunLoopMode];
        
        #if TARGET_OS_IPHONE

        #else
                [runloop addTimer:timer forMode:NSEventTrackingRunLoopMode];
        #endif
        
        
        srcleft =  [self getImage:[NSString stringWithFormat:@"%d.left",modeCurrent+1]];
        srcright =  [self getImage:[NSString stringWithFormat:@"%d.right",modeCurrent+1]];
    }
    doFlash=true;
    modeCurrent=0;
    [self setSound:true];
    
    [self refresh];
    
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

-(void)loadFilter {
    srcleft =  [self getImage:[NSString stringWithFormat:@"%d.left",modeCurrent+1]];
    srcright =  [self getImage:[NSString stringWithFormat:@"%d.right",modeCurrent+1]];
    left = nil;
    right=nil;
    lastGridSize = 0;
    [self refresh];
}

-(void)setFilterType:(int)filterType {
    if(modeCurrent!=filterType) {
        modeCurrent = filterType;
        modeCurrent%=6;
        doFlash=true;
        [self loadFilter];
    }
}

-(void)nextFilter {
    modeCurrent++;
    modeCurrent%=6;
    doFlash=true;
    [self loadFilter];
    [self tic];
}


- (void)drawRect:(rectType)dirtyRect
{
    //NSLog(@"%d,%d,,%d,%d",(int)dirtyRect.origin.x,(int)dirtyRect.origin.y,(int)dirtyRect.size.width,(int)dirtyRect.size.height);
    [super drawRect:dirtyRect];
    
    float gridSize = srcleft.size.width;
    
    if(gridSize==0)
        gridSize=25;
    
    float maxSize = dirtyRect.size.width;
    //if(dirtyRect.size.height<maxSize)
        maxSize =dirtyRect.size.height;
    
    while (dirtyRect.size.height/(gridSize+25)>20 && dirtyRect.size.width/(gridSize+25)>12) {
        gridSize+=25;
    }
    
    if(!left || !right || left.size.width!=gridSize) {
        left = [self imageResize:srcleft newSize:CGSizeMake(gridSize, gridSize)];
        right = [self imageResize:srcright newSize:CGSizeMake(gridSize, gridSize)];
        lastGridSize=gridSize;
    }
    
    float xoff =fmodf(self.bounds.size.width/2 , gridSize)+gridSize/2 ;
    float yoff =fmodf(self.bounds.size.height/2 , gridSize)+gridSize/2 ;
    
    xoff = ceilf(xoff);
    yoff = ceilf(yoff);
    
    #if TARGET_OS_IPHONE
        CGContextSetPatternPhase(UIGraphicsGetCurrentContext(), CGSizeMake(xoff, yoff));
    #else
        [[NSGraphicsContext currentContext] setPatternPhase:NSMakePoint(xoff, yoff)];
    #endif
    
    
    colorType *backColor = [colorType colorWithPatternImage:left];
    //backColor = [colorType whiteColor];
    [backColor set];
    
    #if TARGET_OS_IPHONE
        UIRectFill(self.bounds);
    #else
        NSRectFill(self.bounds);
    #endif
    
    if(!doFlash) {
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
        
        
        [self drawCharacter:1:[[t_hour substringWithRange:NSMakeRange(0, 1)] intValue] :gridSize];
        [self drawCharacter:2:[[t_hour substringWithRange:NSMakeRange(1, 1)] intValue] :gridSize];
        [self drawCharacter:3:[[t_minu substringWithRange:NSMakeRange(0, 1)] intValue] :gridSize];
        [self drawCharacter:4:[[t_minu substringWithRange:NSMakeRange(1, 1)] intValue] :gridSize];
        [self drawCharacter:5:[[t_seco substringWithRange:NSMakeRange(0, 1)] intValue] :gridSize];
        [self drawCharacter:6:[[t_seco substringWithRange:NSMakeRange(1, 1)] intValue] :gridSize];
    }
    
    doFlash=false;
}


static BOOL chars[10][15] = {
    {//0
        true,true,true,
        true,false,true,
        true,false,true,
        true,false,true,
        true,true,true
    },
    {//1
        false,true,false,
        false,true,false,
        false,true,false,
        false,true,false,
        false,true,false
    },
    {//2
        true,true,true,
        false,false,true,
        true,true,true,
        true,false,false,
        true,true,true
    },
    {//3
        true,true,true,
        false,false,true,
        true,true,true,
        false,false,true,
        true,true,true
    },
    {//4
        true,false,true,
        true,false,true,
        true,true,true,
        false,false,true,
        false,false,true
    },
    {//5
        true,true,true,
        true,false,false,
        true,true,true,
        false,false,true,
        true,true,true
    },
    {//6
        true,false,false,
        true,false,false,
        true,true,true,
        true,false,true,
        true,true,true
    },
    {//7
        true,true,true,
        false,false,true,
        false,false,true,
        false,false,true,
        false,false,true
    },
    {//8
        true,true,true,
        true,false,true,
        true,true,true,
        true,false,true,
        true,true,true
    },
    {//9
        true,true,true,
        true,false,true,
        true,true,true,
        false,false,true,
        false,false,true
    }
};


-(void)drawCharacter :(int)character :(int)value :(float)gridsize {
    
    
    
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
            x*=gridsize;
            y*=gridsize;
            x+=gridsize;
            y+=gridsize;
            CGRect rect = CGRectMake(self.bounds.size.width/2+x, (self.bounds.size.height/2)-y*flipper, gridsize, gridsize);
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

CGPoint touchPoint;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if(touches.count>0) {
        touchPoint = [((UITouch*)[touches allObjects][0]) locationInView:self];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint newPoint = CGPointMake(-100, -100);
    if(touches.count>0) {
        newPoint = [((UITouch*)[touches allObjects][0]) locationInView:self];
    }
    if(powf(newPoint.x-touchPoint.x, 2)+powf(newPoint.y-touchPoint.y, 2)<40*40)
    [self nextFilter];
}
#else
-(void)mouseUp:(NSEvent *)theEvent {
    [self nextFilter];
}
#endif

- (void)playSoundNamed:(NSString*)name :(int)loop
{
    if(!soundEnabled)
        return;
	//NSLog(@" AUDIO | Playing sound: %@",name);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        
        NSString* audioPath = [[NSBundle mainBundle] pathForResource:name ofType:@"wav"];
        if(audioPath) {
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
                    if(!audioPlayer) {
                        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioUrl error:nil];
                        audioPlayer.volume = 0.5;
                        audioPlayer.numberOfLoops = 0;
                    }
                    [audioPlayer performSelectorOnMainThread:@selector(prepareToPlay) withObject:nil waitUntilDone:NO];
                    [audioPlayer performSelectorOnMainThread:@selector(play) withObject:nil waitUntilDone:NO];
                }
            }
        }
    });
}

- (void) setFrame:(CGRect)frame
{
    // Call the parent class to move the view
    [super setFrame:frame];
    lastGridSize = 0;
    // Do your custom code here.
}

#if TARGET_OS_IPHONE
- (imageType *)imageResize:(UIImage*)anImage
                 newSize:(CGSize)size
{
    // Scalling selected image to targeted size
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, size.width*anImage.scale, size.height*anImage.scale, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    CGContextClearRect(context, CGRectMake(0, 0, size.width*anImage.scale, size.height*anImage.scale));
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    if(anImage.imageOrientation == UIImageOrientationRight)
    {
        CGContextRotateCTM(context, -M_PI_2);
        CGContextTranslateCTM(context, -size.height, 0.0f);
        CGContextDrawImage(context, CGRectMake(0, 0, size.height*anImage.scale, size.width*anImage.scale), anImage.CGImage);
    }
    else
        CGContextDrawImage(context, CGRectMake(0, 0, size.width*anImage.scale, size.height*anImage.scale), anImage.CGImage);
    
    CGImageRef scaledImage=CGBitmapContextCreateImage(context);
    
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    UIImage *image = [UIImage imageWithCGImage:scaledImage scale:anImage.scale orientation:anImage.imageOrientation];
    
    CGImageRelease(scaledImage);
    
    
    return image;
}
#else
- (NSImage *)imageResize:(NSImage*)anImage
                   newSize:(CGSize)size
{
    // Scalling selected image to targeted size
    float scale = [[[self window] screen] backingScaleFactor];
    if(scale<1)
        scale = 1;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, size.width*scale, size.height*scale, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    CGContextClearRect(context, CGRectMake(0, 0, size.width*scale, size.height*scale));
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextDrawImage(context, CGRectMake(0, 0, size.width*scale, size.height*scale), [anImage CGImageForProposedRect:nil context:nil hints:nil]);
    CGImageRef scaledImage=CGBitmapContextCreateImage(context);
    
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    NSImage *image = [[NSImage alloc] initWithCGImage:scaledImage size:size];
    
    CGImageRelease(scaledImage);
    
    
    return image;
}

#endif

-(void)viewDidChangeBackingProperties {
    //[super viewDidChangeBackingProperties];
    if(srcleft!=nil) {
    [self loadFilter];
    }
}






@end
