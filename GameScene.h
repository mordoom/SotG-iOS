//
//  GameScene.h
//  SotG
//
//  Created by Alex Mordue on 17/12/11.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "ShipEntity.h"
#import "BulletCache.h"
#import "ScoreComponent.h"
#import "EnemyCache.h"

typedef enum
{
	GameSceneNodeTagBullet = 1,
	GameSceneNodeTagBulletSpriteBatch,
	GameSceneNodeTagBulletCache,
    GameSceneNodeTagEnemyCache,
	GameSceneNodeTagShip,
    GameSceneNodeTagBackground,
    GameSceneNodeTagHeathbar,
    GameSceneNodeTagPowerup,
    GameSceneNodeTagScore,
}GameSceneNodeTags;

typedef enum
{
    GameSceneLayerTagGame = 1,
    GameSceneLayerTagInput,
}GameSceneLayerTags;

// GameScene Layer
@interface GameScene : CCLayer
{
    
} 

+(CCScene *) scene:(NSString*)level;
+(GameScene*) sharedGameScene;
-(ShipEntity*) defaultShip;
-(EnemyCache*) enemyCache;
-(BulletCache*) bulletCache;
-(void) gameOver;
-(void) levelCleared;
+(CGRect) screenRect;
+(NSString*)levelName;
@property (readonly, nonatomic) ScoreComponent* scoreComponent;
@end
