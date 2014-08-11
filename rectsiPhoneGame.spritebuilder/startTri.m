//
//  startTri.m
//  rectsiPhoneGame
//
//  Created by Gisela Kottmeier on 7/28/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "startTri.h"
#import "MainScene.h"
extern BOOL playButtonOrNah;
@implementation startTri{
    CCSprite *_startTri1;
    CCSprite *_startTri2;
    CCSprite *_startTri3;
}
-(void)onEnter{
    [super onEnter];
//    _startTri1.color=[CCColor greenColor];
//    _startTri2.color=[CCColor greenColor];
//    _startTri3.color=[CCColor greenColor];
    self.userInteractionEnabled=TRUE;
}
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    if(playButtonOrNah){
        [self.mainscene playClicked];
    }
}
@end
