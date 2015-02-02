//
//  playerLevel.h
//  
//
//  Created by Ashley Coleman on 1/23/14.
//  Copyright (c) 2014 Ashley Coleman. All rights reserved.



//  This class handles all data saving interaction

#import <Foundation/Foundation.h>

@interface playerLevel : NSObject
@property (nonatomic, strong)NSString* filePath;

-(int)returnLevel;
-(void)updateLevel;
-(void)resetLevel;
-(BOOL)isMusicMuted;
-(void)changeMusicState;
-(BOOL)returnIntroState;
-(void)updateIntroStateAsHide:(BOOL)hide;

@end
