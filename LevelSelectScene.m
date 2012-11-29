//
//  LevelSelectScene.m
//  SotG
//
//  Created by Alex Mordue on 15/02/12.
//

#import "LevelSelectScene.h"
#import "GameScene.h"

@implementation LevelSelectScene
@synthesize level;
-(void) createMenu
{
    // unschedule the selector, we only want this method to be called once
	[self unschedule:_cmd];
	
	CGSize size = [[CCDirector sharedDirector] winSize];
	
	// set CCMenuItemFont default properties
	[CCMenuItemFont setFontName:@"Helvetica"];
	[CCMenuItemFont setFontSize:40];
	
    //Heading
    CCMenuItemFont* heading = [CCMenuItemFont itemFromString:@"Level Select"];
    heading.position = CGPointMake(size.width / 2, size.height - heading.contentSize.height);
	
    //Level selection buttons
    CCMenuItemImage* item1 = [CCMenuItemImage itemFromNormalImage:@"first-level.png" selectedImage:@"first-level.png" target:self selector:@selector(menuItem1Touched:)];
    CCMenuItemImage* item2 = [CCMenuItemImage itemFromNormalImage:@"cave-level.png" selectedImage:@"cave-level.png" target:self selector:@selector(menuItem2Touched:)];
    
	// create the menu using the items
	CCMenu* menu = [CCMenu menuWithItems:item1, item2, nil];
	menu.position = CGPointMake(-(size.width / 2), size.height / 2);
	menu.tag = 100;
    [self addChild:heading];
	[self addChild:menu];
	
	// calling one of the align methods is important, otherwise all labels will occupy the same location
	[menu alignItemsHorizontallyWithPadding:16];
	
	// use an action for a neat initial effect - moving the whole menu at once!
	CCMoveTo* move = [CCMoveTo actionWithDuration:3 position:CGPointMake(size.width / 2, size.height / 2)];
	CCEaseElasticOut* ease = [CCEaseElasticOut actionWithAction:move period:0.8f];
	[menu runAction:ease];
}

+(id) scene
{
    CCScene* scene = [CCScene node];
	LevelSelectScene* layer = [LevelSelectScene node];
	[scene addChild:layer];
	return scene;
}

-(id) init
{
    if (self = [super init])
    {
        CCSprite * bg = [CCSprite spriteWithFile:@"bg-iphone.png"];
        bg.anchorPoint = CGPointMake(0, 0);
        [self addChild:bg z:0];
        [self createMenu];
    }
    return self;
}

-(void) startLevel
{
	// get the menu back
	CCNode* node = [self getChildByTag:100];
	NSAssert([node isKindOfClass:[CCMenu class]], @"node is not a CCMenu!");
    
	CCMenu* menu = (CCMenu*)node;
    
	// lets move the menu out using a sequence
	CGSize size = [[CCDirector sharedDirector] winSize];
	CCMoveTo* move = [CCMoveTo actionWithDuration:1 position:CGPointMake(-(size.width / 2), size.height / 2)];
	CCEaseBackInOut* ease = [CCEaseBackInOut actionWithAction:move];
	CCCallFunc* func = [CCCallFunc actionWithTarget:self selector:@selector(changeScene:)];
	CCSequence* sequence = [CCSequence actions:ease, func, nil];
	[menu runAction:sequence];
}

-(void) changeScene:(id)sender
{
	[[CCDirector sharedDirector] replaceScene:[GameScene scene:level]];
}

-(void) menuItem1Touched:(id)sender
{
	CCLOG(@"item 1 touched: %@", sender);
    self.level = @"water";
	[self startLevel];
}

-(void) menuItem2Touched:(id)sender
{
	CCLOG(@"item 2 touched: %@", sender);
    self.level = @"cave";
	[self startLevel];
}

-(void) dealloc
{
    [level release];
    [super dealloc];
}
@end
