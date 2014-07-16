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
    int rotationAngle;

//    MainScene* _mainscene;
}

-(void)onEnter{
    [super onEnter];
//    _mainscene= [[MainScene alloc]init];
    self.userInteractionEnabled = TRUE;
    //when this file is opened
    BOOL BeginGrowth=TRUE;
    rotationAngle=1;
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

    stopGrowth=TRUE;
    shapeSize=0.001;
    [self.mainscene shapeSpawn];
    
}
float shapeSize;
- (void)growRect{
    //Increase size during growth
    if(stopGrowth==FALSE){
//        self.color=[CCColor redColor];
//        shapeSize+=0.001;
//        self.scale=shapeSize;
        self.rotation+=0.5;
        if (self.rotation>360){
            self.rotation=1;
        }
        
    }
}


@end
