//
//  EnemyCache.h
//  SotG
//
//  Created by Alex Mordue on 18/01/12.

//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface EnemyCache : CCNode
{
    CCSpriteBatchNode* batch;
    CCArray* enemies;
    CCArray* types;
    int updateCount;
    int enemiesKilled;
}
@property (readwrite, nonatomic) int enemiesKilled;
@end
