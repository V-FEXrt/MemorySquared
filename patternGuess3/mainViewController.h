//
//  mainViewController.h
//  
//
//  Created by Ashley Coleman on 1/23/14.
//  Copyright (c) 2014 Ashley Coleman. All rights reserved.


//This class is the first screen that is loaded, when Free Play is pressed control changes to fpViewController
//      when Adventure is selected control is passed to advViewController.

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "playerLevel.h"
#import <iAd/iAd.h>
@interface mainViewController : UIViewController<UIAlertViewDelegate, ADBannerViewDelegate>
{
    //Its the song
    AVAudioPlayer *introSong;
}
//image to represent mute/not mute
@property (strong, nonatomic) IBOutlet UIImageView *imageViewforSound;
@property (strong, nonatomic) IBOutlet UIView *entireView;
@property (strong, nonatomic) IBOutlet UIImageView *introScene;

//Button Click action to change state
- (IBAction)muteIsPressed:(id)sender;
- (IBAction)optionButtonClicked:(id)sender;

@end
