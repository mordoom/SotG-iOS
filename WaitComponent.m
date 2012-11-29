//
//  WaitComponent.m
//  SotG
//
//  Created by Alex Mordue on 13/02/12.
//

#import "WaitComponent.h"
#import "GameScene.h"
#import "ShipEntity.h"
#import "EnemyEntity.h"

@implementation WaitComponent
-(id) init
{
    if ((self = [super init]))
	{
		velocity = CGPointMake(-200, 0);
		[self scheduleUpdate];
	}
    
    return self;
}

-(void) update:(ccTime)delta
{
	if (self.parent.visible)
	{
		NSAssert([self.parent isKindOfClass:[EnemyEntity class]], @"node is not a Entity");
		
		EnemyEntity* entity = (EnemyEntity*)self.parent;
		if (entity.hitPoints == 1 && entity.position.x > [GameScene screenRect].size.width * 0.25f)
		{
			[entity setPosition:ccpAdd(entity.position, ccpMult(velocity,delta))];
            
            //collision with player
            ShipEntity* ship = [[GameScene sharedGameScene] defaultShip];
            if (CGRectIntersectsRect([self.parent boundingBox], [ship boundingBox]))
            {
                [ship gotHit:1];
            }
            
		}
	}
}
@end
