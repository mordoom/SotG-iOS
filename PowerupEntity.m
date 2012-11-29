//
//  PowerupEntity.m
//  SotG
//
//  Created by Alex Mordue on 29/01/12.
//

#import "PowerupEntity.h"
#import "GameScene.h"
#import "ShipEntity.h"

@implementation PowerupEntity
@synthesize velocity;

-(id) initWithPowerupImage
{
    if (self = [super initWithSpriteFrameName:@"powerup.png"])
    {   
        spawnFrequency = 480;
        [self spawn];
        [self scheduleUpdate];
    }
    
    return self;
}

+(id) powerup
{
    return [[[self alloc] initWithPowerupImage] autorelease];
}

-(void) spawn
{
    //Select a spawn location just outside the right side of the screen
    CGRect screenRect = [GameScene screenRect];
    CGSize spriteSize = [self contentSize];
    float xpos = screenRect.size.width + spriteSize.width*0.5f;
    float ypos = CCRANDOM_0_1() * (screenRect.size.height - spriteSize.height) + spriteSize.height * 0.5f;
    
    self.position = CGPointMake(xpos, ypos);
    velocity = CGPointMake(-50, 0);
    
    //Set powerup to visible (in use)
    self.visible  = YES;
}

-(void) gotHit
{
    //Need to tell player to use powerup
    ShipEntity* ship = [[GameScene sharedGameScene] defaultShip];
    [ship useRandomPowerup];
    self.visible = NO;
}

-(BOOL) isPowerupCollidingWithRect:(CGRect) rect
{
    BOOL isColliding = false;
    
    if (CGRectIntersectsRect([self boundingBox], rect))
    {
        isColliding = YES;
    }
    
    return isColliding;
}

-(void) checkForCollisions
{
    //Remove if the powerup makes it to the other end of the screen
    if ([self position].x < [self contentSize].width+1)
    {
        self.visible = NO;
    }
    
    GameScene* game = [GameScene sharedGameScene];
    ShipEntity* ship = [game defaultShip];
    CGRect bbox = [ship boundingBox];
    if (ship.alive && [self isPowerupCollidingWithRect:bbox])
    {
        //destroy powerup
        [self gotHit];
    }

}

-(void) update:(ccTime)delta
{
    if (self.visible == NO)
    {
        updateCount++;
        if (updateCount % spawnFrequency == 0 && !self.visible)
        {
            [self spawn];
        }    
    }
    else
    {
        //Move powerup
        self.position = CGPointMake(self.position.x + velocity.x *delta, self.position.y + velocity.y * delta);
        
        //Check if colliding with player
        [self checkForCollisions];
    }
}

-(void) dealloc
{
    [super dealloc];
}

@end
