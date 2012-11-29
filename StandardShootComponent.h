//
//  StandardShootComponent.h
//  SotG
//
//  Created by Alex Mordue on 18/01/12.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Bullet.h"
#import "BulletType.h"

@interface StandardShootComponent : CCSprite
{
    int updateCount;
    int shootFrequency;
    BulletType* bullet;
}
@property (nonatomic) int shootFrequency;
@property (readwrite, retain) BulletType* bullet;

@end
