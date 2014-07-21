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
float shapeSize;
BOOL allowUpdates=TRUE;
int pickShape;
BOOL checkCollision=TRUE;
BOOL playButton=TRUE;
@implementation MainScene
{
    Rectangle *_currentRect;
    Triangle *_currentTri;
    CCPhysicsNode *_physicsNode;
    int rect;
    int tri;
    int rotationAmt;
    bool gameEnd;
}
- (void)didLoadFromCCB {
    _physicsNode= [CCPhysicsNode node];
    [self addChild:_physicsNode];
    _physicsNode.collisionDelegate = self;
    rect=1;
    tri=1;
    _physicsNode.debugDraw= TRUE;
}
-(void)onEnter{
    [super onEnter];
    [self startScreen];
}
-(void) startScreen{
    _currentTri = (Triangle*) [CCBReader load:@"tri"];
    _currentTri.position = ccp([[CCDirector sharedDirector] viewSize].width/2, [[CCDirector sharedDirector] viewSize].height/2);
    _currentTri.scale=1000;
    _currentTri.mainscene= self;
    _currentTri.physicsBody.collisionType = @"Triangle";
    _currentTri.physicsBody.sensor=TRUE;
    [_physicsNode addChild: _currentTri];
}
-(void) shapeSpawn{
    shapeSize=0.001;
    pickShape= arc4random()%2;
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    int screenHeight=screenBounds.size.height;
    int screenWidth=screenBounds.size.width;
    int shapelocx=screenHeight/2;//arc4random()%screenHeight;
    int shapelocy=screenWidth/2;//arc4random()%screenWidth;
    rotationAmt=arc4random()%3;

    if (pickShape==1){
        CCLOG(@"RECTANGLE ");
        _currentRect = (Rectangle*) [CCBReader load:@"rect"];
        _currentRect.position = CGPointMake(shapelocx, shapelocy);
        _currentRect.rotation=arc4random()%360;
        _currentRect.mainscene= self;
        _currentRect.physicsBody.collisionType = @"Rectangle";
        _currentRect.physicsBody.sensor=TRUE;
        _currentRect.scale=shapeSize;
        [_physicsNode addChild: _currentRect];
        //_currentRect.color=[CCColor redColo];
                CCLOG(@"rectadded");
    }
    else {
        CCLOG(@"TRIANGLE");
        _currentTri = (Triangle*) [CCBReader load:@"tri"];
        _currentTri.position = CGPointMake(shapelocx, shapelocy);
        _currentTri.rotation=arc4random()%360;
        _currentTri.mainscene= self;
        _currentTri.physicsBody.collisionType = @"Triangle";
        _currentTri.physicsBody.sensor=TRUE;
        _currentTri.scale=shapeSize;
        [_physicsNode addChild:_currentTri];
        CCLOG(@"triadded");
    }
    
}
- (void)update:(CCTime)delta {
    _physicsNode.position = ccp(_physicsNode.position.x, _physicsNode.position.y);
    [self gameEnd];
}
-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair Triangle:(CCNode *)Triangle wildcard:(CCNode *)nodeB {
    gameEnd=true;
    return TRUE;
}
-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair Rectangle:(CCNode *)Rectangle wildcard:(CCNode *)nodeB {
    gameEnd=true;
        NSLog(@"Game Over");
        return TRUE;

}
-(void)updateRect{
    [_physicsNode removeChild:_currentRect cleanup:YES];
    shapeSize+=0.005;
    if (rotationAmt==1){
        _currentRect.rotation+=1;
    }
    else{
        _currentRect.rotation+=3;
    }
    _currentRect.mainscene= self;
    _currentRect.physicsBody.collisionType = @"Rectangle";
    _currentRect.physicsBody.sensor=TRUE;
    _currentRect.scale=shapeSize;
    allowUpdates=TRUE;
    [_physicsNode addChild: _currentRect];
}
-(void)updateTri{
    [_physicsNode removeChild:_currentTri cleanup:YES];
    if(!playButton) {
        shapeSize+=0.005;
        _currentTri.scale=shapeSize;
        if (rotationAmt==1){
            _currentTri.rotation+=1;
        }
        else{
            _currentTri.rotation+=3;
        }
    }
    else{
        shapeSize=0.2;
        _currentTri.scale=shapeSize;
        _currentTri.rotation=90;
    }
    _currentTri.mainscene= self;
    _currentTri.physicsBody.collisionType = @"Triangle";
    _currentTri.physicsBody.sensor=TRUE;
    allowUpdates=TRUE;
    [_physicsNode addChild:_currentTri];
}

-(void)gameEnd{
    if (gameEnd){
        GameOver *_gameOver= (GameOver*) [CCBReader load:@"GameOver"];
        [self addChild:_gameOver];
        _gameOver.position=ccp([[CCDirector sharedDirector] viewSize].width/2, [[CCDirector sharedDirector] viewSize].height/2);
    }
}
//-(void)checkGrowth{
//    if(pickShape==1){
//        _currentRect.scale=shapeSize;
//    }
//    else{
//        _currentTri.scale=shapeSize;
//    }
//}


@end
