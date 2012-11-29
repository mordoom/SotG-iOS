//
//  EnemySpike.m
//  SotG
//
//  Created by Alex Mordue on 10/02/12.
//

#import "EnemySpike.h"
#import "WaitComponent.h"
#import "StandardShootComponent.h"

@implementation EnemySpike
-(id) initEnemyWithType
{
    //Init enemy spike
    name = @"spike";
    initialHitPoints = 5;
    
    BulletType* bulletType = [[BulletType alloc] init];
    int shootFrequency = 60;
    
    //Same bullets for both enemies
    bulletType.name = @"ink";
    bulletType.damage = 1;
    bulletType.velocity = CGPointMake(-300, 0);
    bulletType.animate = YES;
    
    //Init with the sprite image based on the sprite's name
    if ((self = [super initEnemyWithType]))
    {
        //Create the game logic components
        [self addChild:[WaitComponent node]];
        
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
    return 2;
}

-(id) copy
{
    return [[[EnemySpike alloc] initEnemyWithType] autorelease];
}

+(id) enemyWithType
{
    return [[[self alloc] initEnemyWithType] autorelease];
}
@end
