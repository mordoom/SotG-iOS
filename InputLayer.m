//
//  InputLayer.m
//  SotG
//
//  Created by Apple on 12/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "InputLayer.h"
#import "GameScene.h"

@implementation InputLayer

-(id) init
{
	if ((self = [super init]))
	{
		[self addFireButton];
        [self addJoystick];
		[self scheduleUpdate];
	}
	
	return self;
}

-(void) dealloc
{
	[super dealloc];
}

-(void) addFireButton
{
    float buttonRadius = 80;
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    fireButton = [[[SneakyButton alloc] initWithRect:CGRectZero] autorelease];
    fireButton.radius = buttonRadius;
    fireButton.position = CGPointMake(screenSize.width-buttonRadius, buttonRadius);
    fireButton.isHoldable = YES;
    
    SneakyButtonSkinnedBase* skinfireButton = [SneakyButtonSkinnedBase skinnedButton];
    skinfireButton.position = CGPointMake(screenSize.width-buttonRadius, buttonRadius);
    //skinfireButton.scale = 0.5f;

    skinfireButton.defaultSprite = [CCSprite spriteWithSpriteFrameName:@"default-button.png"];
    skinfireButton.defaultSprite.opacity = 64;
    skinfireButton.pressSprite = [CCSprite spriteWithSpriteFrameName:@"default-button.png"];
    skinfireButton.pressSprite.color = ccGREEN;
    skinfireButton.pressSprite.opacity = 64;
    
    [self addChild:fireButton];
    [self addChild:skinfireButton];
}

-(void)addJoystick
{
    float stickRadius = 50;
    
    joystick = [SneakyJoystick joystickWithRect:CGRectMake(0, 0, stickRadius, stickRadius)];
    
    joystick.autoCenter = YES;
    joystick.hasDeadzone = YES;
    joystick.deadRadius = 10;
    
    SneakyJoystickSkinnedBase* skinStick = [SneakyJoystickSkinnedBase skinnedJoystick];
    skinStick.position = CGPointMake(stickRadius*1.5f, stickRadius*1.5f);
    skinStick.backgroundSprite = [CCSprite spriteWithSpriteFrameName:@"default-button.png"];
    skinStick.backgroundSprite.color = ccGREEN;
    skinStick.backgroundSprite.opacity = 64;
    
    skinStick.thumbSprite = [CCSprite spriteWithSpriteFrameName:@"default-button.png"];
    skinStick.thumbSprite.opacity = 64;
    skinStick.thumbSprite.color = ccRED;
    skinStick.thumbSprite.scale = 0.5f;
    
    skinStick.joystick = joystick;
    [self addChild:skinStick];
    
}

-(void) update:(ccTime)delta
{
    totalTime += delta;
    
    //Move the ship
    GameScene* game = [GameScene sharedGameScene];
    ShipEntity* ship = [game defaultShip];
    
    //Player is dead
    if (ship.alive == NO)
    {
        return;
    }
    
    //Scale velocity
    CGPoint velocity = ccpMult(joystick.velocity, 200);
    if (velocity.x != 0 && velocity.y !=0)
    {
        ship.position = CGPointMake(ship.position.x + velocity.x *delta, ship.position.y + velocity.y * delta);
    }
    
    //Fire
    if (fireButton.active && totalTime > nextShotTime)
    {
        if (ship.ammunition > 0)
        {
            ship.ammunition--;
        }
        else
        {
            [ship switchToDefaultWeapon];
        }
        
        nextShotTime = totalTime + 0.5f;
        BulletCache* bulletCache = [game bulletCache];
        
        //Set the position, vel and sprite frame
        CGPoint shotpos = CGPointMake(ship.position.x + [ship contentSize].width * 0.5f, ship.position.y- [ship contentSize].width * 0.25f);
        [bulletCache shootBulletAt:shotpos bulletType:ship.currentWeapon isPlayerBullet:YES];
    }
    
    //Allow faster shooting by tapping the fire button
    if (fireButton.active == NO)
    {
        nextShotTime = 0;
    }
}
@end
