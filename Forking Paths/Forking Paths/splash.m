//
//  splash.m
//  Ledoliel
//
//  Created by Devine Lu Linvega on 2014-06-19.
//  Copyright (c) 2014 XXIIVV. All rights reserved.
//

#import "splash.h"

@interface splash ()

@end

@implementation splash

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	splashTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(splashSkip) userInfo:nil repeats:NO];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)splashSkip
{
	[splashTimer invalidate];
	[self performSegueWithIdentifier: @"skip" sender: self];
}

- (IBAction)splashSkipButton:(id)sender {
	[self splashSkip];
}
@end
