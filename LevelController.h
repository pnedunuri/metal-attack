//
//  LevelController.h
//  EightbitShooter
//
//  Created by Rafael Munhoz on 2/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"
#import "Enemy.h"
#import "RobotBlaster.h"
#import "Level.h"

@interface LevelController : NSObject
{
    id delegate;
    NSMutableArray *loadedLevels;
    NSDictionary *enemyDict;
    NSMutableDictionary *enemyDictMutable;
    int totalLevels;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) NSMutableArray *loadedLevels;
@property (nonatomic, retain) NSDictionary *enemyDict;
@property (nonatomic) int totalLevels;
@property (nonatomic, retain) NSMutableDictionary *enemyDictMutable;

+(id)sharedInstance;
-(void)loadLevelJson;
-(Level*)loadLevel:(int)levelNumber waveNumber:(int)wave delegate:(id)scnDelegate;

@end
