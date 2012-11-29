//
//  BulletCache.m
//  SotG
//
//  Created by Alex Mordue on 18/01/12.
//

#import "BulletCache.h"
#import "GameScene.h"
#import "CCAnimationHelper.h"

@interface BulletCache (PrivateMethods)
-(int) isBulletCollidingWithRect:(CGRect)rect usePlayerBullets:(bool)usePlayerBullets;
@end

@implementation BulletCache

-(id) init
{
    if (self = [super init])
    {
        //get any bullet image from the texture atlas
        CCSpriteFrame* bulletFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bullet0.png"];
        
        //Use the bullet texture
        batch = [CCSpriteBatchNode batchNodeWithTexture:bulletFrame.texture];
        [self addChild:batch];
        
        //Create a number of bullets up front and re-use them
        for (int i = 0; i < 200; i++)
        {
            Bullet* bullet = [Bullet bullet];
            bullet.alive = NO;
            bullet.visible = NO;
            [batch addChild:bullet];
        }
    }
    
    return self;
}

-(void)shootBulletAt:(CGPoint)startPosition bulletType:(BulletType*)bulletType isPlayerBullet:(bool)playerBullet
{
    //Need a bullet sprite batch here to make this work
	CCArray* bullets = [batch children];
	
	CCNode* node = [bullets objectAtIndex:nextInactiveBullet];
	NSAssert([node isKindOfClass:[Bullet class]], @"not a bullet!");
	
	Bullet* bullet = (Bullet*)node;
	[bullet shootBulletAt:startPosition bulletType:bulletType isPlayerBullet:playerBullet];
	
	nextInactiveBullet++;
	if (nextInactiveBullet >= [bullets count])
	{
		nextInactiveBullet = 0;
	}

}

-(int)isPlayerBulletCollidingWithRect:(CGRect)rect
{
    return [self isBulletCollidingWithRect:rect usePlayerBullets:YES];
}

-(int) isEnemyBulletCollidingWithRect:(CGRect)rect
{
    return [self isBulletCollidingWithRect:rect usePlayerBullets:NO];
}

-(int) isBulletCollidingWithRect:(CGRect)rect usePlayerBullets:(bool)usePlayerBullets
{
    int damage = 0;
    
    Bullet* bullet;
    CCARRAY_FOREACH([batch children], bullet)
    {
        if (bullet.alive && usePlayerBullets == bullet.isPlayerBullet)
        {
            if (CGRectIntersectsRect([bullet boundingBox], rect))
                {
                   damage = bullet.type.damage;
                    
                    //remove the bullet
                    [bullet gotHit];
                    break;
                }
        }
    }
    
    return damage;
}

-(void) removeCollidingBullets
{
    Bullet* bullet;
    CCARRAY_FOREACH([batch children], bullet)
    {
        if (bullet.alive && bullet.isPlayerBullet == YES)
        {
            if ([self isBulletCollidingWithRect:[bullet boundingBox] usePlayerBullets:NO])
            {
                [bullet gotHit];
            }
        }
    }
}

-(void) dealloc
{
    [super dealloc];
}

@end
