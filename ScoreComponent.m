//
//  ScoreComponent.m
//  SotG
//
//  Created by Alex Mordue on 02/02/12.
//

#import "ScoreComponent.h"
#import "GameScene.h"

@implementation ScoreComponent

-(id) initScore
{
    if (self = [super init])
    {
        CGRect screenSize = [GameScene screenRect];
        
        // Add the score label
        score = 0;
		scoreLabel = [CCLabelBMFont labelWithString:@"0" fntFile:@"bitmapfont.fnt"];
		scoreLabel.position = CGPointMake(screenSize.size.width-32, screenSize.size.height-16);
		
        // Adjust the label's anchorPoint's y position to make it align with the top.
		scoreLabel.anchorPoint = CGPointMake(1.0f, 1.0f);
		[self addChild:scoreLabel z:0];
    }
    
    return self;
}

+(id) score
{
    return [[[self alloc] initScore] autorelease];
}

-(void) updateScore:(int)points
{
    // Update the Score (Timer) once per second. If you'd do it more often, especially every frame, this
	// will easily drag the framerate down. Updating a CCLabel's strings is slow!
    score += points;
    [scoreLabel setString:[NSString stringWithFormat:@"%i", score]];
}

@end
