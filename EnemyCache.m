//
//  EnemyCache.m
//  SotG
//
//  Created by Alex Mordue on 18/01/12.

//

#import "EnemyCache.h"
#import "EnemyEntity.h"
#import "EnemySquid.h"
#import "EnemySpike.h"
#import "GameScene.h"

@implementation EnemyCache
@synthesize enemiesKilled;
static const int MAX_ENEMY_COUNT = 25;

-(void) initEnemies
{   
    //array of enemy types for use
    types = [[CCArray alloc] initWithCapacity:EnemyType_MAX];
    [types insertObject:[EnemySquid enemyWithType] atIndex:EnemyTypeSquid];
    [types insertObject:[EnemySpike enemyWithType] atIndex:EnemyTypeSpike];
    
    //create the enemies array containing further arrays for each type
    enemies = [[CCArray alloc]initWithCapacity:EnemyType_MAX];
    
    //Create the arrays for each type
    for (int i = 0; i < EnemyType_MAX; i++)
    {        
        EnemyEntity* enemy = [types objectAtIndex:i];
        int capacity = [enemy maxCapacity];
        CCArray* enemiesOfType = [CCArray arrayWithCapacity:capacity];
        [enemies addObject:enemiesOfType];
    }
    
    for (int i = 0; i < EnemyType_MAX; i++)
    {
        CCArray* enemiesOfType = [enemies objectAtIndex:i];
        int numEnemiesOfType = [enemiesOfType capacity];
        
        for (int j = 0; j < numEnemiesOfType; j++)
        {
            EnemyEntity* enemy = [[types objectAtIndex:i] copy];
            [batch addChild:enemy z:0 tag:i];
            [enemiesOfType addObject:enemy];
        }
    }
}

-(void) spawnEnemyOfType:(EnemyTypes)enemyType
{
    CCArray* enemiesOfType = [enemies objectAtIndex:enemyType];
    
    EnemyEntity* enemy;
    CCARRAY_FOREACH(enemiesOfType, enemy)
    {
        //find the first free enemy and respawn it
        if (enemy.visible == NO)
        {
            [enemy spawn];
            break;
        }
    }
}

-(void) checkForBulletCollisions
{
    EnemyEntity* enemy;
    BulletCache* bulletCache = [[GameScene sharedGameScene] bulletCache];
    
    //Remove colliding bullets
    [bulletCache removeCollidingBullets];
    
    CCARRAY_FOREACH([batch children], enemy)
    {
        if (enemy.alive)
        {
            //Find out how much damage to apply (can be zero)
            int damage = [bulletCache isPlayerBulletCollidingWithRect:[enemy boundingBox]];
            [enemy gotHit:damage];
        }
    }
    
    //Check for player collisions
    ShipEntity* ship = [[GameScene sharedGameScene] defaultShip];
    if (ship.alive)
    {
        //Find out how much damage to apply (can be zero)
        int damage = [bulletCache isEnemyBulletCollidingWithRect:[ship boundingBox]];
        [ship gotHit:damage];
    }
}

-(bool) enemiesClear
{
    bool cleared = true;
    EnemyEntity* enemy;
    
    //Find out if any enemies are still alive
    CCARRAY_FOREACH([batch children], enemy)
    {
        if (enemy.alive)
        {
            cleared = false;
            break;
        }
    }

    return cleared;
}

-(void) update:(ccTime)delta
{
    updateCount++;
    
    if (enemiesKilled < MAX_ENEMY_COUNT)
    {
        //Spawn enemies when it is their time to spawn as per spawn freq
        for (int i = EnemyType_MAX -1; i>=0; i--)
        {
            int spawnFrequency = [EnemyEntity getSpawnFrequencyForEnemyType:i];
        
            if (updateCount % spawnFrequency == 0)
            {
                [self spawnEnemyOfType:i];
                break;
            }
        }
    }
    else if ([self enemiesClear])
    {
        [[GameScene sharedGameScene] levelCleared];
        [self unscheduleUpdate];
    }
        
    [self checkForBulletCollisions];
}


-(id) init
{
    if ((self = [super init]))
    {
        //get any image from the texture atlas
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"squid0.png"];
        batch = [CCSpriteBatchNode batchNodeWithTexture:frame.texture];
        [self addChild:batch];
        
        [self initEnemies];
        [self scheduleUpdate];
    }
    
    return self;
}


-(void) dealloc
{
    [types release];
    [enemies release];
    [super dealloc];
}

@end
