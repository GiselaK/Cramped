//
//  Triangle.m
//  rectsiPhoneGame
//
//  Created by Gisela Kottmeier on 7/8/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "Triangle.h"


@implementation Triangle
BOOL stopGrowth;
-(void)onEnter{
    [super onEnter];
    self.userInteractionEnabled = TRUE;
    //when this file is opened
    BOOL BeginGrowth=TRUE;
    //shape grows
    int red = arc4random() % 255;
    int green = arc4random() % 255;
    int blue = arc4random() % 255;
    self.color = [CCColor colorWithRed:red/255.f green:green/255.f blue:blue/255.f];
    //make shape random color
    //Pick position
    if(BeginGrowth==TRUE){
        stopGrowth=FALSE;
        [NSTimer scheduledTimerWithTimeInterval:0.001
                                         target:self
                                       selector:@selector(grow)
                                       userInfo:nil
                                        repeats:YES];
        //grown speed
        BeginGrowth=FALSE;
    }
    
}
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CCLOG(@"DONT GROWSS");
    stopGrowth=TRUE;
    //stop growing
}


- (void)grow{
    float shapeSize=0.0;
    //Increase size during growth
    if(stopGrowth==FALSE){
        shapeSize+=0.001;
        self.scale=shapeSize;
    }
}

@end
