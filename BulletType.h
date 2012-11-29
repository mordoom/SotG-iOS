//
//  BulletType.h
//  SotG
//
//  Created by Alex Mordue on 02/02/12.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BulletType : CCNode
{
    NSString* name;
    int damage;
    CGPoint velocity;
    bool animated;
}
@property (readwrite, nonatomic) CGPoint velocity;
@property (readwrite, retain) NSString* name;
@property (readwrite, nonatomic) int damage;
@property (readwrite, nonatomic) bool animate;
@end
