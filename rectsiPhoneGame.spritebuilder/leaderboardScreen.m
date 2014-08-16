//
//  leaderboardScreen.m
//  Cramped
//
//  Created by Gisela Kottmeier on 8/12/14.
//  Copyright 2014 Apportable. All rights reserved.
//
#import <mgwuSDK/MGWU.h>
#import "leaderboardScreen.h"
#import "LBRow.h"
NSString *namae;
int rankNum;
int rankedScore;
@implementation leaderboardScreen{
    LBRow *_LBRow;
    float yPos;
    float screenPos;

}
-(void)didLoadFromCCB{
    UISwipeGestureRecognizer * swipeUp= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeUp)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeUp];
    // listen for swipes down
    UISwipeGestureRecognizer * swipeDown= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDown)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeDown];
}
-(void)onEnter{
    [super onEnter];
     self.position=ccp(([[CCDirector sharedDirector] viewSize].width)/2, ([[CCDirector sharedDirector] viewSize].height/2));
    yPos=[[CCDirector sharedDirector] viewSize].height*1.2;
    [MGWU getHighScoresForLeaderboard:@"CrampedLeaderboard" withCallback:@selector(receivedScores:) onTarget:self];

}
- (void)swipeDown {
    screenPos-=230;
     self.position=ccp(([[CCDirector sharedDirector] viewSize].width)/2, ([[CCDirector sharedDirector] viewSize].height/2+screenPos));
//    [MGWU getHig0hScoresForLeaderboard:@"CrampedLeaderboard" withCallback:@selector(receivedScores:) onTarget:self];
    CCLOG(@"swipinDOWN");
}
- (void)swipeUp {
    screenPos+=230;
    self.position=ccp(([[CCDirector sharedDirector] viewSize].width)/2, ([[CCDirector sharedDirector] viewSize].height/2+screenPos));
//    [MGWU getHighScoresForLeaderboard:@"CrampedLeaderboard" withCallback:@selector(receivedSc2)ores:) onTarget:self];
    CCLOG(@"swipinUP");
}

- (void)receivedScores:(NSDictionary*)scores
{
    if (_LBRow.parent){
        [self removeAllChildren];
    }
    NSArray *scoreArray=[scores objectForKey:@"all"];
    NSString *userName=@"";
    NSString *scoreResult=@"";
    rankNum=0;
    int addBack = 0;
    if(scoreArray.count>=50){
        for(int x=0; x<50;x++){
            yPos+=0.5;
            userName=@"";
            scoreResult=@"";
            userName=[userName stringByAppendingString:[[scoreArray objectAtIndex:x]objectForKey:@"name"]];
            scoreResult=[scoreResult stringByAppendingString:[[scoreArray objectAtIndex:x]objectForKey:@"score"]];
            rankedScore=scoreResult.intValue;
              namae=userName;
            _LBRow = (LBRow*) [CCBReader load:@"LBRow"];
            _LBRow.scale=0.2;
            _LBRow.position=ccp([[CCDirector sharedDirector] viewSize].width/3, [[CCDirector sharedDirector] viewSize].height/yPos);
            [self addChild:_LBRow];
        }
    }
    else{
        for (NSDictionary *userNameX in scoreArray ) {
            rankNum+=1;
            userName=@"";
            scoreResult=@"";
            userName=[userName stringByAppendingString:[userNameX objectForKey:@"name"]];
            scoreResult=[scoreResult stringByAppendingString:[userNameX objectForKey:@"score"]];
            namae=userName;
            rankedScore=scoreResult.intValue;
            _LBRow = (LBRow*) [CCBReader load:@"LBRow"];
            _LBRow.scale=0.2;
            _LBRow.position=ccp(([[CCDirector sharedDirector] viewSize].width*-1)*0.2, ([[CCDirector sharedDirector] viewSize].height*-1)+yPos);
              yPos-=50;
            addBack+=50;
            [self addChild:_LBRow];
        }
        yPos+=addBack;
        
    }
    //    scores[@"user"][@"name"];//    NSString *LBScore=scores[@"all"]["@score"];
//    scores[@"user"][@"score"];
    CCLOG(@"user:%@",userName);
}

@end
