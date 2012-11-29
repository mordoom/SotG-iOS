//
//  EnemyEntity.h
//  SotG
//
//  Created by Alex Mordue on 18/01/12.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Entity.h"
#import "BulletType.h"

typedef enum
{
    EnemyTypeSquid,
    EnemyTypeSpike,
    EnemyType_MAX,
    
} EnemyTypes;

@interface EnemyEntity : Entity
{
    NSString* name;
    int initialHitPoints;
    int hitPoints;
    bool alive;
}
@property (readonly, nonatomic) NSString* name;
@property (readonly, nonatomic) int initialHitPoints;
@property (readonly, nonatomic) int hitPoints;
@property (readonly, nonatomic) bool alive;
+(id) enemyWithType;
+(int) getSpawnFrequencyForEnemyType:(EnemyTypes)enemyType;
-(int) maxCapacity;
-(void) spawn;
-(void) gotHit:(int)damage;
-(id) initEnemyWithType;
-(id) copy;
@end
