//
//  ScoreComponent.h
//  SotG
//
//  Created by Alex Mordue on 19/01/12.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ScoreComponent : CCSprite
{
    CCLabelBMFont* scoreLabel;
    int score;
}
+(id) score;
-(void) updateScore:(int)points;
@end
