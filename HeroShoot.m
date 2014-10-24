//
//  HeroShoot.m
//  EightbitShooter
//
//  Created by Rafael Munhoz on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HeroShoot.h"

@implementation HeroShoot

@synthesize removeObject;

-(id)initWithFile:(NSString *)filename
{
    
    self = [super initWithFile:filename];
    
    if(self) {
        self.removeObject = NO;
    }
    
    return self;
    
}

@end
