//
//  shapeGrow.h
//  rectsiPhoneGame
//
//  Created by Gisela Kottmeier on 7/9/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MainScene.h"

@interface ShapeGrow : CCNode {
    NSTimer *TimeOfActiveUser;
}
@property (nonatomic,retain) MainScene* shapegrow;
@end
