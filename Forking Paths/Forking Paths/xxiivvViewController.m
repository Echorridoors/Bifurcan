//
//  xxiivvViewController.m
//  Forking Paths
//
//  Created by Devine Lu Linvega on 11/2/2013.
//  Copyright (c) 2013 XXIIVV. All rights reserved.
//

#import "xxiivvViewController.h"

@interface xxiivvViewController ()

@end

int filterActive = 0;


@implementation xxiivvViewController

- (void)viewDidLoad
{
	modeCurrent = 1;
    [super viewDidLoad];
	[self templateGrid];
	[self templateView];
	[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeTic) userInfo:nil repeats:YES];
	[[UIApplication sharedApplication] setIdleTimerDisabled: YES];
	
	[self playSoundNamed:@"ambience":1];
	audioPlayerAmbience.volume = 1;
	audioPlayer.volume = 1;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)templateView
{
	self.view.tag = 888;
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.left.jpg",modeCurrent]]];
	self.filterButton.frame = self.view.frame;
	self.filterButton.titleLabel.text = @"";
	self.filterButton.layer.zPosition = 1;
	[self.view bringSubviewToFront:self.filterButton];
}

- (void)templateGrid
{
	int gridCellSizeFlat = 25;
	
	int gridCellHorizontalMod = 50;
	int gridCellVerticalMod = 0;
	
	if( self.view.frame.size.height > 480){
		gridCellVerticalMod = 50;
	}
	
	int gridCellCountVertical = 0;
	while (gridCellCountVertical < 19) {
		int gridCellCountHorizontal = 0;
		while (gridCellCountHorizontal < 9) {
			int gridCellId = (gridCellCountVertical*19) + gridCellCountHorizontal;
			UIImageView *gridCell= [[UIImageView alloc] initWithFrame:CGRectMake((gridCellCountHorizontal * gridCellSizeFlat)+gridCellHorizontalMod, (gridCellCountVertical * gridCellSizeFlat)+gridCellVerticalMod, gridCellSizeFlat, gridCellSizeFlat)];
			//gridCell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.left.jpg",modeCurrent]]];
            gridCell.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.left.jpg",modeCurrent]];
            gridCell.tag = gridCellId;
			if( gridCellCountVertical != 0 && gridCellCountHorizontal != 0 ){
				[self.view addSubview:gridCell];
			}
			
			gridCellCountHorizontal += 1;
		}
		gridCellCountVertical += 1;
	}
}

-(void)templateGridFlash
{
	for (UIImageView *gridCell in [self.view subviews]) {
		if (gridCell.tag > 0) {
			if(filterActive == 1){
				gridCell.backgroundColor = [UIColor blackColor];
			}
			else{
				gridCell.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.left.jpg",modeCurrent]];
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
	
	UIImage *gridCellImage = [UIImage imageNamed:[NSString stringWithFormat:@"%d.right.jpg",modeCurrent]];
    UIColor *colorImage =[UIColor colorWithPatternImage:gridCellImage];
    if(value == 1){
        [(UIImageView*)[self.view viewWithTag:21+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:40+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:50+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:59+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:78+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:97+tagMod] setImage:gridCellImage];
    }
    if(value == 2){
        [(UIImageView*)[self.view viewWithTag:20+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:21+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:22+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:41+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:58+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:59+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:60+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:77+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:96+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:97+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:98+tagMod] setImage:gridCellImage];
    }
    if(value == 3){
        [(UIImageView*)[self.view viewWithTag:20+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:21+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:22+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:41+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:58+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:59+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:60+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:79+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:96+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:97+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:98+tagMod] setImage:gridCellImage];
    }
    if(value == 4){
        [(UIImageView*)[self.view viewWithTag:20+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:22+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:39+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:41+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:58+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:59+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:60+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:79+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:98+tagMod] setImage:gridCellImage];
    }
    if(value == 5){
        [(UIImageView*)[self.view viewWithTag:20+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:21+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:22+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:39+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:58+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:59+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:60+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:79+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:96+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:97+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:98+tagMod] setImage:gridCellImage];
    }
    if(value == 6){
        [(UIImageView*)[self.view viewWithTag:20+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:39+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:58+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:59+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:60+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:77+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:79+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:96+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:97+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:98+tagMod] setImage:gridCellImage];
    }
    if(value == 7){
        [(UIImageView*)[self.view viewWithTag:20+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:21+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:22+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:41+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:60+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:79+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:98+tagMod] setImage:gridCellImage];
    }
    if(value == 8){
        [(UIImageView*)[self.view viewWithTag:20+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:21+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:22+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:39+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:41+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:58+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:59+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:60+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:77+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:79+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:96+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:97+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:98+tagMod] setImage:gridCellImage];
    }
    if(value == 9){
        [(UIImageView*)[self.view viewWithTag:20+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:21+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:22+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:39+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:41+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:58+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:59+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:60+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:79+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:98+tagMod] setImage:gridCellImage];
    }
    if(value == 0){
        [(UIImageView*)[self.view viewWithTag:20+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:21+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:22+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:39+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:41+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:58+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:60+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:77+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:79+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:96+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:97+tagMod] setImage:gridCellImage];
        [(UIImageView*)[self.view viewWithTag:98+tagMod] setImage:gridCellImage];
    }
}

-(void)timeTic
{
	[self playSoundNamed:@"click.fast":0];
	
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
//		[[self.view viewWithTag:0] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"left.jpg"]]];
//		self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"left.jpg"]];
//		
//	}
//	else {
//		[self playSoundNamed:@"click.low":0];
//		filterActive = 1;
//		self.view.backgroundColor = [UIColor blackColor];
//		[[self.view viewWithTag:0] setBackgroundColor:[UIColor blackColor]];
//	}
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.left.jpg",modeCurrent]]];
	
	
    [self timeTic];
    [self templateGridFlash];
	
	NSLog(@"Filter Active: %d",filterActive);
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)playSoundNamed:(NSString*)name :(int)loop
{
	NSLog(@" AUDIO | Playing sound: %@",name);
	
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
		audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioUrl error:nil];
		audioPlayer.volume = 0.5;
		audioPlayer.numberOfLoops = 0;
		[audioPlayer prepareToPlay];
		[audioPlayer play];
	}
	
}

@end
