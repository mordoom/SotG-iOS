//
//  PowerupEntity.h
//  SotG
//
//  Created by Alex Mordue on 29/01/12.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Entity.h"

typedef enum
{
    PowerupTypeHealth,
    PowerupTypeLaserWeapon,
    PowerupTypeHarpoonWeapon,
    PowerupType_MAX,
    
} PowerupTypes;

@interface PowerupEntity : Entity
{
    PowerupTypes type;
    CGPoint velocity;
    int updateCount;
    int spawnFrequency;
}
@property (nonatomic) CGPoint velocity;
+(id) powerup;
-(void) spawn;
-(void) gotHit;
@end
