//
//  ParallaxBackground.m
//  SotG
//
//  Created by Alex Mordue on 17/12/11.
//

#import "ParallaxBackground.h"
#import "GameScene.h"

@implementation ParallaxBackground
@synthesize scrollSpeed;

-(id) init
{
    if (self = [super init])
    {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        NSString* currentLevel = [GameScene levelName];
    
        //Get the game's texture atlas texture by adding it
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA4444];
        CCTexture2D* gameArtTexture = [[CCTextureCache sharedTextureCache] addImage:@"game-art.pvr.ccz"];
        spriteBatch = [CCSpriteBatchNode batchNodeWithTexture:gameArtTexture];
        [self addChild:spriteBatch];
    
        numSprites = 3;
    
        //Add the different layer object and position them on the screen
        for (int i = 0; i < numSprites; i++)
        {
            NSString* frameName = [NSString stringWithFormat:@"%@%i.png", currentLevel,i];
			CCSprite* sprite = [CCSprite spriteWithSpriteFrameName:frameName];
			sprite.position = CGPointMake(screenSize.width / 2, screenSize.height / 2);
            
            //Anchors
			sprite.anchorPoint = CGPointMake(0, 0.5f);
			sprite.position = CGPointMake(0, screenSize.height / 2);
            
			[spriteBatch addChild:sprite z:i];
        }
        
        //Add more layers offscreen
		for (int i = 0; i < numSprites; i++)
		{
			NSString* frameName = [NSString stringWithFormat:@"%@%i.png", currentLevel,i];
			CCSprite* sprite = [CCSprite spriteWithSpriteFrameName:frameName];
			
			// Position the new sprite one screen width to the right
			sprite.position = CGPointMake((screenSize.width + screenSize.width / 2)-2, screenSize.height / 2);
            
            // Position the new sprite one screen width to the right
			sprite.anchorPoint = CGPointMake(0, 0.5f);
			sprite.position = CGPointMake(screenSize.width, screenSize.height / 2);
            
			// Flip the sprite so that it aligns perfectly with its neighbor
			sprite.flipX = YES;
			
			// Add the sprite using the same tag offset by numStripes
			[spriteBatch addChild:sprite z:i tag:i + numSprites];
		}
        
        scrollSpeed = 2.0f;
        
        //Init the array that contains the scroll factors for individual layers
        speedFactors = [[CCArray alloc] initWithCapacity:numSprites];
        [speedFactors addObject:[NSNumber numberWithFloat:0.3f]];
        [speedFactors addObject:[NSNumber numberWithFloat:0.5f]];
        [speedFactors addObject:[NSNumber numberWithFloat:0.8f]];
        
        [self scheduleUpdate];
    }
    
    return self;
}

-(void) update:(ccTime)delta
{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
	CCSprite* sprite;
	CCARRAY_FOREACH([spriteBatch children], sprite)
	{
        NSNumber* factor = [speedFactors objectAtIndex:sprite.zOrder];
		CGPoint pos = sprite.position;
		pos.x -= scrollSpeed * [factor floatValue] * (delta * 100);
        
        // Reposition stripes when they're out of bounds
		if (pos.x < -screenSize.width)
		{
			pos.x += (screenSize.width * 2) - 2;
		}

        
		sprite.position = pos;
	}
}

-(void) dealloc
{
    [speedFactors release];
    [super dealloc];
}

@end
