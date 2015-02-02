//
//  AreaWithButton.m
//  
//
//  Created by Ashley Coleman on 1/14/14.
//  Copyright (c) 2014 Ashley Coleman. All rights reserved.
//

#import "AreaWithButton.h"

@implementation AreaWithButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.area = [[AreaImage alloc]initWithFrame:CGRectMake(0, 0, frame.size.height, frame.size.width)];
        
        [self addSubview:self.area];
        
    }
    return self;
}

-(void)changeColortoGreenWithTheme:(int)theme{//changes the theme
    [self.area changeColortoGreen:theme];
}
-(void)changeColortoRedWithTheme:(int)theme{//changes the theme
    [self.area changeColortoRed:theme];
}
-(void)changeColortoBlueWithTheme:(int)theme{//changes the theme
        [self.area changeColortoBlue:theme];
    }
-(void)changeColortoOrangeWithTheme:(int)theme{//changes the theme
    [self.area changeColortoOrange:theme];
}


@end
