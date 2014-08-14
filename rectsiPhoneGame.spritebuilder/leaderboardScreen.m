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
int rankedScore;
@implementation leaderboardScreen{
    LBRow *_LBRow;
}
-(void)onEnter{
    [super onEnter];
    [MGWU getHighScoresForLeaderboard:@"CrampedLeaderboard" withCallback:@selector(receivedScores:) onTarget:self];

}
- (void)receivedScores:(NSDictionary*)scores
{
    NSArray *scoreArray=[scores objectForKey:@"all"];
    NSString *userName=@"";
    NSString *scoreResult=@"";
    float yPos=[[CCDirector sharedDirector] viewSize].height*1.5;
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
            [self addChild:_LBRow];
        }
    }
    //    scores[@"user"][@"name"];
//    NSString *LBScore=scores[@"all"]["@score"];
//    scores[@"user"][@"score"];
    CCLOG(@"user:%@",userName);
}
@end
