//
//  ShipEntity.h
//  SotG
//
//  Created by Alex Mordue on 18/01/12.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Entity.h"
#import "Bullet.h"
#import "BulletType.h"

@interface ShipEntity : Entity
{
    bool alive;
    int initialHitPoints;
    int hitPoints;
    int ammunition;
    BulletType* currentWeapon;
}
@property (nonatomic) bool alive;
@property (readonly, nonatomic) int hitPoints;
@property (readonly, nonatomic) int initialHitPoints;
@property (readonly, nonatomic) BulletType* currentWeapon;
@property (readwrite, nonatomic) int ammunition;
+(id) ship;
-(void) gotHit:(int)damage;
-(void) useRandomPowerup;
-(void) switchToDefaultWeapon;
@end
