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
    Rectangle *_currentRect;
    Taphere *_Taphere;
    Orhere *_Orhere;
    CCLabelTTF *_scoreatm;
    CGPoint border1pos;
    CGPoint border2pos;
    CGPoint border3pos;
    CGPoint border4pos;
    CCPhysicsNode *_physicsNode;
    GameOver *_gameOver;
    GameOverLoose *_gameOverLoose;
    NSNumber *perhighScore;
    startTri *_playTri;
    tap *_tap;
    Triangle *_currentTri;
    BOOL alreadyCollided;
    BOOL beginGameMode;
    BOOL doneTutorial;
    BOOL firstShape;
    BOOL gameStarted;
    BOOL tutorialComplete;
    BOOL large;
    BOOL insane;
    BOOL XL;
    BOOL tutorial;
    BOOL OrHere;
    int orHereDoneTwice;
    BOOL tappedOutside;
    float bonusPoints;
    float shapeSize;
    int currentShape;
    int pickShape;
    int numb;
    int rotationAmt;
    int rotationDir;
    int rotationVal;
    int num;

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
    NSNumber *currentHighScore = [MGWU objectForKey:@"perhighScore"];
    highScore = [currentHighScore intValue];
    perhighScore=0;
    highScore=0;
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
    [self addChild: _playTri];
}

-(void)playClicked{
    [self removePhysics];
    [self removeSceen];
    [self addPhysics];
    totalScoreVal=0;
    _scoreatm.string = [NSString stringWithFormat:@"%d", totalScoreVal];
    stackedShapes=0;
    bonusPoints=0;
    bonusPointsInt=0;
    totalShapes=0;
    normpoints=0;
    normPointsInt=0;
    gameEnd=FALSE;
    large=FALSE;
    insane=FALSE;
    XL=FALSE;
    playButtonOrNah=FALSE;
    shapeSize=0.002;
    [self makeBorder];
    alreadyCollided=FALSE;
    gameStarted=TRUE;
    if (tutorial==true) {
        firstShape=TRUE;
    }
    [self decideShape];
    [self tapAnywhere];
}
-(void)tapAnywhere{
    _tap = (tap*) [CCBReader load:@"Tap"];
    [self addChild:_tap];
}
-(void)removeSceen{
    [self removeChild:_playTri];
    if (_beginGame.parent){
        [self removeChild:_beginGame];
    }
    if (_gameOver.parent){
        [self removeChild:_gameOver];
    }
    if (_gameOverLoose.parent){
        [self removeChild:_gameOverLoose];
    }
}
-(void)addPhysics{
    if(!_physicsNode.parent){
        _physicsNode= [CCPhysicsNode node];
        _physicsNode.collisionDelegate = self;
        [self addChild:_physicsNode];
    }
}
-(void)makeBorder{
    float borderHScale=2;
    float borderWScale=2;
    _playRect1.scale=borderHScale;
    _playRect2.scale=borderHScale;
    _playRect3.scale=borderWScale;
    _playRect4.scale=borderWScale;
    _playRect3.rotation=90;
    _playRect4.rotation=90;
    border1pos=ccp([[CCDirector sharedDirector] viewSize].width, [[CCDirector sharedDirector] viewSize].height/2);
    border2pos=ccp(1, [[CCDirector sharedDirector] viewSize].height/2);
    border3pos=ccp([[CCDirector sharedDirector] viewSize].width/2, [[CCDirector sharedDirector]viewSize].height);
    border4pos=ccp([[CCDirector sharedDirector] viewSize].width/2,1);
    _playRect1.position= border1pos;
    _playRect2.position= border2pos;
    _playRect3.position= border3pos;
    _playRect4.position= border4pos;
    [_physicsNode addChild: _playRect1];
    [_physicsNode addChild: _playRect2];
    [_physicsNode addChild: _playRect3];
    [_physicsNode addChild: _playRect4];
}

-(void) shapeSpawn{
    totalShapes+=1;
    large=FALSE;
    XL=FALSE;
    insane=FALSE;
    [self rotationDirection];
    shapeSize=0.001;
    rotationAmt=arc4random()%2;
    [self spawnChosenShape];
    
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
-(void)spawnChosenShape{
    if(firstShape==TRUE){
        firstShape=FALSE;
        pickShape=1;
    }
    if (pickShape==1){
        [self spawnRect];
        currentShape=1;
    }
    else {
        [self spawnTri];
        currentShape=2;
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
    //yooo
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
    if (_currentRect.parent==_physicsNode){
        [_physicsNode removeChild:_currentRect cleanup:YES];
    }
    shapeSize+=0.002;
    normpoints+=0.2;
    normPointsInt = (int) normpoints;
    if (large==false){
        if (_currentRect.boundingBox.size.width>60 && _currentRect.boundingBox.size.width<=120){
            bonusPoints+=2;
            large=TRUE;
        }
    }
    if(XL==false){
        if (_currentRect.boundingBox.size.width>120 && _currentRect.boundingBox.size.width<180){
            bonusPoints+=3;
            XL=TRUE;
        }
    }
    if (insane==FALSE){
        if (_currentRect.boundingBox.size.width>180){
            bonusPoints+=4;
            insane=TRUE;
        }
    }
      bonusPointsInt = (int) bonusPoints;
    _currentRect.scale=shapeSize;
    [self CalcRotation];
    _currentRect.rotation=rotationVal;
    _currentRect.mainscene= self;
    _currentRect.physicsBody.collisionType = @"Rectangle";
    _currentRect.physicsBody.sensor=TRUE;
    [_physicsNode addChild: _currentRect];
}
-(void)updateTri{
    if(_currentTri.parent== _physicsNode){
        [_physicsNode removeChild:_currentTri];
    }
    shapeSize+=0.003;
    normpoints+=0.2;
    normPointsInt = (int) normpoints;
    if (large==false){
        if (_currentTri.boundingBox.size.width>60 && _currentTri.boundingBox.size.width<=120){
            bonusPoints+=2;
            large=TRUE;
        }
    }
    if(XL==false){
        if (_currentTri.boundingBox.size.width>120 && _currentTri.boundingBox.size.width<180){
            bonusPoints+=4;
            XL=TRUE;
        }
    }
    if (insane==FALSE){
        if (_currentTri.boundingBox.size.width>180){
            bonusPoints+=4;
            insane=TRUE;
        }
    }
      bonusPointsInt = (int) bonusPoints;
    _currentTri.scale=shapeSize;
    [self CalcRotation];
    _currentTri.rotation=rotationVal;
    _currentTri.mainscene= self;
    _currentTri.physicsBody.collisionType = @"Triangle";
    _currentTri.physicsBody.sensor=TRUE;
    [_physicsNode addChild:_currentTri];
}
-(void)CalcRotation{
    if (rotationAmt==1){
        if (rotationDir==1){
            rotationVal-=1;
        }
        else{
            rotationVal+=1;
        }
    }
    else{
        if (rotationDir==1){
            rotationVal-=1.5;
        }
        else{
            rotationVal+=1.5;
        }
    }
}

-(void)gameEnd{
    if (totalScoreVal<40 & doneTutorial==FALSE){
        tutorial=true;
        orHereDoneTwice=0;
    }
    if (totalScoreVal>40){
        doneTutorial=TRUE;
        tutorial=FALSE;
    }
    if(_tap.parent){
        [self removeChild:_tap];
    }
    if(_Taphere.parent){
        [self removeChild:_Taphere];
    }
    gameStarted=FALSE;
    playButtonOrNah=TRUE;
    currentShape=0;
//    pickShape=2;
    [self gameOverScreen];
}
-(void)removePhysics{
    [_physicsNode removeAllChildrenWithCleanup:YES];
}
-(void)gameOverScreen{
    if(highScore<totalScoreVal){
        highScore=totalScoreVal;
        perhighScore = [NSNumber numberWithInteger:highScore];
        [MGWU setObject:perhighScore forKey:@"perhighScore"];
        _gameOver.position=ccp([[CCDirector sharedDirector] viewSize].width/2, [[CCDirector sharedDirector] viewSize].height/2.5);
        _gameOver= (GameOver*) [CCBReader load:@"GameOver"];
        [self addChild:_gameOver];
    }
    else{
         _gameOverLoose= (GameOverLoose*) [CCBReader load:@"GameOverLoose"];
        [self addChild:_gameOverLoose];
    }

    _playTri.position = ccp([[CCDirector sharedDirector] viewSize].width/1.4, [[CCDirector sharedDirector] viewSize].height/2);
    [self performSelector:@selector(playButton) withObject:nil afterDelay:0.8];
}
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    touchLocation = [touch locationInNode:self];
    if(_tap.parent){
        [self removeChild:_tap];
    }
    if(_Taphere.parent){
        [self removeChild:_Taphere];
    }
    if(_Orhere.parent){
        [self removeChild:_Orhere];
    }
    if(!playButtonOrNah && !gameEnd){
        [self updateScore];
        [self shapeSpawn];
        [self decideShape];
        if (tutorial==true) {
             [self tapHere];
        }
        CCLOG(@"WTF MAN!");
    }
}
-(void)tapHere{
    _Taphere = (Taphere*) [CCBReader load:@"Taphere"];
    _Taphere.position= touchLocation;
    [self addChild:_Taphere];
    [self Orhere];
    if(orHereDoneTwice==0 || orHereDoneTwice==1){
        [self performSelector:@selector(showOrHere) withObject:nil afterDelay:0.5];
        orHereDoneTwice+=1;
    }
}
-(void)Orhere{
    CGFloat oppTouchX;
    CGFloat oppTouchY;
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
    CCLOG(@"xaxis:%f",touchLocation.x);
    CCLOG(@"yaxis:%f",touchLocation.y);
    CGPoint oppTouch = CGPointMake(oppTouchX, oppTouchY);
    _Orhere.position= oppTouch;
}
-(void)showOrHere{
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
