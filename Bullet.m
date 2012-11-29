//
//  Bullet.m
//  SpriteBatches
//
//  Created by Steffen Itterheim on 04.08.10.
//
//  Updated by Andreas Loew on 20.06.11:
//  * retina display
//  * framerate independency
//  * using TexturePacker http://www.texturepacker.com
//
//  Copyright Steffen Itterheim and Andreas Loew 2010-2011. 
//  All rights reserved.
//

#import "Bullet.h"
#import "CCAnimationHelper.h"
#import "GameScene.h"
#import "BulletCache.h"

@interface Bullet (PrivateMethods)
-(id) initWithBulletImage;
@end

@implementation Bullet
@synthesize isPlayerBullet;
@synthesize alive;
@synthesize type;

+(id) bullet
{
	return [[[self alloc] initWithBulletImage] autorelease];
}

static CGRect screenRect;

-(id) initWithBulletImage
{
	// Uses the Texture Atlas now.
	if ((self = [super initWithSpriteFrameName:@"bullet0.png"]))
	{
        // make sure to initialize the screen rect only once
		if (CGRectIsEmpty(screenRect))
		{
			CGSize screenSize = [[CCDirector sharedDirector] winSize];
			screenRect = CGRectMake(0, 0, screenSize.width, screenSize.height);
		}
	}
	return self;
}

-(void) shootBulletAt:(CGPoint)startPosition bulletType:(BulletType*)bulletType isPlayerBullet:(bool)playerBullet
{
    self.position = startPosition;
    self.visible = YES;
    self.alive = YES;
    self.isPlayerBullet = playerBullet;
    type = bulletType;
    
    //Get the initial image
    NSString* frameName = [NSString stringWithFormat:@"%@%i.png", type.name, 0];
    
    //change the bullet's texture by setting a different sprite frame to be displayed
    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
    [self setDisplayFrame:frame];
    [self scheduleUpdate];
}

-(void) gotHit
{
    alive = NO;
    NSString* bulletImage = type.name;
    
    if (type.animate == YES)
    {
        // create an animation object from all the sprite animation frames
        CCAnimation* anim = [CCAnimation animationWithFrame:bulletImage frameCount:4 delay:0.05f];
        // run the animation by using the CCAnimate action
        CCAnimate* animate = [CCAnimate actionWithAnimation:anim];
        CCSequence* animateThenHide = [CCSequence actions:animate, [CCHide action], nil];
        [self runAction:animateThenHide];
    }
    else
    {
        self.visible = NO;
    }
}

-(void) update:(ccTime)delta
{
    if (!alive)
    {
        [self unscheduleUpdate];
        return;
	}
    
    self.position = ccpAdd(self.position, ccpMult(type.velocity, delta));
    
	// When the bullet leaves the screen, make it invisible
	if (CGRectIntersectsRect([self boundingBox], screenRect) == NO)
	{
		self.visible = NO;
        alive = NO;
		[self unscheduleUpdate];
	}

}

@end
