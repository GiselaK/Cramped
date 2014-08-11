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
extern int stackedShapes;
extern BOOL tappedInside;
BOOL playButtonOrNah;
BOOL gameEnd;
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
    CCLabelTTF *_scoreatm;
    CCPhysicsNode *_physicsNode;
    CGFloat oppTouchX;
    CGFloat oppTouchY;
    CGPoint border1pos;
    CGPoint border2pos;
    CGPoint border3pos;
    CGPoint border4pos;
    CGPoint oppTouch;
    failTutorial *_failTutorial;
    GameOver *_gameOver;
    GameOverLoose *_gameOverLoose;
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
    int orHereDoneTwice;
    int pickShape;
    int rotationAmt;
    int rotationDir;
    int rotationVal;

}
- (void)didLoadFromCCB {
    [self loadCCBS];
    _physicsNode= [CCPhysicsNode node];
    _physicsNode.collisionDelegate = self;
    [self addChild:_physicsNode];
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
    [self startScreen];
}
-(void) startScreen{
    if(num!=1){
        tutorial=true;
        orHereDoneTwice=0;
    }
    num=1;
    // temporary to stop tutorial since bool not saved officially yet
    NSNumber *currentHighScore = [MGWU objectForKey:@"perhighScore"];
    highScore = [currentHighScore intValue];
    perhighScore=0;
    highScore=0;
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
}
-(void) playButton{
    playButtonOrNah=TRUE;
    _playTri.mainscene=self;
    _playTri.scale=0.2;
    _playTri.rotation=90;
    if(_playTri.parent){
        [self removeChild:_playTri];
    }
    [self addChild: _playTri];
}
-(void)playClicked{
    [self removePhysics];
    [self removeSceen];
    [self addPhysics];
    [self resetValuesNewGame];
    [self makeBorder];
    if (tutorial==true) {
        firstShape=TRUE;
    }
    [self decideShape];
    [self tapAnywhere];
}
-(void)removePhysics{
    [_physicsNode removeAllChildrenWithCleanup:YES];
}
-(void)removeSceen{
    [self removeChild:_playTri];
    [self removeBeginGame];
    [self removeGameOver];
    [self removeGameOverLoose];
    [self removeFailTutorial];
    [self removePassedTutorial];
}
-(void)removeBeginGame{
    if (_beginGame.parent){
        [self removeChild:_beginGame];
    }
}
-(void)removeGameOver{
    if (_gameOver.parent){
        [self removeChild:_gameOver];
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
    totalScoreVal=(normPointsInt+bonusPointsInt+totalShapes+stackedShapes)/2;
    _scoreatm.string = [NSString stringWithFormat:@"%d", totalScoreVal];
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

-(void)gameEnd{
    [self retryTutorial];
    [self completeTutorial];
    [self removeInstructions];
    gameStarted=FALSE;
    playButtonOrNah=TRUE;
    currentShape=0;
//    pickShape=2;
    if(!tutorial){
        if (justPassedTutorial==FALSE){
            [self passedTutorial];
            justPassedTutorial=TRUE;
        }
        else{
          [self gameOverScreen];
        }
    }
    else{
        [self failedTutorial];
    }
}
-(void)retryTutorial{
    if (totalScoreVal<40 & doneTutorial==FALSE){
        tutorial=true;
        orHereDoneTwice=0;
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
    [self setNewHighScore];
    _passTutorial.position=ccp([[CCDirector sharedDirector] viewSize].width/2, [[CCDirector sharedDirector] viewSize].height/2.5);
    _passTutorial= (passTutorial*) [CCBReader load:@"passTutorial"];
    [self addChild:_passTutorial];
    [self showPlayButton];
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
    }
    [self showPlayButton];
}
-(void)showPlayButton{
    _playTri.position = ccp([[CCDirector sharedDirector] viewSize].width/1.4, [[CCDirector sharedDirector] viewSize].height/2.8);
    [self performSelector:@selector(playButton) withObject:nil afterDelay:0.8];
}
-(void)beatHighScore{
    [self setNewHighScore];
    [self newHighScoreScreen];
}
-(void)setNewHighScore{
    highScore=totalScoreVal;
    perhighScore = [NSNumber numberWithInteger:highScore];
    [MGWU setObject:perhighScore forKey:@"perhighScore"];
    [MGWU submitHighScore:highScore byPlayer:@"ashu" forLeaderboard:@"defaultLeaderboard"];
    [MGWU getHighScoresForLeaderboard:@"defaultLeaderboard" withCallback:@selector(receivedScores:) onTarget:self];
}
- (void)receivedScores:(NSDictionary*)scores
{
    
}
-(void)newHighScoreScreen{
    _gameOver.position=ccp([[CCDirector sharedDirector] viewSize].width/2, [[CCDirector sharedDirector] viewSize].height/2.5);
    _gameOver= (GameOver*) [CCBReader load:@"GameOver"];
    [self addChild:_gameOver];
}
-(void)loserScreen{
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
    [self positionOrHere];
    if(orHereDoneTwice==0 || orHereDoneTwice==1){
        [self performSelector:@selector(showOrHere) withObject:nil afterDelay:0.5];
        orHereDoneTwice+=1;
    }
}
-(void)positionOrHere{
    _Orhere = (Orhere*) [CCBReader load:@"Orhere"];
    if (orHereDoneTwice==0){
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
    else {
        CGFloat oppTouchX2=0;
        CGFloat oppTouchY2=0;
        if(touchLocation.x>200 && oppTouchX>200){
            if(touchLocation.x>oppTouchX){
                oppTouchX2=oppTouchX-100;
            }
            else{
                oppTouchX2=touchLocation.x-100;
            }
        }
        else if (touchLocation.x<200 && oppTouchX<200){
            if(touchLocation.x<oppTouchX){
                oppTouchX2=oppTouchX+100;
            }
            else{
                oppTouchX2=touchLocation.x+100;
            }
        }
        else{
            oppTouchX2=999;
        }
        if (touchLocation.y>150){
            oppTouchY2=touchLocation.y-100;
        }
        else{
            oppTouchY2=touchLocation.y+100;
        }
        if(oppTouchX2!=999){
            oppTouch = CGPointMake(oppTouchX2, oppTouchY2);
            _Orhere.position= oppTouch;
        }
    }
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
