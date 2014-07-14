//
//  xxiivvAppDelegate.m
//  BifurcanMac
//
//  Created by Patrick Winchell on 7/13/14.
//  Copyright (c) 2014 XXIIVV. All rights reserved.
//

#import "xxiivvAppDelegate.h"

@implementation xxiivvAppDelegate

int filterActive = 0;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    _window.backgroundColor = [NSColor blackColor];
    //_window.backgroundColor = [NSColor colorWithPatternImage:[NSImage imageNamed:@"6.right"]];
    //[_window setBackgroundColor:[NSColor colorWithPatternImage:[NSImage imageNamed:@"6.right"]]];
    //NSView* = _window.
    
    
    modeCurrent = 1;
    //[super viewDidLoad];
	//[self templateGrid];
	//[self templateView];
	//[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeTic) userInfo:nil repeats:YES];
}

- (void)templateView
{
	//self.view.tag = 888;
	//self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.left",modeCurrent]]];
	/*self.filterButton.frame = self.view.frame;
	self.filterButton.titleLabel.text = @"";
	self.filterButton.layer.zPosition = 1;
	[self.view bringSubviewToFront:self.filterButton];*/
    [_window setBackgroundColor:[NSColor colorWithPatternImage:[NSImage imageNamed:[NSString stringWithFormat:@"%d.left",modeCurrent]]]];
}

- (void)templateGrid
{
	int gridCellSizeFlat = 25;
	
	int gridCellHorizontalMod = 50;
	int gridCellVerticalMod = 0;
    
    int height =_window.frame.size.height-2;
	
	if( _window.frame.size.height > 480){
		gridCellVerticalMod = 50;
	}
	
	int gridCellCountVertical = 0;
	while (gridCellCountVertical < 19) {
		int gridCellCountHorizontal = 0;
		while (gridCellCountHorizontal < 9) {
			int gridCellId = (gridCellCountVertical*19) + gridCellCountHorizontal;
			NSImageView *gridCell= [[NSImageView alloc] initWithFrame:CGRectMake((gridCellCountHorizontal * gridCellSizeFlat)+gridCellHorizontalMod,height-( (gridCellCountVertical * gridCellSizeFlat)+gridCellVerticalMod), gridCellSizeFlat, gridCellSizeFlat)];
			//gridCell.backgroundColor = [UIColor colorWithPatternImage:[NSImage imageNamed:[NSString stringWithFormat:@"%d.left",modeCurrent]]];
            gridCell.image = [NSImage imageNamed:[NSString stringWithFormat:@"%d.left",modeCurrent]];
            gridCell.tag = gridCellId;
			if( gridCellCountVertical != 0 && gridCellCountHorizontal != 0 ){
                //[_window]
				[_window.contentView addSubview:gridCell];
			}
			
			gridCellCountHorizontal += 1;
		}
		gridCellCountVertical += 1;
	}
}

-(void)templateGridFlash
{
	for (NSImageView *gridCell in [_window.contentView subviews]) {
		if (gridCell.tag > 0) {
			if(filterActive == 1){
				gridCell.image = nil;
			}
			else{
				gridCell.image = [NSImage imageNamed:[NSString stringWithFormat:@"%d.left",modeCurrent]];
			}
		}
	}
}

-(void)templateGridHighlight :(int)character :(int)value
{
	int tagMod = 0;
	
	if(character == 1){ tagMod = 0; }
	if(character == 2){ tagMod = 4; }
	if(character == 3){ tagMod = 114; }
	if(character == 4){ tagMod = 118; }
	if(character == 5){ tagMod = 228; }
	if(character == 6){ tagMod = 232; }
	
	NSImage *gridCellImage = [NSImage imageNamed:[NSString stringWithFormat:@"%d.right",modeCurrent]];
    //UIColor *colorImage =[UIColor colorWithPatternImage:gridCellImage];
    if(value == 1){
        [(NSImageView*)[_window.contentView viewWithTag:21+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:40+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:50+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:59+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:78+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:97+tagMod] setImage:gridCellImage];
    }
    if(value == 2){
        [(NSImageView*)[_window.contentView viewWithTag:20+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:21+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:22+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:41+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:58+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:59+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:60+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:77+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:96+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:97+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:98+tagMod] setImage:gridCellImage];
    }
    if(value == 3){
        [(NSImageView*)[_window.contentView viewWithTag:20+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:21+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:22+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:41+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:58+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:59+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:60+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:79+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:96+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:97+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:98+tagMod] setImage:gridCellImage];
    }
    if(value == 4){
        [(NSImageView*)[_window.contentView viewWithTag:20+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:22+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:39+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:41+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:58+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:59+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:60+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:79+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:98+tagMod] setImage:gridCellImage];
    }
    if(value == 5){
        [(NSImageView*)[_window.contentView viewWithTag:20+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:21+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:22+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:39+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:58+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:59+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:60+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:79+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:96+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:97+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:98+tagMod] setImage:gridCellImage];
    }
    if(value == 6){
        [(NSImageView*)[_window.contentView viewWithTag:20+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:39+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:58+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:59+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:60+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:77+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:79+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:96+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:97+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:98+tagMod] setImage:gridCellImage];
    }
    if(value == 7){
        [(NSImageView*)[_window.contentView viewWithTag:20+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:21+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:22+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:41+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:60+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:79+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:98+tagMod] setImage:gridCellImage];
    }
    if(value == 8){
        [(NSImageView*)[_window.contentView viewWithTag:20+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:21+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:22+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:39+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:41+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:58+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:59+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:60+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:77+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:79+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:96+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:97+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:98+tagMod] setImage:gridCellImage];
    }
    if(value == 9){
        [(NSImageView*)[_window.contentView viewWithTag:20+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:21+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:22+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:39+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:41+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:58+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:59+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:60+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:79+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:98+tagMod] setImage:gridCellImage];
    }
    if(value == 0){
        [(NSImageView*)[_window.contentView viewWithTag:20+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:21+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:22+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:39+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:41+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:58+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:60+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:77+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:79+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:96+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:97+tagMod] setImage:gridCellImage];
        [(NSImageView*)[_window.contentView viewWithTag:98+tagMod] setImage:gridCellImage];
    }
}

-(void)timeTic
{
	//[self playSoundNamed:@"click.fast":0];
	
	NSDate *currentTime = [NSDate date];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"HH"]; // @"hh-mm"
	NSString *t_hour = [dateFormatter stringFromDate: currentTime];
	[dateFormatter setDateFormat:@"mm"]; // @"hh-mm"
	NSString *t_minu = [dateFormatter stringFromDate: currentTime];
	[dateFormatter setDateFormat:@"ss"]; // @"hh-mm"
	NSString *t_seco = [dateFormatter stringFromDate: currentTime];
	
	NSLog(@"TAC: %@", t_seco);
	
	[self templateGridFlash];
	
	[self templateGridHighlight:1:[[t_hour substringWithRange:NSMakeRange(0, 1)] intValue]];
	[self templateGridHighlight:2:[[t_hour substringWithRange:NSMakeRange(1, 1)] intValue]];
	[self templateGridHighlight:3:[[t_minu substringWithRange:NSMakeRange(0, 1)] intValue]];
	[self templateGridHighlight:4:[[t_minu substringWithRange:NSMakeRange(1, 1)] intValue]];
	[self templateGridHighlight:5:[[t_seco substringWithRange:NSMakeRange(0, 1)] intValue]];
	[self templateGridHighlight:6:[[t_seco substringWithRange:NSMakeRange(1, 1)] intValue]];
}
- (IBAction)filterButtonWasClicked:(id)sender {
    
	modeCurrent += 1;
	
	if (modeCurrent > 6) {
		modeCurrent = 1;
	}
	
	NSLog(@"%d",modeCurrent);
	
    //	if( filterActive == 1 ){
    //		[self playSoundNamed:@"click.fast":0];
    //		filterActive = 0;
    //		[[_window.contentView viewWithTag:0] setBackgroundColor:[UIColor colorWithPatternImage:[NSImage imageNamed:@"left"]]];
    //		_window.contentView.backgroundColor = [UIColor colorWithPatternImage:[NSImage imageNamed:@"left"]];
    //
    //	}
    //	else {
    //		[self playSoundNamed:@"click.low":0];
    //		filterActive = 1;
    //		_window.contentView.backgroundColor = [UIColor blackColor];
    //		[[_window.contentView viewWithTag:0] setBackgroundColor:[UIColor blackColor]];
    //	}
    [_window setBackgroundColor:[NSColor colorWithPatternImage:[NSImage imageNamed:[NSString stringWithFormat:@"%d.left",modeCurrent]]]];
	//_window.contentView.backgroundColor = [UIColor colorWithPatternImage:[NSImage imageNamed:[NSString stringWithFormat:@"%d.left",modeCurrent]]];
	
	
    [self timeTic];
    [self templateGridFlash];
	
	NSLog(@"Filter Active: %d",filterActive);
	
}



@end
