//
//  EnemySquid.m
//  SotG
//
//  Created by Alex Mordue on 09/02/12.
//

#import "EnemySquid.h"
#import "StandardMoveComponent.h"
#import "StandardShootComponent.h"
@implementation EnemySquid

-(id) initEnemyWithType
{
    //Init enemy squid
    name = @"squid";
    initialHitPoints = 3;
    
    BulletType* bulletType = [[BulletType alloc] init];
    int shootFrequency = 90;
        
    //Same bullets for both enemies
    bulletType.name = @"ink";
    bulletType.damage = 1;
    bulletType.velocity = CGPointMake(-200, 0);
    bulletType.animate = YES;
        
    //Init with the sprite image based on the sprite's name
    if ((self = [super initEnemyWithType]))
    {
        //Create the game logic components
        [self addChild:[StandardMoveComponent node]];
            
        StandardShootComponent* shootComponent = [StandardShootComponent node];
        shootComponent.shootFrequency = shootFrequency;
        shootComponent.bullet = bulletType;
        [self addChild:shootComponent];
    }
        
    //finished with this
    [bulletType release];
    return self;
}

-(id) copy
{
    return [[[EnemySquid alloc] initEnemyWithType] autorelease];
}

-(int) maxCapacity
{
    //return the max number of enemies of this type that can be displayed on-screen
    return 4;
}

+(id) enemyWithType
{
    return [[[self alloc] initEnemyWithType] autorelease];
}

@end
