//
//  GameOverLoose.m
//  Cramped
//
//  Created by Gisela Kottmeier on 8/6/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "GameOverLoose.h"

extern int highScore;
extern int totalScoreVal;
@implementation GameOverLoose{
    CCLabelTTF *_totalScore;
    CCLabelTTF *_highScore;
    CCLabelTTF *_tipMessage;
}

- (void)didLoadFromCCB
{
    CCLOG(@"GOING THROUGH GAMEOVER LOSE DID LOAD FROM CCB");
    _highScore.string = [NSString stringWithFormat:@"%d",highScore];
    _totalScore.string = [NSString stringWithFormat:@"%d", totalScoreVal];
    [self tip];
}
-(void)tip{
    int tipNum=arc4random()%4;
    if(totalScoreVal<40){
        tipNum=0;
    }
    NSString *tipMsg;
    if(tipNum==1){
        tipMsg= @"Putting shapes inside of each other gets you more points!";
    }
    else if(tipNum==2)
    {
        tipMsg= @"Bigger shapes get you extra points!";
    }
    else if (tipNum==3){
        tipMsg= @"The bigger the shape the higher the points!";
    }
    else if (tipNum==0){
        tipMsg= @"Don't collide with the border or any other shapes!!!";
    }
    _tipMessage.string=[NSString stringWithFormat:@"%@",tipMsg];
}
@end
