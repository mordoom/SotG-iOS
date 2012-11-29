//
//  InputLayer.h
//  SotG
//
//  Created by Apple on 12/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

//Sneaky Input headers
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"
#import "SneakyExtensions.h"

@interface InputLayer : CCLayer
{
    SneakyButton* fireButton;
    SneakyJoystick* joystick;
    
    ccTime totalTime;
    ccTime nextShotTime;
}
-(void)addFireButton;
-(void)addJoystick;
@end
