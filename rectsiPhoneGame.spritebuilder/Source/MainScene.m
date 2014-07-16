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

@implementation MainScene
{
    Rectangle *_currentRect;
    Triangle *_currentTri;
    CCPhysicsNode *_physicsNode;
    
}
- (void)didLoadFromCCB {
    _physicsNode= [CCPhysicsNode node];
    [self addChild:_physicsNode];
    _physicsNode.collisionDelegate = self;
}
-(void)onEnter{
    [super onEnter];
    [self shapeSpawn];
}

-(void) shapeSpawn{
    int pickShape= arc4random()%2;
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    int screenHeight=screenBounds.size.height;
    int screenWidth=screenBounds.size.width;
    int shapelocx=arc4random()%screenHeight;
    int shapelocy=arc4random()%screenWidth;

    if (pickShape==1){
        _currentRect = (Rectangle*) [CCBReader load:@"rect"];
        //_currentRect.color=[CCColor redColo];
        _currentRect.position = CGPointMake(shapelocx, shapelocy);
        _currentRect.mainscene= self;
        _currentRect.physicsBody.collisionType = @"Rectangle";
        _currentRect.physicsBody.sensor=TRUE;
//        _currentRect.scale=0.1;
        [_physicsNode addChild: _currentRect];
        CCLOG(@"rectadded");
    }
    else {
        _currentTri = (Triangle*) [CCBReader load:@"tri"];
        _currentTri.position = CGPointMake(shapelocx, shapelocy);
        _currentTri.mainscene= self;
        _currentTri.physicsBody.collisionType = @"Triangle";
        _currentTri.physicsBody.sensor=TRUE;
//        _currentTri.scale=0.1;
        [_physicsNode addChild:_currentTri];
        CCLOG(@"triadded");
    }
}
- (void)update:(CCTime)delta {
    _physicsNode.position = ccp(_physicsNode.position.x, _physicsNode.position.y);
}
-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair Triangle:(CCNode *)Triangle Rectangle:(CCNode *)Rectangle {
    NSLog(@"Game Over");
    return TRUE;
}


@end
