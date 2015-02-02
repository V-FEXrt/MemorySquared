//
//  AreaWithButton.h
//
//
//  Created by Ashley Coleman on 1/14/14.
//  Copyright (c) 2014 Ashley Coleman. All rights reserved.

//  This class adds clickability to the areas

#import <UIKit/UIKit.h>
#import "AreaImage.h"
@interface AreaWithButton : UIButton
@property AreaImage *area;

-(void)changeColortoGreenWithTheme:(int)theme;
-(void)changeColortoRedWithTheme:(int)theme;
-(void)changeColortoBlueWithTheme:(int)theme;
-(void)changeColortoOrangeWithTheme:(int)theme;


- (id)initWithFrame:(CGRect)frame;

@end
