//
//  EnemyEntity.m
//  SotG
//
//  Created by Alex Mordue on 18/01/12.
//

#import "EnemyEntity.h"
#import "GameScene.h"
#import "CCAnimationHelper.h"
#import "StandardShootComponent.h"
#import "StandardMoveComponent.h"
#import "EnemySquid.h"
#import "EnemySpike.h"

@implementation EnemyEntity
@synthesize name;
@synthesize initialHitPoints;
@synthesize hitPoints;
@synthesize alive;

static CCArray* spawnFrequency;

-(id) copy
{
    return [[EnemyEntity alloc] initEnemyWithType];
}

-(void) initSpawnFrequency
{
    //Initialise how frequent enemies will spawn
    if (spawnFrequency == nil)
    {
        spawnFrequency = [[CCArray alloc] initWithCapacity:EnemyType_MAX];
        [spawnFrequency insertObject:[NSNumber numberWithInt:140] atIndex:EnemyTypeSquid];
        [spawnFrequency insertObject:[NSNumber numberWithInt:600] atIndex:EnemyTypeSpike];
        
        //spawn one immediately
        //[self spawn];
    }
}

+(int) getSpawnFrequencyForEnemyType:(EnemyTypes)enemyType
{
    NSAssert(enemyType < EnemyType_MAX, @"invalid enemy type");
    NSNumber* number = [spawnFrequency objectAtIndex:enemyType];
    return [number intValue];
}

-(void) spawn
{
    //Select a spawn location just outside the right side of the screen
    CGRect screenRect = [GameScene screenRect];
    CGSize spriteSize = [self contentSize];
    float xpos = screenRect.size.width - spriteSize.width*0.5f;
    float ypos = CCRANDOM_0_1() * (screenRect.size.height - spriteSize.height) + spriteSize.height * 0.5f;
    
    self.position = CGPointMake(xpos, ypos);
    
    //Set enemy to visible (in use)
    self.visible  = YES;
    
    //Give enemy hp
    hitPoints = initialHitPoints;
    alive = YES;
}

-(id) initEnemyWithType
{    
    //Init with the sprite image based on the sprite's name
    if ((self = [super initWithSpriteFrameName:[NSString stringWithFormat:@"%@%i.png", name, 0]]))
    {
        //Enemies start invisible
        self.visible = NO;
        [self initSpawnFrequency];
    }
    
    return self;
}

+(id) enemyWithType
{
    return [[[self alloc] initEnemyWithType] autorelease];
}

-(int) maxCapacity
{
    //return the max number of enemies of this type that can be displayed on-screen
    return 0;
}

-(void) gotHit:(int)damage
{
    //Need to decrement HP and die if HP is 0
    hitPoints-=damage;
    
    if (hitPoints <= 0)
    {
        alive = NO;
        
        //Update score
        [[GameScene sharedGameScene].scoreComponent updateScore:50];

        // create an animation object from all the sprite animation frames
        CCAnimation* anim = [CCAnimation animationWithFrame:name frameCount:5 delay:0.15f];
        
        // run the animation by using the CCAnimate action
        CCAnimate* animate = [CCAnimate actionWithAnimation:anim];
        CCSequence* animateThenHide = [CCSequence actions:animate, [CCHide action], nil];
        [self runAction:animateThenHide];
        [[GameScene sharedGameScene] enemyCache].enemiesKilled++;
    }
}

-(void) dealloc
{
    [spawnFrequency release];
    spawnFrequency = nil;
    [super dealloc];
}

@end
