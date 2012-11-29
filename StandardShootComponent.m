//
//  StandardShootComponent.m
//  SotG
//
//  Created by Alex Mordue on 18/01/12.
//

#import "StandardShootComponent.h"
#import "GameScene.h"
#import "Bullet.h"
#import "EnemyEntity.h"

@implementation StandardShootComponent
@synthesize shootFrequency;
@synthesize bullet;

-(id) init
{
    if ((self = [super init]))
    {
        [self scheduleUpdate];
    }
    
    return self;
}

-(void) dealloc
{
    [bullet release];
    [super dealloc];
}

-(void) update:(ccTime)delta
{
    EnemyEntity* enemy = (EnemyEntity*)self.parent;
    if (enemy.alive)
    {
        updateCount++;
        
        if (updateCount >= shootFrequency)
        {
            updateCount = 0;
            
            BulletCache* bulletCache = [[GameScene sharedGameScene] bulletCache];
            CGPoint startPos = ccpSub(self.parent.position, CGPointMake(self.parent.contentSize.width * 0.5f, 0));
            [bulletCache shootBulletAt:startPos bulletType:bullet isPlayerBullet:NO];
        }
    }
}

@end
