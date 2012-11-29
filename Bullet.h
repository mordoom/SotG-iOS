//
//  Bullet.h
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

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BulletType.h"

@interface Bullet : CCSprite 
{
    bool isPlayerBullet;
    bool alive;
    BulletType* type;
}

@property (readwrite, nonatomic) bool isPlayerBullet;
@property (readwrite, nonatomic) bool alive;
@property (readonly, nonatomic) BulletType* type;

+(id) bullet;
-(void) shootBulletAt:(CGPoint)startPosition bulletType:(BulletType*)bulletType isPlayerBullet:(bool)playerBullet;
-(void) gotHit;

@end
