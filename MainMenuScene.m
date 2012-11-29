//
//  MainMenuScene.m
//  SotG
//
//  Created by Alex Mordue on 15/02/12.
//

#import "MainMenuScene.h"
#import "LevelSelectScene.h"

@implementation MainMenuScene

-(void) createMenu
{
    // unschedule the selector, we only want this method to be called once
	[self unschedule:_cmd];
	
	CGSize size = [[CCDirector sharedDirector] winSize];
	
	// set CCMenuItemFont default properties
	[CCMenuItemFont setFontName:@"Helvetica"];
	[CCMenuItemFont setFontSize:40];
	
    //Heading
    CCMenuItemFont* heading = [CCMenuItemFont itemFromString:@"Squids of the Galaxy"];
    
	// create a few labels with text and selector
	CCMenuItemFont* item1 = [CCMenuItemFont itemFromString:@"Start Game" target:self selector:@selector(menuItem1Touched:)];
	
	// create the menu using the items
	CCMenu* menu = [CCMenu menuWithItems:heading, item1, nil];
	menu.position = CGPointMake(-(size.width / 2), size.height / 2);
	menu.tag = 100;
	[self addChild:menu];
	
	// calling one of the align methods is important, otherwise all labels will occupy the same location
	[menu alignItemsVerticallyWithPadding:40];
	
	// use an action for a neat initial effect - moving the whole menu at once!
	CCMoveTo* move = [CCMoveTo actionWithDuration:3 position:CGPointMake(size.width / 2, size.height / 2)];
	CCEaseElasticOut* ease = [CCEaseElasticOut actionWithAction:move period:0.8f];
	[menu runAction:ease];
}

+(id) scene
{
    CCScene* scene = [CCScene node];
	MainMenuScene* layer = [MainMenuScene node];
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

-(void) startGame
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
	[[CCDirector sharedDirector] replaceScene:[LevelSelectScene scene]];
}

-(void) menuItem1Touched:(id)sender
{
	CCLOG(@"item 1 touched: %@", sender);
	[self startGame];
}
@end
