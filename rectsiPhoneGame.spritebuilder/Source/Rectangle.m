//
//  Rectangle.m
//  rectsiPhoneGame
//
//  Created by Gisela Kottmeier on 7/3/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "Rectangle.h"

@implementation Rectangle{
    CCSprite *_rectLine1;
    CCSprite *_rectLine2;
    CCSprite *_rectLine3;
    CCSprite *_rectLine4;
}
-(void)onEnter{
    [super onEnter];
    _rectLine1.color=[CCColor blueColor];
    _rectLine2.color=[CCColor blueColor];
    _rectLine3.color=[CCColor blueColor];
    _rectLine4.color=[CCColor blueColor];
}
@end
