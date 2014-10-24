//
//  Level.m
//  EightbitShooter
//
//  Created by Rafael Munhoz on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level.h"

@implementation Level

@synthesize waves;
@synthesize avaliableEnemies;
@synthesize totalLevelEnemies;
@synthesize totalWaveSPerLevel;
@synthesize levelContext;

-(id)init
{
    
    self = [super init];
    
    if(self) {
        self.waves = [[[NSMutableArray alloc] init] autorelease];
        self.avaliableEnemies = [[[NSMutableArray alloc] init] autorelease];
    }
    
    return self;
    
}

@end
