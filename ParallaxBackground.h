//
//  ParallaxBackground.h
//  SotG
//
//  Created by Alex Mordue on 17/12/11.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ParallaxBackground : CCNode
{
    CCSpriteBatchNode* spriteBatch;
    int numSprites;
    CCArray* speedFactors;
    float scrollSpeed;
}
@property (nonatomic) float scrollSpeed;
@end
