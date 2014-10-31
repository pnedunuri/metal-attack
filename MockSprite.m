//
//  MockSprite.m
//  MetalAttack
//
//  Created by Rafael Munhoz on 31/10/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "MockSprite.h"


@implementation MockSprite

-(id)init{
    self = [super init];
    
    if (self) {
        NSLog(@"MockSprite init");
    }
    
    return self;
    
}

-(void)beginDieAnimation
{
    NSLog(@"BeginDieAnimation");
}

-(void)endDieAnimation
{
    NSLog(@"EndDieAnimation");
}


@end
