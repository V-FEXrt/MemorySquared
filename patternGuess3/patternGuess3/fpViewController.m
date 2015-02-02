//
//  fpViewController.m
//  
//
//  Created by Ashley Coleman on 12/9/13.
//  Copyright (c) 2013 Ashley Coleman. All rights reserved.
//

#import "fpViewController.h"

@interface fpViewController ()
-(void)showIntro;
@end

@implementation fpViewController
//global C variables

//rndPattern holds the 'random' pattern
int rndPattern[10];

//a parrell array that checks user input
bool correctGuess[10];

//value that represents the number of areas that will be shown
int numOfViewMod;

//speed that the patter show
double speed;


bool didWinGame = true;
bool secondPlay = false;


#pragma mark View Life Cycle
- (void)viewDidLoad{
    //set up save varible
    playerLevel* playersLevel = [[playerLevel alloc]init];
    
    //play music if not muted
    if (![playersLevel isMusicMuted]) {
        if (!fpSong) {
            NSURL * songLocation = [[NSBundle mainBundle]URLForResource:@"bgm1" withExtension:@"m4a"];
            
            fpSong = [[AVAudioPlayer alloc]initWithContentsOfURL:songLocation error:nil];
            fpSong.numberOfLoops = -1;
            
            }
    
        [fpSong play];
        }

    
    //Decided which device is being used for dynamic content
    int posyaddition,height,width;
    if([[UIScreen mainScreen] bounds].size.height > 560){
        height = 100;
        width = 100;
        posyaddition = 100;
    }else{
        height = 90;
        width = 90;
        posyaddition = 90;
    }
    
    //based on isiPhone5 set up views to the right size
    self.area0 = [[AreaWithButton alloc]initWithFrame:CGRectMake(55, 10, height, width)];
    self.area1 = [[AreaWithButton alloc]initWithFrame:CGRectMake(55, 10 + posyaddition, height, width)];
    self.area2 = [[AreaWithButton alloc]initWithFrame:CGRectMake(55, 10 + (posyaddition*2), height, width)];
    self.area3 = [[AreaWithButton alloc]initWithFrame:CGRectMake(55, 10 + (posyaddition*3), height, width)];
    self.area4 = [[AreaWithButton alloc]initWithFrame:CGRectMake(55, 10 + (posyaddition*4), height, width)];
    self.area5 = [[AreaWithButton alloc]initWithFrame:CGRectMake(165, 10, height, width)];
    self.area6 = [[AreaWithButton alloc]initWithFrame:CGRectMake(165, 10 + posyaddition, height, width)];
    self.area7 = [[AreaWithButton alloc]initWithFrame:CGRectMake(165, 10 + (posyaddition*2), height, width)];
    self.area8 = [[AreaWithButton alloc]initWithFrame:CGRectMake(165, 10 + (posyaddition*3), height, width)];
    self.area9 = [[AreaWithButton alloc]initWithFrame:CGRectMake(165, 10 + (posyaddition*4), height, width)];
    
    //set up array with the views
    self.viewArray = [[NSArray alloc]initWithObjects:self.area0,self.area1,self.area2,self.area3,self.area4,self.area5,self.area6,self.area7,self.area8,self.area9, nil];
    

    for (int i = 0; i < 10; i++) {
        self.tempView = self.viewArray[i];
        //connect to click funtion and set tag
        [self.tempView addTarget:self action:@selector(squareClickCheck:) forControlEvents:UIControlEventTouchUpInside];
        self.tempView.tag = i;
        //add views to storyboard
        [self.entireView insertSubview:self.tempView atIndex:0];
        self.tempView.hidden = YES;
        self.tempView = nil;
        
        //set up the random patter from 0-9
        rndPattern[i] = i;
        
        //assume the wrong answer is given
        correctGuess[i] = false;
    }

    //more varialbe iniation
    self.count = 0;
    
    //0:boring circle
    //1:basketball
    //2:football
    //3:tennis
    self.imageCount = 0;
    
    //set up the labels to show the default value for the steppers
    double temp = self.introSpdStepper.value;
    speed = temp;
    self.introSpdLbl.text = [NSString stringWithFormat:@"%.1f",temp];
    
    temp = self.introSquareStepper.value;
    numOfViewMod = temp;
    self.introSquareLbl.text = [NSString stringWithFormat:@"%1.0f",temp];
    
    self.introThemeLbl.text = [NSString stringWithFormat:@"Circles"];
    
    
    //limit themes based on level in adventure mode
    int thePlayersLevel = [playersLevel returnLevel];
    switch (thePlayersLevel) {
        case 0:
            self.introThemeStepper.maximumValue = 0;
            break;
        case 1:
        case 2:
        case 3:
            self.introThemeStepper.maximumValue = 1;
            break;
        case 4:
        case 5:
        case 6:
            self.introThemeStepper.maximumValue = 2;
            break;
        case 7:
        case 8:
        case 9:
            self.introThemeStepper.maximumValue = 3;
            break;
        //need a case for spaceship theme
        case 10:
        case 11:
            self.introThemeStepper.maximumValue = 4;
            break;
        default:
            self.introThemeStepper.maximumValue = 2;
            break;
            
    }

    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

#pragma mark Functions That Change Settings From Stepper

- (IBAction)addToSpeedStepper:(id)sender { //increases the default speed
    double temp = self.introSpdStepper.value;
    speed = temp;
    speed = 1/speed;
    self.introSpdLbl.text = [NSString stringWithFormat:@"%.1f",temp];
    
}

- (IBAction)addToSquareStepper:(id)sender { //increase number of ares
    int temp = self.introSquareStepper.value;
    numOfViewMod = temp;
    self.introSquareLbl.text = [NSString stringWithFormat:@"%d",temp];
}

- (IBAction)addToThemeStepper:(id)sender { //changes theme
    NSArray *x = [[NSArray alloc]initWithObjects:@"Circles", @"Basketball", @"Football", @"Tennis", @"SpaceShip", nil];
    int temp = self.introThemeStepper.value;
    self.imageCount = temp;
    self.introThemeLbl.text = [NSString stringWithFormat:@"%@", x[temp]];

}

#pragma mark Functions That Show Patterns

- (IBAction)runShowSequence:(id)sender {//temporary start to the game
    //if the game has been played more than once
    //stop user interaction until time
    self.entireView.userInteractionEnabled = false;
    
    if (secondPlay) {
        //stop user interaction until time
        self.entireView.userInteractionEnabled = false;
        
        for (int i = 0; i <10; i++) {
            //change back to false
            correctGuess[i] = false;
        }
    }
    
    //hide level selector until game over
    self.introView.hidden=YES;
    [self setLevel];
    [self makeSequence];
    
    
}
-(void)setLevel{//makes only the right number of areas visible
    //make all views visible
    self.area9.hidden = YES;
    self.area8.hidden = YES;
    self.area7.hidden = YES;
    self.area6.hidden = YES;
    self.area5.hidden = YES;
    self.area4.hidden = YES;
    self.area3.hidden = YES;
    self.area2.hidden = YES;
    self.area1.hidden = YES;
    self.area0.hidden = YES;
    
    
    //hide views that should not be shown
    for (int i = 0; i < numOfViewMod; i++) {
        self.tempView = self.viewArray[i];
        [self.tempView changeColortoBlueWithTheme:self.imageCount];
        self.tempView.hidden = NO;
        self.tempView = Nil;
        
    }
    
}

-(void)makeSequence{
    //reset the variables in rndPattern
    if (secondPlay) {
        //loop to iniaite variables (0-9)
        for (int i = 0; i<10; i++) {
            rndPattern[i] = i;
            correctGuess[i] = false;
        }
    }

    
    //shuffles the array so that there are no repeates of values
    for (int i = 0; i < 25; i++) {//loop runs 20 times to answer for dups
        int a = arc4random() %  numOfViewMod;//randomly select two spots to switch
        int b = arc4random() % numOfViewMod;
        
        int temp = rndPattern[a];//temp equals spot a
        rndPattern[a] = rndPattern[b];//spot a equals spot b
        rndPattern[b] = temp;// spot b equals spot a
        
    }
    
    //timer that runs every 'speed' to show the blocks with a delay
    if (!self.timer) {
      self.timer = [NSTimer scheduledTimerWithTimeInterval:speed target:self selector:@selector(showSequence) userInfo:Nil repeats:YES];
    }

    
}



-(void)showSequence{//showSequence needs to disable button clicks and then reinable them
    int tempForCount;//used for removal of blue color
    
    //don't want to run this before it has shown a blue view
    if (self.count > 0) {
    tempForCount = self.count - 1;
    
    //set tempView to the view, change the views color, then remove tempView for saftey
    self.tempView = self.viewArray[rndPattern[tempForCount]];
        [self.tempView changeColortoBlueWithTheme:self.imageCount];
    self.tempView = nil;
    }
    
    //don't want to run the last time, last time is only so can remove the last blue
    if (self.count < numOfViewMod) {
        
        //set tempView to the view, change the views color, then remove tempView for saftey
        self.tempView = self.viewArray[rndPattern[self.count]];
        [self.tempView changeColortoOrangeWithTheme:self.imageCount];
        self.tempView = nil;
    }

        self.count++;//adds 1 to count so that it will show the next block when timer runs again
    
    
        if (self.count >= (numOfViewMod+1)) {//if count has reached 10 stop the timer and reset all the stuffs

            
            //reset background colors
            for (int i = 0; i< 10; i++) {
                self.tempView = self.viewArray[i];
                [self.tempView changeColortoBlueWithTheme:self.imageCount];
                self.tempView = nil;
            }
            
            //destroy timer
            [self.timer invalidate];
            self.timer = nil;
            
            //reset count
            self.count = 0;

            //allow the user to do stuff again
                self.entireView.userInteractionEnabled = true;
        }
}


#pragma mark Functions That Analized User Gameplay

- (void)squareClickCheck:(AreaWithButton*)sender {//when the user clicks an area it runs this code, which sets up checking
    self.tempView = sender;
    self.senderValue = (int)self.tempView.tag;
    [self playGame];
    self.checkCount++;
}

-(void)playGame{// compares entered to actual pattern
    if (self.checkCount < numOfViewMod) {//don't want to break the array, so has to be less than 'numOfViewMod'
        
        //if user clicks the right button
        if (rndPattern[self.checkCount] == self.senderValue) {
            
          //shows green block and destroy tempView
            correctGuess[self.senderValue] = true;
            self.tempView = self.viewArray[self.senderValue];
            [self.tempView changeColortoGreenWithTheme:self.imageCount];
            self.tempView = nil;
        }
        else{//user clicks the wrong button
            
            //show red block
            self.tempView = self.viewArray[self.senderValue];
            [self.tempView changeColortoRedWithTheme:self.imageCount];
            self.tempView = nil;
       }
    }
    
    //checks if this is the last click/area
    if (self.checkCount == numOfViewMod-1){
        
        //if and of 'correctGuess' are false then the user lost
        for (int i = 0; i < numOfViewMod; i++) {
            if (!correctGuess[i]) {//make sure all incorrect blocks are shown red
                self.tempView = self.viewArray[i];
                [self.tempView changeColortoRedWithTheme:self.imageCount];
                self.tempView = nil;
                didWinGame = false;
            }
        }
        //if game is played again it is for another time
        secondPlay = true;
        
        //run a timer that waits for a second before showing the intro screen again
        if (!self.timer) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showIntro) userInfo:Nil repeats:NO];
        }

                
        //if it gets to the top jump back down
        if (numOfViewMod == 11) {
            numOfViewMod= 2;
        }
        
    }

}

#pragma mark Prepare Segue and Show Intro

-(void)showIntro{//opens the menu for setting level
    //destroy timer for reuse
    [self.timer invalidate];
    self.timer = nil;
    
    //unhide the view
    self.introView.hidden = NO;
    }


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{//stops music to change scenes
    [fpSong stop];
}

@end
