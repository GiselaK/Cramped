//
//  PlayScreen.h
//  Cramped
//
//  Created by Gisela Kottmeier on 8/4/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@class MainScene;
@interface PlayScreen : CCNode {
    NSTimer *TimeOfActiveUser;
}
@property (nonatomic,retain) MainScene* mainscene;
@end
