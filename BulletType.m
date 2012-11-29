//
//  BulletType.m
//  SotG
//
//  Created by Alex Mordue on 02/02/12.
//

#import "BulletType.h"


@implementation BulletType
@synthesize name;
@synthesize damage;
@synthesize velocity;
@synthesize animate;

-(void) dealloc
{
    [name release];
    [super dealloc];
}
@end
