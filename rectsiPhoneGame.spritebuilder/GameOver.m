//
//  GameOver.m
//  rectsiPhoneGame
//
//  Created by Gisela Kottmeier on 7/16/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "GameOver.h"

extern int totalScoreVal;
@implementation GameOver{
    CCLabelTTF *_newHighScore;
}
-(void)onEnter{
    [super onEnter];
    _newHighScore.string = [NSString stringWithFormat:@"%d", totalScoreVal];
//    [MGWU submitHighScore:totalScoreVal byPlayer:@"ashu" forLeaderboard:@"defaultLeaderboard"];
}

@end
