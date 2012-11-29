//
//  StandardMoveComponent.m
//  SotG
//
//  Created by Alex Mordue on 18/01/12.
//

#import "StandardMoveComponent.h"
#import "Entity.h"
#import "GameScene.h"


@implementation StandardMoveComponent

-(id) init
{
    if ((self = [super init]))
	{
		velocity = CGPointMake(-100, 0);
		[self scheduleUpdate];
	}
    
    return self;
}

-(void) update:(ccTime)delta
{
	if (self.parent.visible)
	{
		NSAssert([self.parent isKindOfClass:[Entity class]], @"node is not a Entity");
		Entity* entity = (Entity*)self.parent;
		
        if (entity.position.x > [GameScene screenRect].size.width * 0.5f)
		{
			[entity setPosition:ccpAdd(entity.position, ccpMult(velocity,delta))];
		}
	}
}


@end
