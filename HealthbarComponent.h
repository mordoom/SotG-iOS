//
//  HealthbarComponent.h
//  SotG
//
//  Created by Alex Mordue on 19/01/12.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface HealthbarComponent : CCSprite
{
    
}
+(id) healthbar;
-(id)initWithHealthbarImage;
-(void) reset;

@end
