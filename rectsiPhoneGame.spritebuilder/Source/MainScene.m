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

BOOL playButtonOrNah;
BOOL gameEndControl;
BOOL gameEnd;
CGPoint touchLocation;
@implementation MainScene
{
    BeginGame *_beginGame;
    BorderLine *_playRect1;
    BorderLine *_playRect2;
    BorderLine *_playRect3;
    BorderLine *_playRect4;
    Rectangle *_currentRect;
    CCPhysicsNode *_physicsNode;
    GameOver *_gameOver;
    startTri *_playTri;
    Triangle *_currentTri;
    BOOL alreadyCollided;
    BOOL beginGameMode;
    BOOL gameStarted;
    BOOL stopGrowth;
    float shapeSize;
    int pickShape;
    int rotationAmt;
    int rotationDir;
    int rotationVal;
}
- (void)didLoadFromCCB {
    [self setupPhysics];
    [self loadCCBS];
}
-(void)setupPhysics{
    _physicsNode= [CCPhysicsNode node];
    _physicsNode.collisionDelegate = self;
    [self addChild:_physicsNode];
    _physicsNode.debugDraw= TRUE;
}
-(void)loadCCBS{
    _currentTri = (Triangle*) [CCBReader load:@"tri"];
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
    gameStarted=FALSE;
    beginGameMode=TRUE;
    [self playScreen];
    //Loads PlayScreen
    [self playButton];
    //Loads Play Button
}
-(void)playScreen{
    _beginGame= (BeginGame*) [CCBReader load:@"PlayScreen"];
    _beginGame.position=ccp([[CCDirector sharedDirector] viewSize].width/2, [[CCDirector sharedDirector] viewSize].height/1.15);
    _beginGame.rotation=270;
    [self addChild:_beginGame];
}
-(void) playButton{
    playButtonOrNah=TRUE;
    _playTri.scale=0.2;
    _playTri.rotation=90;
    _playTri.position = ccp([[CCDirector sharedDirector] viewSize].width/2, [[CCDirector sharedDirector] viewSize].height/2);
    [self addChild: _playTri];
    //    _currentTri.physicsBody.collisionType = @"Triangle";
    //    _currentTri.physicsBody.sensor=FALSE;
    //     _playRect.mainscene= self;
    //    int screenHeight=
    //    _currentTri.physicsBody.collisionType = @"Triangle";
    //    _currentTri.physicsBody.sensor=FALSE;
}

-(void)playClicked{
    [self removePhysics];
    [self removeSceen];
    [self addPhysics];
    gameEnd=FALSE;
    gameEndControl=FALSE;
    gameStarted=TRUE;
    playButtonOrNah=FALSE;
    stopGrowth=FALSE;
    shapeSize=0.002;
    [self makeBorder];
    _currentTri.position = ccp([[CCDirector sharedDirector] viewSize].width/2, [[CCDirector sharedDirector] viewSize].height/2);
    _currentTri.scale=shapeSize;
    _currentTri.mainscene= self;
    _currentTri.physicsBody.collisionType = @"Triangle";
    _currentTri.physicsBody.sensor=TRUE;;
    [_physicsNode addChild: _currentTri];
    _physicsNode.debugDraw= TRUE;
    alreadyCollided=FALSE;
}
-(void)removeSceen{
    [self removeChild:_playTri];
    if (_beginGame.parent){
        [self removeChild:_beginGame];
    }
    if (_gameOver.parent){
        [self removeChild:_gameOver];
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
    _playRect1.position = ccp([[CCDirector sharedDirector] viewSize].width, [[CCDirector sharedDirector] viewSize].height/2);
    _playRect2.position = ccp(1, [[CCDirector sharedDirector] viewSize].height/2);
    _playRect3.position = ccp([[CCDirector sharedDirector] viewSize].width/2, [[CCDirector sharedDirector]viewSize].height);
    _playRect4.position = ccp([[CCDirector sharedDirector] viewSize].width/2,1);
    [_physicsNode addChild: _playRect1];
    [_physicsNode addChild: _playRect2];
    [_physicsNode addChild: _playRect3];
    [_physicsNode addChild: _playRect4];
}

-(void) shapeSpawn{
    [self rotationDirection];
    stopGrowth=FALSE;
    if(!playButtonOrNah){
        shapeSize=0.001;
        rotationAmt=arc4random()%2;
        [self decideShape];
        //    CGRect screenBounds = [[UIScreen mainScreen] bounds];
        //    int screenHeight=screenBounds.size.height;
        //    int screenWidth=screenBounds.size.width;
        //    int shapelocx=arc4random()%screenHeight;//screenHeight/2;
        //    int shapelocy=arc4random()%screenWidth;//screenWidth/2;
    }
    
}
-(void)decideShape{
       pickShape=arc4random()%2;
//        pickShape=2;
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
}
-(void)spawnTri{
    _currentTri = (Triangle*) [CCBReader load:@"tri"];
    _currentTri.position = touchLocation;
    _currentTri.rotation=arc4random()%360;
    _currentTri.mainscene= self;
    _currentTri.physicsBody.collisionType = @"Triangle";
    _currentTri.physicsBody.sensor=TRUE;
    _currentTri.scale=shapeSize;
    [_physicsNode addChild:_currentTri];
}
- (void)update:(CCTime)delta {
    if(stopGrowth==FALSE && !playButtonOrNah &&!gameEnd){
        if(pickShape==1){
            [self updateRect];
        }
        else{
            [self updateTri];
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
    _currentRect.scale=shapeSize;
    [self CalcRotation];
    _currentRect.rotation=rotationVal;
    _currentRect.mainscene= self;
    _currentRect.physicsBody.collisionType = @"Rectangle";
    _currentRect.physicsBody.sensor=TRUE;
    [_physicsNode addChild: _currentRect];
}
-(void)updateTri{
    if(_currentTri.parent == self){
        [self removeChild:_currentTri];
    }
    else if(_currentTri.parent== _physicsNode){
        [_physicsNode removeChild:_currentTri];
    }
    shapeSize+=0.003;
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
    gameStarted=FALSE;
    beginGameMode=TRUE;
    playButtonOrNah=TRUE;
    pickShape=2;
    [self gameOverScreen];
    gameEndControl=TRUE;
}
-(void)removePhysics{
    [_physicsNode removeAllChildrenWithCleanup:YES];
    [self removeChild:_physicsNode];
}
-(void)gameOverScreen{
    _gameOver= (GameOver*) [CCBReader load:@"GameOver"];
    _gameOver.position=ccp([[CCDirector sharedDirector] viewSize].width/1.1, [[CCDirector sharedDirector] viewSize].height/4);
    [self addChild:_gameOver];
    [self playButton];
}
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    touchLocation = [touch locationInNode:self];
    if(playButtonOrNah){
        [self playClicked];
    }else{
        [self shapeSpawn];
    }
}
//-(void)updateBorder{
//    CGSize screenBounds = [[CCDirector sharedDirector] viewSize];
//    int screenHeight=screenBounds.height;
//    int screenWidth=screenBounds.width;
//    if (screenWidth>_playRect1.boundingBox.size.width){
//        _playRect1.scale+=0.004;
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
