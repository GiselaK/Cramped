//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//
#import "CCPhysics+ObjectiveChipmunk.h"
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
}
- (void)didLoadFromCCB {
    _physicsNode= [CCPhysicsNode node];
    _physicsNode.collisionDelegate = self;
    [self addChild:_physicsNode];
    //    create physics node & make it a child of mainscene
    _physicsNode.debugDraw= TRUE;
    // Debug tool AMAZING
    playButtonOrNah=TRUE;
    // set bool that detects whether or not the triangle is a play button to true
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
    //allow clickin
    [self startScreen];
    //load start screen
}
-(void) startScreen{
    gameStarted=FALSE;
    //says that game has not started yet
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
    [self removeChild:_playTri];
    if (_beginGame.parent){
        [self removeChild:_beginGame];
    }
    if (_gameOver.parent){
        [self removeChild:_gameOver];
    }
    if(!_physicsNode.parent){
        _physicsNode= [CCPhysicsNode node];
        _physicsNode.collisionDelegate = self;
        [self addChild:_physicsNode];
    }
    gameEnd=FALSE;
    gameStarted=TRUE;
    gameEndControl=FALSE;
    playButtonOrNah=FALSE;
    shapeSize=0.002;
    stopGrowth=FALSE;
    [self makeBorder];
    _currentTri.scale=shapeSize;
    _currentTri.position = ccp([[CCDirector sharedDirector] viewSize].width/2, [[CCDirector sharedDirector] viewSize].height/2);
    _currentTri.mainscene= self;
    _currentTri.physicsBody.collisionType = @"Triangle";
    _currentTri.physicsBody.sensor=TRUE;;
    [_physicsNode addChild: _currentTri];
    CCLOG(@"INSIDE rec3");
    alreadyCollided=FALSE;
}
-(void) shapeSpawn{
    stopGrowth=FALSE;
    if(!playButtonOrNah){
        shapeSize=0.001;
        pickShape=arc4random()%2;
        //    CGRect screenBounds = [[UIScreen mainScreen] bounds];
        //    int screenHeight=screenBounds.size.height;
        //    int screenWidth=screenBounds.size.width;
        //    int shapelocx=arc4random()%screenHeight;//screenHeight/2;
        //    int shapelocy=arc4random()%screenWidth;//screenWidth/2;
        rotationAmt=arc4random()%2;
        rotationDir=arc4random()%2;
        if (pickShape==1){
            _currentRect = (Rectangle*) [CCBReader load:@"rect"];
            _currentRect.position = touchLocation;
            _currentRect.rotation=arc4random()%360;
            _currentRect.mainscene= self;
            _currentRect.physicsBody.collisionType = @"Rectangle";
            _currentRect.physicsBody.sensor=TRUE;
            _currentRect.scale=shapeSize;
            [_physicsNode addChild: _currentRect];
        }
        else {
            _currentTri = (Triangle*) [CCBReader load:@"tri"];
            _currentTri.position = touchLocation;
            _currentTri.rotation=arc4random()%360;
            _currentTri.mainscene= self;
            _currentTri.physicsBody.collisionType = @"Triangle";
            _currentTri.physicsBody.sensor=TRUE;
            _currentTri.scale=shapeSize;
            [_physicsNode addChild:_currentTri];
        }
    }
    
}
- (void)update:(CCTime)delta {
//    if (_physicsNode.parent) {
//        _physicsNode.position = ccp(_physicsNode.position.x, _physicsNode.position.y);
//    }
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
    if (rotationAmt==1){
        if (rotationDir==1){
            _currentRect.rotation-=1;
        }
        else{
            _currentRect.rotation+=1;
        }
    }
    else{
        if (rotationDir==1){
            _currentRect.rotation-=1.5;
        }
        else{
            _currentRect.rotation+=1.5;
        }
    }
    _currentRect.mainscene= self;
    _currentRect.physicsBody.collisionType = @"Rectangle";
    _currentRect.physicsBody.sensor=TRUE;
    if (_physicsNode.parent) {
        [_physicsNode addChild: _currentRect];
    }
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
        if (rotationAmt==1){
            if (rotationDir==1){
                _currentTri.rotation-=1;
            }
            else{
                _currentTri.rotation+=1;
            }
        }
        else{
            if (rotationDir==1){
                _currentTri.rotation-=1.5;
            }
            else{
                _currentTri.rotation+=1.5;
            }
        }
    
    _currentTri.mainscene= self;
    _currentTri.physicsBody.collisionType = @"Triangle";
    _currentTri.physicsBody.sensor=TRUE;
    [_physicsNode addChild:_currentTri];
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
-(void)gameEnd{
     gameStarted=FALSE;
     beginGameMode=TRUE;
    playButtonOrNah=TRUE;
    [_physicsNode removeAllChildrenWithCleanup:YES];
        //    [self removeChild:_physicsNode];
    [self removeChild:_physicsNode];
    
        _gameOver= (GameOver*) [CCBReader load:@"GameOver"];
        _gameOver.position=ccp([[CCDirector sharedDirector] viewSize].width/1.1, [[CCDirector sharedDirector] viewSize].height/4);
        [self addChild:_gameOver];
        [self playButton];
    
    
    gameEndControl=TRUE;
}
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CCLOG(@"MAINSCENE TOUCHED");
    touchLocation = [touch locationInNode:self];
    if(playButtonOrNah){
        CCLOG(@"playabttobeclicked");
        [self playClicked];
        CCLOG(@"playclicked");
    }else{
        CCLOG(@"shapeAbtToSpawn");
        [self shapeSpawn];
        CCLOG(@"shapespawned");
    }
}

@end
