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
    CCLabelTTF *_yousuck;
}

- (void)didLoadFromCCB
{
    _highScore.string = [NSString stringWithFormat:@"%d",highScore];
    _totalScore.string = [NSString stringWithFormat:@"%d", totalScoreVal];
    [self tip];
    [self chooseGameOverText];
}
-(void)tip{
    int tipNum=1;
    //arc4random()%6;
    if(totalScoreVal<40){
        tipNum=1;
    }
    NSString *tipMsg;
    if(tipNum==1){
        tipMsg= @"Stacking shapes gets you more points!!!";
    }
    else if(tipNum==2)
    {
        tipMsg= @"Bigger shapes get you extra points!!!";
    }
    else if (tipNum==3){
        tipMsg= @"The bigger the shape the higher the points!!!";
    }
    else if (tipNum==4){
        tipMsg= @"The border color is the color of the next shape!";
    }
    else if (tipNum==5){
         tipMsg= @"The rotation direction alternates every shape!";
    }
    else if (tipNum==0){
        tipMsg= @"Don't collide with the border or any other shapes!";
    }
    _tipMessage.string=[NSString stringWithFormat:@"%@",tipMsg];
}
-(void)chooseGameOverText{
    if (totalScoreVal<40){
        [self usuck];
    }
    else if (totalScoreVal>40 && highScore/1.15<totalScoreVal){
        [self damn];
    }
    else {
        [self ehh];
    }
}
-(void)usuck{
    int random=arc4random()%12;
    if (random==1 || random==2 || random==3 || random==4){
        _yousuck.fontSize=28;
        _yousuck.string=[NSString stringWithFormat:@"F A I L"];
        //DELETE LATER
    }
    else if (random==5 || random==6){
        _yousuck.string=[NSString stringWithFormat:@"Did you even tap the screen?"];
    }
    else if (random==7){
        _yousuck.string=[NSString stringWithFormat:@"That was just sad..."];
    }
    else if (random==8 || random==9){
        _yousuck.string=[NSString stringWithFormat:@"Talent... U LACK IT"];
    }
    else if (random==10 || random==11){
        _yousuck.string=[NSString stringWithFormat:@"Ughh your hopeless..."];
        // DELETE?
    }
    else{
        _yousuck.string=[NSString stringWithFormat:@"U BLIND?"];
        //DELETE?

    }
}
-(void)damn{
    int random=arc4random()%6;
    if (random==1 || random==2){
      _yousuck.string=[NSString stringWithFormat:@"Hah So Close"];
    }
    else if(random==3){
        _yousuck.fontSize=23;
        _yousuck.string=[NSString stringWithFormat:@"The shapes can't touch each other. Remember?"];
    }
    else if (random==4){
        _yousuck.string=[NSString stringWithFormat:@"you could do your work... or you can play again"];
    }
    else {
          _yousuck.string=[NSString stringWithFormat:@"So close yet so far..."];
    }
}
-(void)ehh{
    int random=arc4random()%10;
    if (random==1){
        _yousuck.string=[NSString stringWithFormat:@"ehh"];
    }
    else if (random==2 || random==3){
        _yousuck.string=[NSString stringWithFormat:@"YAWN"];
    }
    else if (random==4 || random==5){
        _yousuck.string=[NSString stringWithFormat:@"Could've been worse.."];
    }
    else if (random==6){
        _yousuck.string=[NSString stringWithFormat:@"Could've been better..."];
    }
    else if (random==7 || random==8){
        _yousuck.string=[NSString stringWithFormat:@"Not even close"];
    }
    else {
        _yousuck.string=[NSString stringWithFormat:@"Sucks to Suck"];
    }
}
@end
