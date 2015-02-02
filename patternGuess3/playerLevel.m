//
//  playerLevel.m
//  
//
//  Created by Ashley Coleman on 1/23/14.
//  Copyright (c) 2014 Ashley Coleman. All rights reserved.
//


#import "playerLevel.h"

@interface playerLevel()
@property (nonatomic,strong) NSDictionary *myDictionary;
@property (nonatomic,strong) NSMutableDictionary *mutableDict;
@property (nonatomic,strong) NSNumber *numOfValue;
@property int intValue;
@property int count;
@end

@implementation playerLevel
-(id)init{
    self = [super init];
    if (self) {
        
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
        NSString * documentsDir = paths[0];
        self.filePath = [documentsDir stringByAppendingString:@"save.dat"];
        
        
        self.myDictionary = [[NSDictionary alloc] initWithContentsOfFile:self.filePath];
        if (self.myDictionary == NULL) {
            self.filePath = [[NSBundle mainBundle]pathForResource:@"list" ofType:@"plist"];
            self.myDictionary = [NSDictionary dictionaryWithContentsOfFile:self.filePath];
            self.filePath = [documentsDir stringByAppendingString:@"save.dat"];
            [self.myDictionary writeToFile:self.filePath atomically:YES];
            self.myDictionary = [NSDictionary dictionaryWithContentsOfFile:self.filePath];
        }
        
        
        
        self.mutableDict = [[NSMutableDictionary alloc]init];
        self.mutableDict = [self.myDictionary mutableCopy];
    }
    return self;
}
-(int)returnLevel{ //returns the players level
    self.myDictionary = [NSDictionary dictionaryWithContentsOfFile:self.filePath];
    self.mutableDict = [self.myDictionary mutableCopy];
    self.numOfValue = [self.mutableDict objectForKey:@"level"];
    self.intValue = [self.numOfValue intValue];
    return self.intValue;
}
-(void)updateLevel{ //increases the players level by 1

    self.myDictionary = [NSDictionary dictionaryWithContentsOfFile:self.filePath];
    self.mutableDict = [self.myDictionary mutableCopy];
    self.numOfValue = [self.mutableDict objectForKey:@"level"];
    self.intValue = [self.numOfValue intValue];
    self.intValue++;
    self.numOfValue = [NSNumber numberWithInt:self.intValue];
    [self.mutableDict setObject:self.numOfValue forKey:@"level"];
    NSLog(@"Muta:%@", self.mutableDict);
    [self.mutableDict writeToFile:self.filePath atomically:YES];

}
-(void)resetLevel{ //once all levels are complete player can reset to level 0
    self.myDictionary = [NSDictionary dictionaryWithContentsOfFile:self.filePath];
    self.mutableDict = [self.myDictionary mutableCopy];
    self.numOfValue = [self.mutableDict objectForKey:@"level"];
    self.intValue = [self.numOfValue intValue];
    self.intValue = 0;
    self.numOfValue = [NSNumber numberWithInt:self.intValue];
    [self.mutableDict setObject:self.numOfValue forKey:@"level"];
    [self.mutableDict writeToFile:self.filePath atomically:YES];
    
}
-(BOOL)isMusicMuted{ //bool if user wants music
    self.myDictionary = [NSDictionary dictionaryWithContentsOfFile:self.filePath];
    self.mutableDict = [self.myDictionary mutableCopy];
    self.mutableDict = [self.myDictionary mutableCopy];
    self.numOfValue = [self.mutableDict objectForKey:@"sound"];
    self.intValue = [self.numOfValue intValue];
    

    if (self.intValue == 1) {
        return TRUE;
    }
    else{
        return FALSE;
    }
}
-(void)changeMusicState{ //mutes, or unmutes music
    self.myDictionary = [NSDictionary dictionaryWithContentsOfFile:self.filePath];
    self.mutableDict = [self.myDictionary mutableCopy];
    
    self.count++;
    self.numOfValue = [self.mutableDict objectForKey:@"sound"];
    self.intValue = [self.numOfValue intValue];
    self.intValue = self.count % 2;
    
    
    self.numOfValue = [NSNumber numberWithInt:self.intValue];
    [self.mutableDict setObject:self.numOfValue forKey:@"sound"];
    [self.mutableDict writeToFile:self.filePath atomically:YES];
    
}
-(BOOL)returnIntroState{//bool should show intro?
    self.myDictionary = [NSDictionary dictionaryWithContentsOfFile:self.filePath];
    self.mutableDict = [self.myDictionary mutableCopy];
    self.numOfValue = [self.mutableDict objectForKey:@"intro"];
    self.intValue = [self.numOfValue intValue];
    if (self.intValue == 0) {
        return TRUE;
    }else{
        return FALSE;
    }
    }
-(void)updateIntroStateAsHide:(BOOL)hide{//runs the intro scene on load of app, not on homescreen return
    self.myDictionary = [NSDictionary dictionaryWithContentsOfFile:self.filePath];
    self.mutableDict = [self.myDictionary mutableCopy];
    if (hide) {
        
        self.intValue = 1;
    }else{
        
        self.intValue = 0;
    }
    
    
    self.numOfValue = [NSNumber numberWithInt:self.intValue];
    [self.mutableDict setObject:self.numOfValue forKey:@"intro"];
    [self.mutableDict writeToFile:self.filePath atomically:YES];
}


@end
