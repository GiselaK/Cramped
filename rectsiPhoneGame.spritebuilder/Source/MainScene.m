//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "shapeGrow.h"
#import "Rectangle.h"
#import "Triangle.h"

@implementation MainScene
{
    Rectangle *_currentRect;
    Triangle *_currentTri;
}
-(void)onEnter{
    CCLOG(@"YOOO");
    [super onEnter];
    [self shapeSpawn];
}

-(void) shapeSpawn{
    CCLOG(@"Pleaase spawn");
    int pickShape= arc4random()%2;
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    int screenHeight=screenBounds.size.height;
    int screenWidth=screenBounds.size.width;
    int shapelocx=arc4random()%screenWidth;
    int shapelocy=arc4random()%screenHeight;

    if (pickShape==1){
        _currentRect = (Rectangle*) [CCBReader load:@"rect"];
        //_currentRect.color=[CCColor redColo];
        _currentRect.position = CGPointMake(shapelocx, shapelocy);
        [self addChild: _currentRect];
        _currentRect.mainscene= self;
        CCLOG(@"rectadded");
    }
    else {
      
        _currentTri = (Triangle*) [CCBReader load:@"tri"];
        _currentTri.position = CGPointMake(shapelocx, shapelocy);
        [self addChild: _currentTri];
        _currentTri.mainscene= self;
        CCLOG(@"triadded");
    }
}



@end
