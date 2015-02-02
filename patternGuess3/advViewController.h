//
//  advViewController.h
//
//
//  Created by Ashley Coleman on 1/15/14.
//  Copyright (c) 2014 Ashley Coleman. All rights reserved.

//This class handles the advendure mode, it is similar to free play, but it creates and saves levels.

#import "AreaWithButton.h"
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "playerLevel.h"


@interface advViewController : UIViewController<UIAlertViewDelegate>
{
    AVAudioPlayer *advSong;
}

//connection to the entire view so we can disable interaction
@property (strong, nonatomic) IBOutlet UIView *entireView;

//timer to time
@property (nonatomic, strong) NSTimer *timer;
//second timer
@property NSTimer* timer2;

//variable for saved data
@property(nonatomic,strong)playerLevel* playersLevel;

//used for checking win state
@property BOOL didWinGame2;

//count for array
@property int count;

//each buttonFunction sends a value to tell which button was clicked
@property int senderValue;

//second counter for checking pattern
@property int checkCount;

//count for image theme
@property int imageCount;

//array of the image views
@property NSArray* viewArray;

//temp variables for iterating through array
@property AreaWithButton* tempView;

//variables that are the area
@property AreaWithButton * area0;
@property AreaWithButton * area1;
@property AreaWithButton * area2;
@property AreaWithButton * area3;
@property AreaWithButton * area4;
@property AreaWithButton * area5;
@property AreaWithButton * area6;
@property AreaWithButton * area7;
@property AreaWithButton * area8;
@property AreaWithButton * area9;

//certain variables need reset for second play
@property bool secondPlay;

//keeps track of names for themes to be displayed
@property NSArray* themeNames;

//makes the random pattern
-(void)makeSequence;
//starts the game when the user clicks start
- (void)runShowSequence;
//shows the pattern
-(void)showSequence;
//runs each time user clicks a button checks if it was the right click
-(void)playGame;
//show/hides the views depending on the number of views selected
-(void)setLevel;
//checks if the user won or lost
-(void)playerDidWin;
//sets the difficultly to the correct lvl.
-(void)setPlayerDifficulty:(int) level;
-(void)getLevel;




@end
