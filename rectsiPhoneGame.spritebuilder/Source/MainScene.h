//
//  MainScene.h
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "ShapeGrow.h"

@interface MainScene : CCNode <CCPhysicsCollisionDelegate> {
    NSTimer *TimeOfActiveUser;
}
- (void)shapeSpawn;
- (void)updateRect;
- (void)updateTri;
@end
