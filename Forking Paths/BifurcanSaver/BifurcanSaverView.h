//
//  BifurcanSaverView.h
//  BifurcanSaver
//
//  Created by Patrick Winchell on 7/14/14.
//  Copyright (c) 2014 XXIIVV. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>
#import "xxiivvBifView.h"
@interface BifurcanSaverView : ScreenSaverView
{
    IBOutlet id configSheet;
    xxiivvBifView* bifView;
}
@end
