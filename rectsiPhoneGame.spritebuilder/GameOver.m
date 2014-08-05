//
//  GameOver.m
//  rectsiPhoneGame
//
//  Created by Gisela Kottmeier on 7/16/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "GameOver.h"

extern int bonusPointsInt;
extern int stackedShapes;
extern int totalShapes;
extern int totalScoreVal;
extern int highScore;
@implementation GameOver{
    CCLabelTTF *_bonusPoints;
    CCLabelTTF *_highScore;
    CCLabelTTF *_stackedShapes;
    CCLabelTTF *_totalScore;
    CCLabelTTF *_totalShapes;
    CCLabelTTF *_totalShapesPoints;
    CCLabelTTF *_totalStackPoints;
}
-(void)onEnter{
    [super onEnter];
    _bonusPoints.string = [NSString stringWithFormat:@"%d", bonusPointsInt];
    _highScore.string = [NSString stringWithFormat:@"%d",highScore];
    _stackedShapes.string = [NSString stringWithFormat:@"%d",stackedShapes/10];
    _totalScore.string = [NSString stringWithFormat:@"%d", totalScoreVal];
    _totalShapes.string = [NSString stringWithFormat:@"%d",totalShapes];
    _totalShapesPoints.string = [NSString stringWithFormat:@"%d",totalShapes];
    _totalStackPoints.string = [NSString stringWithFormat:@"%d",stackedShapes];
}
@end
