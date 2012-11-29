//
//  EnemyBigShell.m
//  SotG
//
//  Created by Alex Mordue on 21/02/12.
//

#import "EnemyBigShell.h"
#import "StandardMoveComponent.h"
#import "StandardShootComponent.h"

@implementation EnemyBigShell

-(id) initEnemyWithType
{
    //Init enemy spike
    name = @"shelled-squid";
    initialHitPoints = 7;
    
    BulletType* bulletType = [[BulletType alloc] init];
    int shootFrequency = 60;
    
    //Same bullets for both enemies
    bulletType.name = @"ink";
    bulletType.damage = 2;
    bulletType.velocity = CGPointMake(-300, 0);
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

-(int) maxCapacity
{
    //return the max number of enemies of this type that can be displayed on-screen
    return 1;
}

-(id) copy
{
    return [[[EnemyBigShell alloc] initEnemyWithType] autorelease];
}

+(id) enemyWithType
{
    return [[[self alloc] initEnemyWithType] autorelease];
}
@end