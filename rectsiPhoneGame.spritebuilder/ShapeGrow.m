//
//  shapeGrow.m
//  rectsiPhoneGame
//
//  Created by Gisela Kottmeier on 7/9/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "ShapeGrow.h"
#import "MainScene.h"
extern int pickShape;
extern BOOL allowUpdates;
extern BOOL checkCollision;
extern BOOL playButton;
@implementation ShapeGrow{
    BOOL stopGrowth;
    BOOL gameStarted;
//    MainScene* _mainscene;
}

-(void)onEnter{
    [super onEnter];
//    _mainscene= [[MainScene alloc]init];
    self.userInteractionEnabled = TRUE;
    //when this file is opened
    //shape grows
    //make shape random color
    //Pick position

        if(allowUpdates==TRUE){
            [self schedule:@selector(growRect) interval:0.05];        //grown speed
        }
    
}
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    if (!playButton){
        stopGrowth=TRUE;
        checkCollision=TRUE;
        [self.mainscene shapeSpawn];
    }
    else{
        playButton=FALSE;
    }
    
}
- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    checkCollision=FALSE;
}
- (void)growRect{
    //Increase size during growth
        if(stopGrowth==FALSE){
            if(pickShape==1){
                [self.mainscene updateRect];
            }
            else{
                [self.mainscene updateTri];
            }
        }
    
}


@end
