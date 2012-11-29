//
//  Entity.h
//  SotG
//
//  Created by Alex Mordue on 09/02/12.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Component;

@interface Entity : CCSprite
{
    
}
-(BOOL) isOutsideScreenArea;

@end
