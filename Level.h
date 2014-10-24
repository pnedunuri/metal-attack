//
//  Level.h
//  EightbitShooter
//
//  Created by Rafael Munhoz on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Level : NSObject

{
    /*
        Level Context map
     
        TheGarage   - 1
        TheSchool   - 2
        TheBar      - 3
        ThePrision  - 4
     */
    
    
    // each position represents the number of enemies of the wave.
    NSMutableArray *waves;
    // each position has the avaliable enemy to be choosed random on the level.
    NSMutableArray *avaliableEnemies;
    // Power ups ?
    int totalLevelEnemies;
    //
    int totalWavesPerLevel;
    // Level context will indicate where the scenario where the level
    // will be placed like TheGarage, means that the level will be placed
    // in the garage.
    // name of the levelcontexts TheGarage, TheSchool, TheBar, ThePrision
    int *levelContext;
}

@property (nonatomic,retain) NSMutableArray *waves;
@property (nonatomic,retain) NSMutableArray *avaliableEnemies;
@property (nonatomic) int totalLevelEnemies;
@property (nonatomic) int totalWaveSPerLevel;
@property (nonatomic) int *levelContext;


@end
