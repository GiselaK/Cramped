//
//  LBRow.m
//  Cramped
//
//  Created by Gisela Kottmeier on 8/12/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "LBRow.h"
extern NSString *namae;
extern int rankNum;
extern int rankedScore;
@implementation LBRow{
    CCLabelTTF *_name;
    CCLabelTTF *_rankedScoreLabel;
    CCLabelTTF *_rankRole;
    CCSprite *_LBTriLineOne;
    CCSprite *_LBTriLineTwo;
    CCSprite *_LBTriLineThree;
    CCSprite *_LBRectLineOne;
    CCSprite *_LBRectLineTwo;
    CCSprite *_LBRectLineThree;
    CCSprite *_LBRectLineFour;
}
-(void)onEnter{
    [super onEnter];
    _LBTriLineOne.color=[CCColor greenColor];
    _LBTriLineTwo.color=[CCColor greenColor];
    _LBTriLineThree.color=[CCColor greenColor];
    _LBRectLineOne.color=[CCColor blueColor];
    _LBRectLineTwo.color=[CCColor blueColor];
    _LBRectLineThree.color=[CCColor blueColor];
    _LBRectLineFour.color=[CCColor blueColor];
    _name.string=[NSString stringWithFormat:@"%@",namae];
    _rankedScoreLabel.string=[NSString stringWithFormat:@"%i",rankedScore];
    _rankRole.string=[NSString stringWithFormat:@"%i",rankNum];
//    _name.string=[NSString stringWithFormat:@"hi"];
    CCLOG(@"%@",namae);
}
@end