//
//  HealthbarComponent.m
//  SotG
//
//  Created by Alex Mordue on 19/01/12.
//

#import "HealthbarComponent.h"
#import "GameScene.h"
#import "ShipEntity.h"

@implementation HealthbarComponent

-(id) initWithHealthbarImage
{
    if ((self = [super initWithSpriteFrameName:@"healthbar.png"]))
    {
        [self reset];
        [self scheduleUpdate];
    }
    
    return self;
}

+(id) healthbar
{
    return [[[self alloc] initWithHealthbarImage] autorelease];
}

-(void) reset
{
    float ypos = [GameScene screenRect].size.height-self.contentSize.height;
    self.anchorPoint = CGPointMake(0, 0.5f);
    self.position = CGPointMake(16, ypos);
    self.scaleX = 1;
    self.visible = YES;
}

-(void) update:(ccTime)delta
{
    ShipEntity* parentEntity = [[GameScene sharedGameScene] defaultShip];
    if (self.parent.visible && parentEntity.hitPoints >= 1)
    {
        self.scaleX = parentEntity.hitPoints / (float)parentEntity.initialHitPoints;
    }
    else if (self.visible)
    {
        self.visible = NO;
    }
}
@end
