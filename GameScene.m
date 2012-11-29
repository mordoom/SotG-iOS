//
//  GameScene.h
//  SotG
//
//  Created by Alex Mordue on 17/12/11.
//



// Import the interfaces
#import "GameScene.h"
#import "ParallaxBackground.h"
#import "Bullet.h"
#import "InputLayer.h"
#import "EnemyCache.h"
#import "HealthbarComponent.h"
#import "PowerupEntity.h"
#import "GameOverScene.h"
#import "LevelSelectScene.h"

// GameScene implementation
@implementation GameScene
@synthesize scoreComponent;

static CGRect screenRect;
static GameScene* instanceOfGameScene;
static NSString* currentLevel;

+(GameScene*) sharedGameScene
{
	NSAssert(instanceOfGameScene != nil, @"GameScene instance not yet initialized!");
	return instanceOfGameScene;
}

+(id) scene:(NSString*)level
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
    currentLevel = level;
	GameScene *layer = [GameScene node];
    [scene addChild:layer z:0 tag:GameSceneLayerTagGame];
	
    //Input layer
    InputLayer* inputLayer = [InputLayer node];
    [scene addChild:inputLayer z:1 tag:GameSceneLayerTagInput];
	
	// return the scene
	return scene;
}

+(NSString*)levelName
{
    return currentLevel;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	if( (self=[super init])) {
        instanceOfGameScene = self;
        
		// ask director the the window size
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
        screenRect = CGRectMake(0, 0, screenSize.width, screenSize.height);
       
        //BG color
        CCLayerColor* colorLayer = [CCLayerColor layerWithColor:ccc4(153, 217, 234, 255)];
        [self addChild:colorLayer z:0];
        
        // Load all of the game's artwork up front.
		CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
		[frameCache addSpriteFramesWithFile:@"game-art.plist"];
        
        //Add the parallax bg
        ParallaxBackground* background = [ParallaxBackground node];
		[self addChild:background z:0 tag:GameSceneNodeTagBackground];
        
        // add the ship
		ShipEntity* ship = [ShipEntity ship];
		ship.position = CGPointMake(80, screenSize.height / 2);
		[self addChild:ship z:0 tag:GameSceneNodeTagShip];
        
        //Enemies
		EnemyCache* enemyCache = [EnemyCache node];
		[self addChild:enemyCache z:0 tag:GameSceneNodeTagEnemyCache];
        
        //Add the bullet cache
        BulletCache* bulletCache = [BulletCache node];
		[self addChild:bulletCache z:1 tag:GameSceneNodeTagBulletCache];
        
        //Add a powerup
        PowerupEntity* powerup = [PowerupEntity powerup];
        [self addChild:powerup z:1 tag:GameSceneNodeTagPowerup];
		
        //Initialise healthbar
        HealthbarComponent* healthbar = [HealthbarComponent healthbar];
        [self addChild:healthbar z:2 tag:GameSceneNodeTagHeathbar];
        
        //Initialise score
        scoreComponent = [ScoreComponent score];
        [self addChild:scoreComponent z:0 tag:GameSceneNodeTagScore];
	}
	return self;
}

-(EnemyCache*) enemyCache
{
	CCNode* node = [self getChildByTag:GameSceneNodeTagEnemyCache];
	NSAssert([node isKindOfClass:[EnemyCache class]], @"not a BulletCache");
	return (EnemyCache*)node;
}

-(BulletCache*) bulletCache
{
	CCNode* node = [self getChildByTag:GameSceneNodeTagBulletCache];
	NSAssert([node isKindOfClass:[BulletCache class]], @"not a BulletCache");
	return (BulletCache*)node;
}

-(ShipEntity*) defaultShip
{
	CCNode* node = [self getChildByTag:GameSceneNodeTagShip];
	NSAssert([node isKindOfClass:[ShipEntity class]], @"node is not a Ship!");
	return (ShipEntity*)node;
}

-(void) loadGameOverScene: (ccTime) delta
{
    //Transition to game over screen
    CCTransitionSlideInB* transition = [CCTransitionSlideInB transitionWithDuration:3 scene:[GameOverScene scene]];
	[[CCDirector sharedDirector] replaceScene:transition];
}

-(void) loadLevelSelectScene: (ccTime) delta
{
    //Transition to game over screen
    CCTransitionSlideInB* transition = [CCTransitionFlipX transitionWithDuration:3 scene:[LevelSelectScene scene]];
	[[CCDirector sharedDirector] replaceScene:transition];
}

-(void) gameOver
{
    //Stop the background scrolling
    CCNode* node = [self getChildByTag:GameSceneNodeTagBackground];
    NSAssert([node isKindOfClass:[ParallaxBackground class]], @"node is not a parallaxbg!");
    ParallaxBackground* bg = (ParallaxBackground*)node;
    bg.scrollSpeed = 0;
    
    //Show the game over screen
    [self schedule:@selector(loadGameOverScene:) interval:2];
}

-(void) levelCleared
{	
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CCLabelBMFont* scoreLabel = [CCLabelBMFont labelWithString:@"Level Cleared" fntFile:@"bitmapfont.fnt"];
    scoreLabel.position = CGPointMake(screenSize.width/2, screenSize.height/2);
    [self addChild:scoreLabel z:2];
    
    //Show the menu screen (for now, in future it will be the level select screen)
    [self schedule:@selector(loadLevelSelectScene:) interval:3];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    instanceOfGameScene = nil;
	[super dealloc];
}

+(CGRect) screenRect
{
	return screenRect;
}
@end
