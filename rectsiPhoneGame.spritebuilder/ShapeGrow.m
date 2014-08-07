//
//  shapeGrow.m
//  rectsiPhoneGame
//
//  Created by Gisela Kottmeier on 7/9/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "ShapeGrow.h"
#import "MainScene.h"
extern BOOL playButtonOrNah;
extern BOOL gameEnd;
extern CGPoint touchLocation;
int stackedShapes;
@implementation ShapeGrow{
    BOOL gameStarted;
}

-(void)onEnter{
    [super onEnter];
    self.userInteractionEnabled = TRUE;
}
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    touchLocation = [touch locationInNode:self.mainscene];
    if (!playButtonOrNah && !gameEnd){
        [self.mainscene shapeSpawn];
        stackedShapes+=1;
    }
    else{
        stackedShapes=0;
    }
}


@end
