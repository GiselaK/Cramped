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
}
-(void)onEnter{
    [super onEnter];
    self.userInteractionEnabled=TRUE;
}
- (void)onPress{
    if(playButtonOrNah){
        [self.mainscene playClicked];
    }
}
@end
