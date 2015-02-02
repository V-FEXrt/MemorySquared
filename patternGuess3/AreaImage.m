//
//  AreaImage.m
//  
//
//  Created by Ashley Coleman on 1/14/14.
//  Copyright (c) 2014 Ashley Coleman. All rights reserved.
//

#import "AreaImage.h"

@implementation AreaImage

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //set up image variables
        self.circleRight = [UIImage imageNamed:@"circleRight.png"];
        self.circleWrong = [UIImage imageNamed:@"circleWrong.png"];
        self.circleShow = [UIImage imageNamed:@"circleShow.png"];
        self.circleDefault = [UIImage imageNamed:@"circleDefault.png"];
        
        self.basketballRight = [UIImage imageNamed:@"basketballRight.png"];
        self.basketballWrong = [UIImage imageNamed:@"basketballWrong.png"];
        self.basketballShow = [UIImage imageNamed:@"basketballShow.png"];
        self.basketballDefault = [UIImage imageNamed:@"basketballDefault.png"];
        
        self.footballRight = [UIImage imageNamed:@"footballRight.png"];
        self.footballWrong = [UIImage imageNamed:@"footballWrong.png"];
        self.footballShow = [UIImage imageNamed:@"footballShow.png"];
        self.footballDefault = [UIImage imageNamed:@"footballDefault.png"];
        
        self.tennisRight = [UIImage imageNamed:@"tennisRight"];
        self.tennisWrong = [UIImage imageNamed:@"tennisWrong"];
        self.tennisShow = [UIImage imageNamed:@"tennisShow"];
        self.tennisDefault = [UIImage imageNamed:@"tennisDefault"];
        
        self.spaceShipRight = [UIImage imageNamed:@"spaceRight"];
        self.spaceShipWrong = [UIImage imageNamed:@"spaceWrong"];
        self.spaceShipShow = [UIImage imageNamed:@"spaceShow"];
        self.spaceShipDefault = [UIImage imageNamed:@"spaceDefault"];
        
        
        //set up image arrays
        self.greenImage = [[NSArray alloc]initWithObjects:self.circleRight, self.basketballRight, self.footballRight, self.tennisRight, self.spaceShipRight, nil];
        self.redImage = [[NSArray alloc]initWithObjects:self.circleWrong, self.basketballWrong, self.footballWrong, self.tennisWrong, self.spaceShipWrong, nil];
        self.orangeImage = [[NSArray alloc]initWithObjects:self.circleShow, self.basketballShow, self.footballShow, self.tennisShow,self.spaceShipShow, nil];
        self.blueImage = [[NSArray alloc]initWithObjects:self.circleDefault,self.basketballDefault, self.footballDefault, self.tennisDefault, self.spaceShipDefault, nil];
        

        self.image = self.blueImage[0];
        
        //NSLog(@"green: %@\nRed:%@\norange:%@\nblue%@",self.greenImage, self.redImage, self.orangeImage, self.blueImage);
    }
    return self;
}


-(void)changeColortoGreen:(int)themeNum{//changes the theme
    self.image = self.greenImage[themeNum];
}
-(void)changeColortoRed:(int)themeNum{//changes the theme
    self.image = self.redImage[themeNum];
}
-(void)changeColortoBlue:(int)themeNum{//changes the theme
    self.image = self.blueImage[themeNum];
}
-(void)changeColortoOrange:(int)themeNum{//changes the theme
    self.image = self.orangeImage[themeNum];
}


@end
