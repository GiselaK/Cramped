//
//  BorderLine.m
//  rectsiPhoneGame
//
//  Created by Gisela Kottmeier on 7/24/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "BorderLine.h"

extern int borderColor;
@implementation BorderLine
{    CCSprite *_borderLine;
}
-(void)update:(CCTime)delta{
    if(borderColor==1){
        _borderLine.color= [CCColor blueColor];
    }
    else if (borderColor==2){
        _borderLine.color= [CCColor greenColor];
    }
}

@end
