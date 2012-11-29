//
//  LevelSelectScene.h
//  SotG
//
//  Created by Alex Mordue on 15/02/12.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface LevelSelectScene : CCLayer
{
    NSString* level;
}
+(id) scene;
@property (readwrite, retain) NSString* level;
@end
