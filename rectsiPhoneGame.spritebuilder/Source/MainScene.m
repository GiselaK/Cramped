//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//
#import "CCPhysics+ObjectiveChipmunk.h"
#import "CCBReader.h"
#import "MainScene.h"
#import "shapeGrow.h"
#import "Rectangle.h"
#import "Triangle.h"
#import "GameOver.h"
#import "BeginGame.h"
#import "BorderLine.h"
#import "startTri.h"
#import "GameOverLoose.h"
#import "tap.h"
#import "Taphere.h"
#import "Orhere.h"
#import "passTutorial.h"
#import "failTutorial.h"
#import "leaderboardScreen.h"
#import "LBButton.h"
#import "rankingLabel.h"
extern int stackedShapes;
extern BOOL tappedInside;
BOOL playButtonOrNah;
BOOL gameEnd;
BOOL playClickedbool;
int bonusPointsInt;
int borderColor;
int highScore;
float normpoints;
int normPointsInt;
int totalShapes;
int totalScoreVal;
CGPoint touchLocation;
@implementation MainScene
{
    BeginGame *_beginGame;
    BorderLine *_playRect1;
    BorderLine *_playRect2;
    BorderLine *_playRect3;
    BorderLine *_playRect4;
    LBButton *_LBButton;
    CCLabelTTF *_scoreatm;
    CCLabelTTF *_userNameLabel;
    CCLabelTTF *_userTip;
    CCLabelTTF *_yourHS;
    CCLabelTTF *_yourHSNum;
    rankingLabel *_rankingLabel;
    CCPhysicsNode *_physicsNode;
    CGFloat oppTouchX;
    CGFloat oppTouchY;
    CGPoint border1pos;
    CGPoint border2pos;
    CGPoint border3pos;
    CGPoint border4pos;
    CGPoint oppTouch;
    CCTextField *_nameBox;
    failTutorial *_failTutorial;
    GameOver *_gameOver;
    GameOverLoose *_gameOverLoose;
    leaderboardScreen *_leaderboardScreen;
    NSNumber *perhighScore;
    Orhere *_Orhere;
    passTutorial *_passTutorial;
    Rectangle *_currentRect;
    startTri *_playTri;
    tap *_tap;
    Taphere *_Taphere;
    Triangle *_currentTri;
    BOOL alreadyCollided;
    BOOL beginGameMode;
    BOOL doneTutorial;
    BOOL firstShape;
    BOOL gameStarted;
    BOOL insane;
    BOOL justPassedTutorial;
    BOOL large;
    BOOL OrHere;
    BOOL tappedOutside;
    BOOL tutorial;
    BOOL tutorialComplete;
    BOOL XL;
    float bonusPoints;
    float shapeSize;
    int currentShape;
    int num;
    int numb;
    BOOL orHereDoneTwice;
    int pickShape;
    int rotationAmt;
    int rotationDir;
    int rotationVal;
    NSString *myName;

}
- (void)didLoadFromCCB {
    [self loadCCBS];
    _physicsNode= [CCPhysicsNode node];
    _physicsNode.collisionDelegate = self;
    [self addChild:_physicsNode];
    // listen for swipes up
}
-(void)loadCCBS{
    _currentTri = (Triangle*) [CCBReader load:@"Tri"];
    _currentRect = (Rectangle*) [CCBReader load:@"rect"];
    _playTri = (startTri*) [CCBReader load:@"startTri"];
    _playRect1 = (BorderLine*) [CCBReader load:@"BorderLine"];
    _playRect2 = (BorderLine*) [CCBReader load:@"BorderLine"];
    _playRect3 = (BorderLine*) [CCBReader load:@"BorderLine"];
    _playRect4 = (BorderLine*) [CCBReader load:@"BorderLine"];
    //load all ccb thingies
}
-(void)onEnter{
    [super onEnter];
    self.userInteractionEnabled = TRUE;
    [self userName];
    if(myName){
         [self startScreen];
    }
}
-(void)userName{
    playButtonOrNah=TRUE;
    _nameBox.visible=NO;
    _userNameLabel.visible=NO;
    _userTip.visible=NO;
    _yourHSNum.visible=NO;
    _yourHS.visible=NO;
    myName= [[NSUserDefaults standardUserDefaults] objectForKey:@"myName"];
    if(myName==nil)
    {
        _nameBox.visible=YES;
        _userNameLabel.visible=YES;
         _userTip.visible=YES;
         _LBButton.visible=NO;
    }
    
}

-(void)saveMyName{
    myName = [_nameBox string];
    [[NSUserDefaults standardUserDefaults] setObject:myName forKey:@"myName"];
     _nameBox.visible=NO;
    _userNameLabel.visible=NO;
    _userTip.visible=NO;
     [self startScreen];
}
-(void) startScreen{
//    if(num!=1){
//        tutorial=true;
//        orHereDoneTwice=0;
//    }
//    num=1;
    // temporary to stop tutorial since bool not saved officially yet
    NSNumber *currentHighScore = [MGWU objectForKey:@"perhighScore"];
    highScore = [currentHighScore intValue];
    //temproary to reset highscore
    [self playScreen];
    //Loads PlayScreen
    [self playButton];
    //Loads Play Button
}
-(void)playScreen{
    _beginGame= (BeginGame*) [CCBReader load:@"PlayScreen"];
    _beginGame.position=ccp([[CCDirector sharedDirector] viewSize].width/2, [[CCDirector sharedDirector] viewSize].height/1.15);
    _playTri.position = ccp([[CCDirector sharedDirector] viewSize].width/2, [[CCDirector sharedDirector] viewSize].height/2);
    [self addChild:_beginGame];
    _LBButton.visible=YES;
}
-(void) playButton{
    playButtonOrNah=TRUE;
    _playTri.mainscene=self;
    if(_playTri.parent){
        [self removeChild:_playTri];
    }
    [self addChild: _playTri];
}
-(void)playClicked{
    playClickedbool=TRUE;
    _yourHSNum.visible=NO;
    _yourHS.visible=NO;
    if (_yourHSNum.parent){
        [self removeChild:_yourHS];
        [self removeChild:_yourHSNum];
    }
    if(_LBButton.parent){
        [self removeChild:_LBButton];
    }
    [self removePhysics];
    [self removeScreen];
    [self addPhysics];
    [self resetValuesNewGame];
    [self hideLBButton];
    [self makeBorder];
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"tutorialCheck"]) {
        tutorial=TRUE;
        firstShape=TRUE;
    }
    else{
        tutorial=FALSE;
    }
    [self decideShape];
    [self tapAnywhere];
}
-(void)removePhysics{
    [_physicsNode removeAllChildrenWithCleanup:YES];
}
-(void)removeScreen{
    
    [self removeStartButton];
    [self removeLeaderboard];
    [self removeGameOverLoose];
    [self removeNewHighscore];
    [self removeBeginGame];
    [self removeFailTutorial];
    [self removePassedTutorial];
}
-(void)removeStartButton{
    if (_playTri.parent){
        [self removeChild:_playTri];
    }
}
-(void)removeNewHighscore{
    if (_gameOver.parent){
        [self removeChild:_gameOver];
    }
}
-(void)removeBeginGame{
    if (_beginGame.parent){
        [self removeChild:_beginGame];
    }
}
-(void)removeLeaderboard{
    if (_leaderboardScreen.parent){
        [self removeChild:_leaderboardScreen];
    }
    if (_rankingLabel.parent){
        [self removeChild:_rankingLabel];
    }
}
-(void)removeGameOverLoose{
    if (_gameOverLoose.parent){
        [self removeChild:_gameOverLoose];
    }
}
-(void)removeFailTutorial{
    if (_failTutorial.parent){
        [self removeChild:_failTutorial];
    }
}
-(void)removePassedTutorial{
    if (_passTutorial.parent){
        [self removeChild:_passTutorial];
    }
}
-(void)addPhysics{
    if(!_physicsNode.parent){
        _physicsNode= [CCPhysicsNode node];
        _physicsNode.collisionDelegate = self;
        [self addChild:_physicsNode];
    }
}
-(void)resetValuesNewGame{
    [self resetScoreVars];
    gameEnd=FALSE;
    [self resetSizes];
    playButtonOrNah=FALSE;
    shapeSize=0.002;
    alreadyCollided=FALSE;
    gameStarted=TRUE;
}
-(void)resetScoreVars{
    totalScoreVal=0;
    _scoreatm.string = [NSString stringWithFormat:@"%d", totalScoreVal];
    stackedShapes=0;
    bonusPoints=0;
    bonusPointsInt=0;
    totalShapes=0;
    normpoints=0;
    normPointsInt=0;
}
-(void)resetSizes{
    large=FALSE;
    insane=FALSE;
    XL=FALSE;
}
-(void)makeBorder{
    [self scaleBorder];
    [self rotateBorderLines];
    [self positionBorderLines];
    [self addBorderToScene];
}
-(void)scaleBorder{
    float borderHScale=2;
    float borderWScale=2;
    _playRect1.scale=borderHScale;
    _playRect2.scale=borderHScale;
    _playRect3.scale=borderWScale;
    _playRect4.scale=borderWScale;
}
-(void)rotateBorderLines{
    _playRect3.rotation=90;
    _playRect4.rotation=90;
}
-(void)positionBorderLines{
    border1pos=ccp([[CCDirector sharedDirector] viewSize].width, [[CCDirector sharedDirector] viewSize].height/2);
    border2pos=ccp(1, [[CCDirector sharedDirector] viewSize].height/2);
    border3pos=ccp([[CCDirector sharedDirector] viewSize].width/2, [[CCDirector sharedDirector]viewSize].height);
    border4pos=ccp([[CCDirector sharedDirector] viewSize].width/2,1);
    _playRect1.position= border1pos;
    _playRect2.position= border2pos;
    _playRect3.position= border3pos;
    _playRect4.position= border4pos;
}
-(void)addBorderToScene{
    [_physicsNode addChild: _playRect1];
    [_physicsNode addChild: _playRect2];
    [_physicsNode addChild: _playRect3];
    [_physicsNode addChild: _playRect4];
}
-(void)tapAnywhere{
    _tap = (tap*) [CCBReader load:@"Tap"];
    _tap.position=ccp([[CCDirector sharedDirector] viewSize].width/2, [[CCDirector sharedDirector] viewSize].height/1.6);

    [self addChild:_tap];
}
-(void)decideShape{
    pickShape=arc4random()%2;
    if(pickShape==1){
        borderColor=1;
    }
    else if(pickShape==0){
        borderColor=2;
    }
}
-(void) shapeSpawn{
    totalShapes+=1;
    [self resetSizes];
    [self rotationDirection];
    shapeSize=0.001;
    rotationAmt=arc4random()%2;
    [self spawnChosenShape];
    
}
-(void)spawnChosenShape{
    if(firstShape==TRUE){
        firstShape=FALSE;
        pickShape=1;
    }
    // if first shape in tutorial always rectangle
    if (pickShape==1){
        [self spawnRect];
    }
    else {
        [self spawnTri];
    }
}
-(void)rotationDirection{
    if(rotationDir==1){
        rotationDir=2;
    }
    else{
        rotationDir=1;
    }
}
-(void)spawnRect{
    _currentRect = (Rectangle*) [CCBReader load:@"rect"];
    _currentRect.position = touchLocation;
    _currentRect.rotation=arc4random()%360;
    _currentRect.mainscene= self;
    _currentRect.physicsBody.collisionType = @"Rectangle";
    _currentRect.physicsBody.sensor=TRUE;
    _currentRect.scale=shapeSize;
    [_physicsNode addChild: _currentRect];
     currentShape=1;
}
-(void)spawnTri{
    _currentTri = (Triangle*) [CCBReader load:@"Tri"];
    _currentTri.position = touchLocation;
    _currentTri.rotation=arc4random()%360;
    _currentTri.mainscene= self;
    _currentTri.physicsBody.collisionType = @"Triangle";
    _currentTri.physicsBody.sensor=TRUE;
    _currentTri.scale=shapeSize;
    [_physicsNode addChild:_currentTri];
    currentShape=2;
    //yoooo
}
-(void)updateScore{
    if(_scoreatm.parent){
        [self removeChild:_scoreatm];
    }
    totalScoreVal=(normPointsInt+bonusPointsInt+totalShapes+stackedShapes)/2;
    _scoreatm.string = [NSString stringWithFormat:@"%d", totalScoreVal];
    [self addChild:_scoreatm];
}
- (void)update:(CCTime)delta {
    if(!playButtonOrNah &&!gameEnd){
        if(currentShape==1){
            [self updateRect];
        }
        else if (currentShape==2){
            [self updateTri];
        }
        if (tappedInside==TRUE && _Taphere.parent){
            [self removeChild:_Taphere];
            tappedInside=FALSE;
        }
    }
}
-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair Shape:(CCNode *)Shape wildcard:(CCNode *)nodeB {
    if(gameStarted && !alreadyCollided && _physicsNode.parent){
        alreadyCollided=true;
        [self gameEnd];
    }
     return FALSE;
}

-(void)updateRect{
    [self removeRect];
    [self addPointsRect];
    [self rescaleRect];
    [self CalcRotation];
    _currentRect.rotation=rotationVal;
    _currentRect.mainscene= self;
    _currentRect.physicsBody.collisionType = @"Rectangle";
    _currentRect.physicsBody.sensor=TRUE;
    [_physicsNode addChild: _currentRect];
}

-(void)removeRect{
    if (_currentRect.parent==_physicsNode){
        [_physicsNode removeChild:_currentRect cleanup:YES];
    }
}
-(void)addPointsRect{
    [self addNormPoints];
    [self largeRect];
    [self xlRect];
    [self insaneRect];
    bonusPointsInt = (int) bonusPoints;
}
-(void)addNormPoints{
    normpoints+=0.2;
    normPointsInt = (int) normpoints;
}
-(void)largeRect{
    if (large==false){
        if (_currentRect.boundingBox.size.width>60 && _currentRect.boundingBox.size.width<=120){
            [self largeBonus];
        }
    }
}
-(void)largeBonus{
    bonusPoints+=2;
    large=TRUE;
}
-(void)xlRect{
    if(XL==false){
        if (_currentRect.boundingBox.size.width>120 && _currentRect.boundingBox.size.width<180){
            [self xlBonus];
        }
    }
}
-(void)xlBonus{
    bonusPoints+=3;
    XL=TRUE;
}
-(void)insaneRect{
    if (insane==FALSE){
        if (_currentRect.boundingBox.size.width>180){
            [self insaneBonus];
        }
    }
}
-(void)insaneBonus{
    bonusPoints+=4;
    insane=TRUE;
}
-(void)rescaleRect{
    shapeSize+=0.002;
    _currentRect.scale=shapeSize;
}
-(void)updateTri{
    [self removeTri];
    [self addPointsTri];
    [self rescaleTri];
    [self CalcRotation];
    _currentTri.rotation=rotationVal;
    _currentTri.mainscene= self;
    _currentTri.physicsBody.collisionType = @"Triangle";
    _currentTri.physicsBody.sensor=TRUE;
    [_physicsNode addChild:_currentTri];
}
-(void)rescaleTri{
    shapeSize+=0.003;
    _currentTri.scale=shapeSize;
}
-(void)removeTri{
    if(_currentTri.parent== _physicsNode){
        [_physicsNode removeChild:_currentTri];
    }
}
-(void)addPointsTri{
    [self addNormPoints];
    [self largeTri];
    [self xlTri];
    [self insaneTri];
    bonusPointsInt = (int) bonusPoints;
}
-(void)largeTri{
    if (large==false){
        if (_currentTri.boundingBox.size.width>60 && _currentTri.boundingBox.size.width<=120){
            [self largeBonus];
        }
    }
}
-(void)xlTri{
    if(XL==false){
        if (_currentTri.boundingBox.size.width>120 && _currentTri.boundingBox.size.width<180){
            [self xlBonus];
        }
    }
}
-(void)insaneTri{
    if (insane==FALSE){
        if (_currentTri.boundingBox.size.width>180){
            [self insaneBonus];
        }
    }
}
-(void)CalcRotation{
    if (rotationAmt==1){
        [self smallRotation];
    }
    else{
        [self bigRotation];
    }
}
-(void)smallRotation{
    if (rotationDir==1){
        rotationVal-=1;
    }
    else{
        rotationVal+=1;
    }
}
-(void)bigRotation{
    if (rotationDir==1){
        rotationVal-=1.5;
    }
    else{
        rotationVal+=1.5;
    }
}
-(void)showLBButton{
    if(_LBButton.parent){
        [self removeChild:_LBButton];
    }
    [self addChild:_LBButton];
    _LBButton.visible=YES;
}
-(void)hideLBButton{
    _LBButton.visible=NO;
}
-(void)gameEnd{
    if (tutorial==TRUE){
        [self retryTutorial];
        [self completeTutorial];
        [self removeInstructions];
    }
    _LBButton.position=ccp(([[CCDirector sharedDirector] viewSize].width/5), [[CCDirector sharedDirector] viewSize].height/1.2);
    gameStarted=FALSE;
    playButtonOrNah=TRUE;
    currentShape=0;
    playClickedbool=FALSE;
//    pickShape=2;
    
    if(!tutorial){
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"tutorialCheck"]){
            [self passedTutorial];
        }
        else{
          [self gameOverScreen];
        }
    }
    else{
        [self failedTutorial];
    }
      [self performSelector:@selector(maybeShowLBButton) withObject:nil afterDelay:0.7];
}
-(void)maybeShowLBButton{
    if(playClickedbool==FALSE){
        [self showLBButton];
    }
}
-(void)retryTutorial{
    if (totalScoreVal<40 & doneTutorial==FALSE){
        orHereDoneTwice=FALSE;
    }
}
-(void)completeTutorial{
    if (totalScoreVal>40){
        doneTutorial=TRUE;
        tutorial=FALSE;
    }
}
-(void)removeInstructions{
    [self removeTapInstruction];
    [self removeTapHereInstruction];
    [self removeOnHereInstruction];
}
-(void) passedTutorial{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"tutorialCheck"];
    [self setNewHighScore];
    _passTutorial.position=ccp([[CCDirector sharedDirector] viewSize].width/2, [[CCDirector sharedDirector] viewSize].height/2.5);
    _passTutorial= (passTutorial*) [CCBReader load:@"passTutorial"];
    [self addChild:_passTutorial];
      _playTri.position = ccp([[CCDirector sharedDirector] viewSize].width/1.4, [[CCDirector sharedDirector] viewSize].height/2.6);
     [self performSelector:@selector(playButton) withObject:nil afterDelay:0.3];
}
-(void)removeTapInstruction{
    if(_tap.parent){
        [self removeChild:_tap];
    }
}
-(void)removeTapHereInstruction{
    if(_Taphere.parent){
        [self removeChild:_Taphere];
    }
}
-(void)removeOnHereInstruction{
    if(_Orhere.parent){
        [self removeChild:_Orhere];
    }
}
-(void)gameOverScreen{
    if(highScore<totalScoreVal){
        [self beatHighScore];
    }
    else{
        [self loserScreen];
        [self showPlayButton];
    }
}
-(void)showPlayButton{
    _playTri.scale=1;
    _playTri.position = ccp([[CCDirector sharedDirector] viewSize].width/1.6, [[CCDirector sharedDirector] viewSize].height/2.6);
    [self performSelector:@selector(playButton) withObject:nil afterDelay:0.3];
}
-(void)beatHighScore{
    [self setNewHighScore];
    [self newHighScoreScreen];
}
-(void)setNewHighScore{
    highScore=totalScoreVal;
    perhighScore = [NSNumber numberWithInteger:highScore];
    [MGWU setObject:perhighScore forKey:@"perhighScore"];
    [MGWU submitHighScore:highScore byPlayer:myName forLeaderboard:@"CrampedLeaderboard"];
}

-(void)newHighScoreScreen{
    _gameOver.position=ccp([[CCDirector sharedDirector] viewSize].width/2, [[CCDirector sharedDirector] viewSize].height/2.7);
    _gameOver= (GameOver*) [CCBReader load:@"GameOver"];
    [self addChild:_gameOver];
    _playTri.scale=1;
    _playTri.position = ccp([[CCDirector sharedDirector] viewSize].width/1.4, [[CCDirector sharedDirector] viewSize].height/5);
     [self performSelector:@selector(playButton) withObject:nil afterDelay:0.7];
    
}
-(void)leaderboardScreen{
    [self removeScreen];
    [self removeAllChildren];
    [self showPlayButton];
    if (_scoreatm.parent){
        [self removeChild:_scoreatm];
    }
    _rankingLabel = (rankingLabel*) [CCBReader load:@"RankingLabel"];
    _rankingLabel.position=ccp(([[CCDirector sharedDirector] viewSize].width/2), ([[CCDirector sharedDirector] viewSize].height/2));
    _leaderboardScreen= (leaderboardScreen*) [CCBReader load:@"leaderboardScreen"];
     _leaderboardScreen.position=ccp([[CCDirector sharedDirector] viewSize].width/2, [[CCDirector sharedDirector] viewSize].height/2.7);
    [self addChild:_leaderboardScreen];
    [self addChild:_rankingLabel];
    _yourHS.visible=YES;
    _yourHSNum.visible=YES;
    if (_yourHSNum.parent){
        [self removeChild:_yourHS];
        [self removeChild:_yourHSNum];
    }
    _yourHSNum.string=[NSString stringWithFormat:@"%i",highScore];
    [self addChild:_yourHS];
    [self addChild:_yourHSNum];
    _playTri.scale=1;
   _playTri.position = ccp([[CCDirector sharedDirector] viewSize].width/1.3, [[CCDirector sharedDirector] viewSize].height/5);
    [self playButton];
    }
-(void)loserScreen{
    _LBButton.position=ccp([[CCDirector sharedDirector] viewSize].width/1.3, [[CCDirector sharedDirector] viewSize].height/5.5);
      _playTri.position = ccp([[CCDirector sharedDirector] viewSize].width/1.4, [[CCDirector sharedDirector] viewSize].height/10);
    _gameOverLoose= (GameOverLoose*) [CCBReader load:@"GameOverLoose"];
    [self addChild:_gameOverLoose];
}
-(void)failedTutorial{
    _failTutorial.position=ccp([[CCDirector sharedDirector] viewSize].width/2, [[CCDirector sharedDirector] viewSize].height/2.5);
    _failTutorial= (failTutorial*) [CCBReader load:@"failTutorial"];
    [self addChild:_failTutorial];
    [self showPlayButton];
}
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    touchLocation = [touch locationInNode:self];
    [self removeTapInstruction];
    [self removeTapHereInstruction];
    [self removeOnHereInstruction];
    if(!playButtonOrNah && !gameEnd){
        [self updateScore];
        [self shapeSpawn];
        [self decideShape];
        if (tutorial==true) {
             [self tapHere];
        }
    }
}
-(void)tapHere{
    _Taphere = (Taphere*) [CCBReader load:@"Taphere"];
    _Taphere.position= touchLocation;
    [self addChild:_Taphere];
    if(!orHereDoneTwice){
          [self positionOrHere];
        [self performSelector:@selector(showOrHere) withObject:nil afterDelay:0.5];
        orHereDoneTwice=TRUE;
    }
}
-(void)positionOrHere{
    _Orhere = (Orhere*) [CCBReader load:@"Orhere"];
        if (touchLocation.x>200){
            oppTouchX=touchLocation.x-100;
        }
        else{
            oppTouchX=touchLocation.x+100;
        }
        if (touchLocation.y>150){
            oppTouchY=touchLocation.y-100;
        }
        else{
            oppTouchY=touchLocation.y+100;
        }
        oppTouch = CGPointMake(oppTouchX, oppTouchY);
        _Orhere.position= oppTouch;
    
}

-(void)showOrHere{
    if(_Orhere.parent){
        [self removeChild:_Orhere];
    }
        [self addChild:_Orhere];
}//    CGSize screenBounds = [[CCDirector sharedDirector] viewSize];
//    int screenHeight=screenBounds.height;
//    int screenWidth=screenBounds.width;5
//    if (screenWidth>_playRect1.boundingBox.size.width){
//        _playRect1.scale+=0.004;ss
//        _playRect2.scale+=0.004;
//    }
//    if (screenHeight>_playRect3.boundingBox.size.height){
//        _playRect3.scale+=0.004;
//        _playRect4.scale+=0.004;
//    }
//    if (_playRect1.position.y<[[CCDirector sharedDirector] viewSize].height){
//    }
//    if (_playRect2.position.y<[[CCDirector sharedDirector] viewSize].height){
//
//    }
//    if (_playRect3.position.y<[[CCDirector sharedDirector] viewSize].height){
//
//    }
//    if (_playRect4.position.x<[[CCDirector sharedDirector] viewSize].width){
//
//    }
//}
@end
