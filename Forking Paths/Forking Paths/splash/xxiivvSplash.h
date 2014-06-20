//
//  splash.h
//  Entaloneralie
//
//  Created by Devine Lu Linvega on 2013-06-06.
//  Copyright (c) 2013 XXIIVV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface splash : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *splashLogo;
@property (strong, nonatomic) IBOutlet UIImageView *splashLoader;
@property (strong, nonatomic) IBOutlet UIImageView *splashSupport;
@property (strong, nonatomic) IBOutlet UIButton *btnSplashSupport;
- (IBAction)btnSplashSupport:(id)sender;

@end

NSString *supportUrl;

NSTimer *blinker;