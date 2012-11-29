//
//  BulletCache.h
//  SotG
//
//  Created by Alex Mordue on 18/01/12.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Bullet.h"
#import "BulletType.h"

@interface BulletCache : CCNode
{
    CCSpriteBatchNode* batch;
    int nextInactiveBullet;
    CCArray* bulletTypes;
}

-(void) shootBulletAt:(CGPoint)startPosition bulletType:(BulletType*)bulletType isPlayerBullet:(bool)playerBullet;
-(int) isPlayerBulletCollidingWithRect:(CGRect)rect;
-(int) isEnemyBulletCollidingWithRect:(CGRect)rect;
-(void) removeCollidingBullets;
@end
