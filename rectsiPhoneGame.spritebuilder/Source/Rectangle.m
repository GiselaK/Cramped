//
//  Rectangle.m
//  rectsiPhoneGame
//
//  Created by Gisela Kottmeier on 7/3/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "Rectangle.h"



@implementation Rectangle
BOOL stopGrowthRect=FALSE;
-(void)onEnter{
    [super onEnter];
    self.userInteractionEnabled = TRUE;
    //when this file is opened
    BOOL BeginGrowthRect=TRUE;
    //shape grows
    int red1 = arc4random() % 255;
    int green1 = arc4random() % 255;
    int blue1 = arc4random() % 255;
    self.color = [CCColor colorWithRed:red1/255.f green:green1/255.f blue:blue1/255.f];
    //make shape random color
//    self.positionInPoints = CGPointMake(0, 0);
    //Pick position
    if(BeginGrowthRect==TRUE){
        
        [NSTimer scheduledTimerWithTimeInterval:0.001
                                         target:self
                                       selector:@selector(growRect)
                                       userInfo:nil
                                        repeats:YES];
        //grown speed
        BeginGrowthRect=FALSE;
    }
    
}
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CCLOG(@"touching");
    //stop growing
}
float shapeSizeRect;
- (void)growRect{
    stopGrowthRect=FALSE;
    //Increase size during growth
    if(stopGrowthRect==FALSE){
        shapeSizeRect+=0.001;
        self.scale=shapeSizeRect;
    }
}
@end
