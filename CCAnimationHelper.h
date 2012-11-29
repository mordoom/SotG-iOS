//
//  CCAnimationHelper.h
//  SotG
//
//  Created by Alex Mordue on 20/01/12.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CCAnimation (Helper)
+(CCAnimation*) animationWithFile:(NSString*)name frameCount:(int)frameCount delay:(float)delay;
+(CCAnimation*) animationWithFrame:(NSString*)frame frameCount:(int)frameCount delay:(float)delay;
@end
