//
//  ShipEntity.m
//  SotG
//
//  Created by Alex Mordue on 18/01/12.
//

#import "ShipEntity.h"
#import "CCAnimationHelper.h"
#import "HealthbarComponent.h"
#import "GameScene.h"
#import "PowerupEntity.h"

@interface ShipEntity(PrivateMethods)
-(id) initWithShipImage;
@end

@implementation ShipEntity
@synthesize alive;
@synthesize hitPoints;
@synthesize initialHitPoints;
@synthesize currentWeapon;
@synthesize ammunition;

+(id) ship
{
	return [[[self alloc] initWithShipImage] autorelease];
}

-(void) gotHit:(int)damage
{
    //Need to decrement HP and die if HP is 0
    hitPoints-=damage;
    
    if (hitPoints <= 0)
    {
        alive = NO;
        
        GameScene* game = [GameScene sharedGameScene];
        [game gameOver];
        
        //Stop animation
        [self stopAllActions];
        
        // create an animation object from all the sprite animation frames
        CCAnimation* anim = [CCAnimation animationWithFrame:@"ship-die" frameCount:5 delay:0.20f];
        
        // run the animation by using the CCAnimate action
        CCAnimate* animate = [CCAnimate actionWithAnimation:anim];
        //CCSequence* animateThenHide = [CCSequence actions:animate, [CCHide action], nil];
        CCMoveTo* move = [CCMoveTo actionWithDuration:1 position:CGPointMake([self position].x, [self contentSize].height)];
        CCSequence* animateAndCrash = [CCSequence actions:move, animate, [CCHide action],nil];
        [self runAction:animateAndCrash];
    }
}

-(id) initWithShipImage
{
	if ((self = [super initWithSpriteFrameName:@"ship0.png"]))
	{
        // create an animation object from all the sprite animation frames
		CCAnimation* anim = [CCAnimation animationWithFrame:@"ship" frameCount:5 delay:0.08f];
		
		// run the animation by using the CCAnimate action
		CCAnimate* animate = [CCAnimate actionWithAnimation:anim];
		CCRepeatForever* repeat = [CCRepeatForever actionWithAction:animate];
		[self runAction:repeat];
        
        //Initialise ship
        alive = YES;
        initialHitPoints = 5;
        hitPoints = initialHitPoints;
        currentWeapon = [[BulletType alloc] init];
        [self switchToDefaultWeapon];
        ammunition = 0;
	}
	return self;
}

-(void) switchToDefaultWeapon
{
    currentWeapon.name = @"bullet";
    currentWeapon.damage = 1;
    currentWeapon.velocity = CGPointMake(200, 0);
    currentWeapon.animate = YES;
}

-(void) useRandomPowerup
{
    PowerupTypes powerup;
    powerup = (arc4random() % PowerupType_MAX);
    switch (powerup) {
        case PowerupTypeHealth:
            hitPoints = initialHitPoints;
            break;
        case PowerupTypeLaserWeapon:
            currentWeapon.name = @"laser";
            currentWeapon.damage = 2;
            currentWeapon.velocity = CGPointMake(300, 0);
            currentWeapon.animate = YES;
            ammunition = 20;
            break;
        case PowerupTypeHarpoonWeapon:
            currentWeapon.name = @"harpoon";
            currentWeapon.damage = 3;
            currentWeapon.velocity = CGPointMake(350, 0);
            currentWeapon.animate = NO;
            ammunition = 10;
        default:
            break;
    }
}

-(void) dealloc
{
    [currentWeapon release];
    [super dealloc];
}

@end