//
//  AreaImage.h
//  
//
//  Created by Ashley Coleman on 1/14/14.
//  Copyright (c) 2014 Ashley Coleman. All rights reserved.

//This class is the object with easy image changing functionality.

#import <UIKit/UIKit.h>

@interface AreaImage : UIImageView
//image variables
//function for setting images
@property NSArray *greenImage;
@property NSArray *redImage;
@property NSArray *blueImage;
@property NSArray *orangeImage;

//images
//circle theme
@property UIImage *circleDefault;
@property UIImage *circleRight;
@property UIImage *circleShow;
@property UIImage *circleWrong;
//bball theme
@property UIImage *basketballDefault;
@property UIImage *basketballRight;
@property UIImage *basketballShow;
@property UIImage *basketballWrong;
//fball theme
@property UIImage *footballDefault;
@property UIImage *footballRight;
@property UIImage *footballShow;
@property UIImage *footballWrong;
//tennis theme
@property UIImage *tennisDefault;
@property UIImage *tennisRight;
@property UIImage *tennisShow;
@property UIImage *tennisWrong;
//spaceShip Theme
@property UIImage *spaceShipDefault;
@property UIImage *spaceShipRight;
@property UIImage *spaceShipShow;
@property UIImage *spaceShipWrong;

-(void)changeColortoGreen:(int)themeNum;
-(void)changeColortoRed:(int)themeNum;
-(void)changeColortoBlue:(int)themeNum;
-(void)changeColortoOrange:(int)themeNum;
@end
