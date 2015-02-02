//
//  advViewController.m
//
//
//  Created by Ashley Coleman on 1/15/14.
//  Copyright (c) 2014 Ashley Coleman. All rights reserved.
//

#import "advViewController.h"




@implementation advViewController
//global C variables

//rndPattern holds the 'random' pattern
int rndPattern[10];

//a parrell array that checks user input
bool correctGuess[10];

//value that represents the number of areas that will be shown
int numOfViewMod;

//speed that the patter show
double speed;


#pragma mark View Life Cycle
- (void)viewDidLoad
{
    //set up save variable
    self.playersLevel = [[playerLevel alloc]init];
    
    //if audio not muted set it up and play
    if (![self.playersLevel isMusicMuted]) {
    
        if (!advSong) {
            NSURL * songLocation = [[NSBundle mainBundle]URLForResource:@"bgm" withExtension:@"m4a"];
            
            advSong = [[AVAudioPlayer alloc]initWithContentsOfURL:songLocation error:nil];
            //loops forever
            advSong.numberOfLoops = -1;
        }
        
        [advSong play];
    }

    
    //0:boring circle
    //1:basketball
    //2:football
    //3:tennis
    
    //set up names variable
    self.themeNames = [[NSArray alloc]initWithObjects:@"Boring Circle", @"Basketball", @"Football", @"Tennis", @"Space Ship", nil];
    
    
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
    //which click are we on variable
    self.count = 0;
    //if more than one game is played it ajusts code
    self.secondPlay = false;
    //assume over all they won
    self.didWinGame2 = true;

    //run getlvl to set difficulty for player
    [self getLevel];
    
    [super viewDidLoad];

}

#pragma mark Functions To Show Pattern

- (void)runShowSequence {//start to the game
   
    //stop user interaction until while showing pattern
    self.entireView.userInteractionEnabled = false;
    
    //if second play reset variables
    if (self.secondPlay) {
        for (int i = 0; i <10; i++) {
            //change back to true
            self.didWinGame2 = true;
            rndPattern[i] = i;
            correctGuess[i] = false;
            self.tempView = self.viewArray[i];
            [self.tempView changeColortoBlueWithTheme:self.imageCount];
            self.tempView = nil;
            
        }
        self.checkCount = 0;
    }
    
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

    //shuffles the array so that there are no repeates of values
    for (int i = 0; i < 25; i++) {
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



-(void)showSequence{//this function is called 'numbOfViewMod' times every 'speed' it changes the images to match the pattern
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

#pragma mark Functions That Analize User Input

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
                self.didWinGame2 = false;
            }
        }
        
        
        //Start level updating process
        self.secondPlay = true;
        
        [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(playerDidWin) userInfo:Nil repeats:NO];
        
    }
    
}

-(void)playerDidWin{ //if game is won start next level, if lost play again
    if (self.didWinGame2) {
        //update difficulty via function
        [self.playersLevel updateLevel];
        [self getLevel];
    }
    else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"You will have to attempt this level again" delegate:self cancelButtonTitle:@"Quit" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}


#pragma mark Functions that Iniate Difficulty
-(void)getLevel{//get the level and call set up.
    int level = [self.playersLevel returnLevel];
    [self setPlayerDifficulty:level];
}
-(void)setPlayerDifficulty:(int)level{ //all level settings are defined by your current level

    UIAlertView * alert;
    NSString* message;
    switch (level) {
        
        case 0:
            self.imageCount = 0;
            speed = 1;
            numOfViewMod = 2;
            alert = [[UIAlertView alloc]initWithTitle:@"Adventure Mode: Level 1" message:@"Prepare for a series of challenges...repeat the pattern presented to you" delegate:self cancelButtonTitle:@"Quit" otherButtonTitles:@"Ok", nil];
                break;
        case 1:
            self.imageCount = 1;
            speed = 1.5;
            numOfViewMod = 3;
            message = [NSString stringWithFormat:@"Theme unlocked: %@",self.themeNames[1]];
            alert = [[UIAlertView alloc]initWithTitle:@"Level 2" message: message delegate:self cancelButtonTitle:@"Quit" otherButtonTitles:@"Ok", nil];
            break;
        case 2:
            self.imageCount = 1;
            speed = 1.5;
            numOfViewMod = 4;
            alert = [[UIAlertView alloc]initWithTitle:@"Level 3" message: @"Congrats! You have completed level 2" delegate:self cancelButtonTitle:@"Quit" otherButtonTitles:@"Ok", nil];
            break;
        case 3:
            self.imageCount = 1;
            speed = 1;
            numOfViewMod = 5;
            alert = [[UIAlertView alloc]initWithTitle:@"Level 4" message: @"This level gets a little faster" delegate:self cancelButtonTitle:@"Quit" otherButtonTitles:@"Ok", nil];
            break;
        case 4:
            self.imageCount = 2;
            speed = 1;
            numOfViewMod = 6;
            message = [NSString stringWithFormat:@"Theme unlocked: %@",self.themeNames[2]];
            alert = [[UIAlertView alloc]initWithTitle:@"Level 5" message: message delegate:self cancelButtonTitle:@"Quit" otherButtonTitles:@"Ok", nil];
            break;
        case 5:
            self.imageCount = 2;
            speed =.8;
            numOfViewMod = 6;
            alert = [[UIAlertView alloc]initWithTitle:@"Level 6" message: @"You have completed level 5" delegate:self cancelButtonTitle:@"Quit" otherButtonTitles:@"Ok", nil];
            break;
        case 6:
            self.imageCount = 2;
            speed =.8;
            numOfViewMod = 7;
            alert = [[UIAlertView alloc]initWithTitle:@"Level 7" message: @"You have completed level 6" delegate:self cancelButtonTitle:@"Quit" otherButtonTitles:@"Ok", nil];
            break;
        case 7:
            self.imageCount = 3;
            speed =.8;
            numOfViewMod = 8;
            message = [NSString stringWithFormat:@"Theme unlocked: %@",self.themeNames[3]];
            alert = [[UIAlertView alloc]initWithTitle:@"Level 8" message: message delegate:self cancelButtonTitle:@"Quit" otherButtonTitles:@"Ok", nil];
            break;
        case 8:
            self.imageCount = 3;
            speed =.6;
            numOfViewMod = 8;
            alert = [[UIAlertView alloc]initWithTitle:@"Level 9" message: @"You have completed level 8" delegate:self cancelButtonTitle:@"Quit" otherButtonTitles:@"Ok", nil];
            break;
        case 9:
            self.imageCount = 3;
            speed =.8;
            numOfViewMod = 9;
            alert = [[UIAlertView alloc]initWithTitle:@"Level 10" message: @"You have completed level 9" delegate:self cancelButtonTitle:@"Quit" otherButtonTitles:@"Ok", nil];
            break;
        case 10:
            self.imageCount = 3;
            speed =.7;
            numOfViewMod = 9;
            alert = [[UIAlertView alloc]initWithTitle:@"Level 11" message: @"You have completed level 10" delegate:self cancelButtonTitle:@"Quit" otherButtonTitles:@"Ok", nil];
            break;
        case 11:
            self.imageCount = 4;
            speed = .5;
            numOfViewMod = 6;
            message = [NSString stringWithFormat:@"Theme unlocked: %@",self.themeNames[4]];
            alert = [[UIAlertView alloc]initWithTitle:@"Level 12" message: message delegate:self cancelButtonTitle:@"Quit" otherButtonTitles:@"Ok", nil];
            break;
            
        
            
        default:
            self.imageCount = 4;
            speed = .333;
            numOfViewMod = 10;
            alert = [[UIAlertView alloc]initWithTitle:@"Default" message: @"There are no more availble levels at this time" delegate:self cancelButtonTitle:@"Quit" otherButtonTitles:@"Ok", nil];
            break;
    }
    
    [alert show];
    
    
}

#pragma mark Alert Delegate and Prepare for Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{//stops music when level is quit
    [advSong stop];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{//if okay, start next level, else quit
    if (buttonIndex == 1) {
        [self setLevel];
        [self runShowSequence];
    }
    if (buttonIndex == 0) {
        //NSLog(@"Quit");
        [self performSegueWithIdentifier:@"returnToMainSeg" sender:self];
    }
}
@end
