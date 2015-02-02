//
//  mainViewController.m
//
//
//  Created by Ashley Coleman on 1/23/14.
//  Copyright (c) 2014 Ashley Coleman. All rights reserved.
//

#import "mainViewController.h"

@interface mainViewController ()
//access to saving class
@property playerLevel* playersLevel;

//two image choices for self.imageViewforSound
@property UIImage *muted;
@property UIImage *notMuted;

//time for intro to be displayed
@property NSTimer* timer;
@end

@implementation mainViewController
int countForIntro = 0;

#pragma mark View Life Cycle
- (void)viewDidLoad
{

    
    self.playersLevel = [[playerLevel alloc]init];
    
    
    //Use multithreading and GCD to manage speed
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.entireView.hidden=YES;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showIntroScene) userInfo:Nil repeats:YES];
        //change state
        [self.playersLevel updateIntroStateAsHide:TRUE];
    });

    
    
    
    
    self.muted = [UIImage imageNamed:@"muted.png"];
    self.notMuted =[UIImage imageNamed:@"notMuted.png"];
    
    //check if music is muted, if not set up and play, otherwise ignore.
    if (![self.playersLevel isMusicMuted]) {
        if (!introSong) {
            NSURL * songLocation = [[NSBundle mainBundle]URLForResource:@"in to the light" withExtension:@"mp3"];
            
            introSong = [[AVAudioPlayer alloc]initWithContentsOfURL:songLocation error:nil];
            
            //play music on repeat
            introSong.numberOfLoops = -1;
        }
        
        [introSong play];
        self.imageViewforSound.image = self.notMuted;
      }
    
    else{
        self.imageViewforSound.image = self.muted;
    }
    
    [super viewDidLoad];
}
#pragma mark Audio Delegation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //stop music when the view is about to change
    [introSong stop];
}
- (IBAction)muteIsPressed:(id)sender {
    //inverse music from muted to not, or vise versa
    [self.playersLevel changeMusicState];
    
    //if changed to muted stop the music and change pic
    if ([self.playersLevel isMusicMuted]) {
        [introSong stop];
        self.imageViewforSound.image = self.muted;
    }else{ //unmuted so start music and change pic
        [introSong play];
        self.imageViewforSound.image = self.notMuted;
    }
}

#pragma mark Intro Animation Scene
-(void)showIntroScene{
    switch (countForIntro) {
        case 0:
            //first image
            self.introScene.image = [UIImage imageNamed:@"Cole.png"];
            break;
        case 1:
            //second image
            self.introScene.image = [UIImage imageNamed:@"Ster.png"];
            break;
        case 2:
            //third image
            self.introScene.image = [UIImage imageNamed:@"Productions.png"];
            break;
        case 3:
            self.introScene.image = [UIImage imageNamed:@"VFEX"];
            break;
        case 4:
            break;
        case 5:
            //no images
            //show entireview
            //destroy timer
            self.introScene.image = Nil;
            self.entireView.hidden = NO;
            [self.timer invalidate];
            self.timer =Nil;
            
        default:
            break;
    }
    countForIntro++;
    
}

#pragma mark iAd Degelate Methods
-(void)bannerViewWillLoadAd:(ADBannerView *)banner{ //shows adds
    [UIView beginAnimations:Nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:1];
    [UIView commitAnimations];
}
-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{//hides adds when they are not avaible
    [UIView beginAnimations:Nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:0];
    [UIView commitAnimations];
}
#pragma mark alertView Degelate Methods
- (IBAction)optionButtonClicked:(id)sender {//asks to reset level
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Reset Level" message:@"Would You Like To Restart at Level 1 for Adventure Mode?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{//resets level
    if (buttonIndex == 1) {
        //reset lvl
        [self.playersLevel resetLevel];
        
    }
    
}

@end
