//
//  xxiivvViewController.h
//  Forking Paths
//
//  Created by Devine Lu Linvega on 11/2/2013.
//  Copyright (c) 2013 XXIIVV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface xxiivvViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *filterButton;

@end

AVAudioPlayer *audioPlayer;