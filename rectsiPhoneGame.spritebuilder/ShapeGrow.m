//
//  shapeGrow.m
//  rectsiPhoneGame
//
//  Created by Gisela Kottmeier on 7/9/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "ShapeGrow.h"
#import "MainScene.h"
@implementation ShapeGrow{
    BOOL stopGrowth;
    MainScene *_mainscene;
}

-(void)onEnter{
    [super onEnter];
    self.userInteractionEnabled = TRUE;
    CCLOG(@"newshapegrow");
    _mainscene = [[MainScene alloc]init];
    //when this file is opened
    BOOL BeginGrowth=TRUE;
    //shape grows
    //make shape random color
    //Pick position
    if(BeginGrowth==TRUE){
        [NSTimer scheduledTimerWithTimeInterval:0.002
                                         target:self
                                       selector:@selector(growRect)
                                       userInfo:nil
                                        repeats:YES];
        //grown speed
        BeginGrowth=FALSE;
    }
    
}
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CCLOG(@"touching");
    stopGrowth=TRUE;
    shapeSize=0.001;
        [_mainscene shouldspawn];
    stopGrowth=FALSE;
    
}
float shapeSize;
- (void)growRect{
    //Increase size during growth
    if(stopGrowth==FALSE){
        shapeSize+=0.001;
        self.scale=shapeSize;
    }
}

@end
