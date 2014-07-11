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
    ShapeGrow *_shapeGrow;
}
-(void)onEnter{
    CCLOG(@"YOOO");
    [super onEnter];
    _shapeGrow = [[ShapeGrow alloc]init];
    _shapeGrow.shapegrow = self;
}
-(void)shouldspawn{
    CCLOG(@"shouldbespawing");
    [self spawnShape];
}
-(void) spawnShape{
    CCLOG(@"Pleaase spawn");
    int pickShape= arc4random()%2;
    int shapelocx=arc4random()%400;
    int shapelocy=arc4random()%400;
    int red = arc4random() % 255;
    int green = arc4random() % 255;
    int blue = arc4random() % 255;
    if (pickShape==1){
        _currentRect = (Rectangle*) [CCBReader load:@"rect"];
        _currentRect.position = CGPointMake(shapelocx, shapelocy);
        _currentRect.color = [CCColor colorWithRed:red/255.f green:green/255.f blue:blue/255.f];
        [self addChild: _currentRect];
        CCLOG(@"rectadded");
    }
    else {
        _currentTri = (Triangle*) [CCBReader load:@"tri"];
        _currentTri.position = CGPointMake(shapelocx, shapelocy);
        _currentTri.color = [CCColor colorWithRed:red/255.f green:green/255.f blue:blue/255.f];
        [self addChild: _currentTri];
        CCLOG(@"triadded");
    }
}



@end
