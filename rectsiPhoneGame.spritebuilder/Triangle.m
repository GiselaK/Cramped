//
//  Triangle.m
//  rectsiPhoneGame
//
//  Created by Gisela Kottmeier on 7/8/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "Triangle.h"


@implementation Triangle{
    CCSprite *_triLine1;
    CCSprite *_triLine2;
    CCSprite *_triLine3;
}
-(void)onEnter{
    [super onEnter];
    _triLine1.color=[CCColor greenColor];
    _triLine2.color=[CCColor greenColor];
    _triLine3.color=[CCColor greenColor];
}
@end
