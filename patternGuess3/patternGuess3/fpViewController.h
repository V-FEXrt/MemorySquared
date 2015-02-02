//
//  fpViewController.h
//
//
//  Created by Ashley Coleman on 12/9/13.
//  Copyright (c) 2013 Ashley Coleman. All rights reserved.

//This class handles the free play mode, it is similar to adventure mode, but it allows the user to select diffucultly.

#import "AreaWithButton.h"
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "playerLevel.h"

@interface fpViewController : UIViewController
//music
{
    AVAudioPlayer *fpSong;
}


//connection to the entire view so we can disable interaction
@property (strong, nonatomic) IBOutlet UIView *entireView;

//start button to start
@property (strong, nonatomic) IBOutlet UIButton *startButton;


//timer to time
@property (nonatomic, strong) NSTimer *timer;

//count for array
@property int count;

//each buttonFunction sends a value to tell which button was clicked
@property int senderValue;

//second counter for checking
@property int checkCount;

//count for image theme
@property int imageCount;

//array of the image views
@property NSArray* viewArray;

//temp variables for iterating through array
@property AreaWithButton* tempView;

//connections to all the intro properties
@property (strong, nonatomic) IBOutlet UIView *introView;
@property (strong, nonatomic) IBOutlet UILabel *introSpdLbl;
@property (strong, nonatomic) IBOutlet UILabel *introSquareLbl;
@property (strong, nonatomic) IBOutlet UIStepper *introSpdStepper;
@property (strong, nonatomic) IBOutlet UIStepper *introSquareStepper;
@property (strong, nonatomic) IBOutlet UILabel *introThemeLbl;
@property (strong, nonatomic) IBOutlet UIStepper *introThemeStepper;

//The Views
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

//functions ran when steppers are pressed
- (IBAction)addToSpeedStepper:(id)sender;
- (IBAction)addToSquareStepper:(id)sender;
- (IBAction)addToThemeStepper:(id)sender;

//All other game functions

//makes the random pattern
-(void)makeSequence;
//starts the game when the user clicks start
- (IBAction)runShowSequence:(id)sender;
//shows the pattern
-(void)showSequence;
//runs each time user clicks a button checks if it was the right click
-(void)playGame;
//show/hides the views depending on the number of views selected
-(void)setLevel;






@end
