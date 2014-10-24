//
//  LevelController.m
//  EightbitShooter
//
//  Created by Rafael Munhoz on 2/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LevelController.h"
#import "UniversalInfo.h"

@implementation LevelController

@synthesize delegate;
@synthesize loadedLevels;
@synthesize enemyDict; // obslete remove on the last revision
@synthesize totalLevels;
@synthesize enemyDictMutable;

+(id)sharedInstance
{
	//Singleton Implementation
    static id master = nil;
	
	@synchronized(self)
	{
		if (master == nil){
            master = [self new];
        }
	}
    return master;
}

-(PowerUp)checkForPowerUp
{
    // calc the random number from 1 to 10
    int randforNoPowerUp = (arc4random() % 10) + 1;
    //  20% of power up to be aquired
    if (randforNoPowerUp <= 8) {
        return NOPOWERUP;
    }else{
        // random again from 1 to 5 to select the power up
        int randForPowerUp = (arc4random() % 5) + 1;
        
        switch (randForPowerUp) {
            case 1:
                return GUNPOWER_1;
                break;
            case 2:
                return GUNPOWER_2;
                break;
            case 3:
                return HEALTHPOWER;
                break;
            case 4:
                return RADIOPOWER;
                break;
            case 5:
                return COIN;
                break;
            default:
                return NOPOWERUP;
                break;
        }
    }
    return NOPOWERUP;
}

-(AtackType)getEnemyAtackType:(NSDictionary *)info{
    
    if ([[info valueForKey:@"meele"] boolValue]){
        return MEELEE;
    }else if ([[info valueForKey:@"autoDestruction"] boolValue]){
        return AUTODESTRUCTION;
    }else{
        return WALK_SHOOT;
    }

}

-(void)loadEnemyDictFromJson
{
    //load the enemies definitions from a json file
    
    NSBundle *appBundle = [NSBundle bundleForClass:[self class]];
    NSString *levelDataPath = [appBundle pathForResource:@"enemies" ofType:@"json"];
    NSString *jsonString = [NSString stringWithContentsOfFile:levelDataPath encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary *results = [jsonString JSONValue];
    
    NSString *enemy;
    
    self.enemyDictMutable = [[NSMutableDictionary alloc] init];
    
    for (enemy in results){
        
        EnemyParams *robot = [[EnemyParams alloc] init];
        NSDictionary *enemyInfo = [results valueForKey:enemy];
        
        robot.enemyName =[enemyInfo valueForKey:@"enemyName"];
        robot.armor = [[enemyInfo valueForKey:@"armor"] floatValue];
        robot.weaponDamage = [[enemyInfo valueForKey:@"weaponDamage"] floatValue];
        robot.scorePoints = [[enemyInfo valueForKey:@"scorePoints"] floatValue];
        robot.numberOfFrames = [[enemyInfo valueForKey:@"numberOfFrames"] intValue];
        robot.timeToReach = [[enemyInfo valueForKey:@"timeToReach"] doubleValue];
        robot.typeOfPowerUp = [[enemyInfo valueForKey:@"typeOfPowerUp"] floatValue];
        robot.atackType = [self getEnemyAtackType:enemyInfo];
        
        if (robot.atackType == WALK_SHOOT) {
            robot.shootStartPosition = ccp([[enemyInfo valueForKey:@"shootStartX"] intValue],
                                           [[enemyInfo valueForKey:@"shootStartY"] intValue]);
            robot.shootStyle = [self convertShootStyle:[[enemyInfo valueForKey:@"shootStyle"] intValue]];
        }
        
        [[self enemyDictMutable] setValue:robot forKey:robot.enemyName];
        
        NSString *testName = [[[self enemyDictMutable] objectForKey:enemy] enemyName];
        NSLog(@"Enemy name test %@", testName);
    
    }
    NSLog(@"Number of enemies %d",[[self enemyDictMutable] count]);
}

-(ShootStyle)convertShootStyle:(int)style
{
    switch (style) {
        case 0:
        return SINGLE;
        break;
        case 1:
        return ROTATION;
        case 2:
        return JUMP;
        break;
        default:
        return SINGLE;
        break;
    }
}

-(Level*)loadLevel:(int)levelNumber waveNumber:(int)wave delegate:(id)scnDelegate
{   
    NSLog(@"Loading level and wave");
    
    
    NSMutableArray *enemyArray;
    Enemy *newEnemy1;
    enemyArray = [[[NSMutableArray alloc] init] autorelease];
    
    int delay = 5;
    Level *loadlevel = [[self loadedLevels] objectAtIndex:levelNumber];
    
    int typeOfEnemies = [[loadlevel avaliableEnemies] count];
    NSLog(@"Type of enemies %d",typeOfEnemies);
   
    int groupCount = [(NSNumber *)[[loadlevel waves] objectAtIndex:wave] intValue]/8;
    NSLog(@"Group Count %d",groupCount);
    
    int rand;
    NSString *enemyName;
    EnemyParams *eparams;
    
    
    for (int i = 0; i<groupCount; i++) {
        
        if (i == 0){
            delay = 0;
        }else{
            delay = 5;
        }
        
        // Position 7
        rand = arc4random() % typeOfEnemies;
        enemyName = [[loadlevel avaliableEnemies] objectAtIndex:rand];
        eparams = [[self enemyDictMutable] objectForKey:enemyName];
        eparams.typeOfPowerUp = [self checkForPowerUp];
        
        newEnemy1 = [[[RobotBlaster alloc]
                      initwithStartPosition:[[UniversalInfo sharedInstance]enemyPosition7] actionTime:1.7*i+delay
                      delegate:scnDelegate enemyParams:eparams enemyPosition:POS7
                      shootEndPos:[[UniversalInfo sharedInstance]enemyPosition3]] autorelease];
        
        [enemyArray addObject:newEnemy1];
        // Position 8
        rand = arc4random() % typeOfEnemies;
        enemyName = [[loadlevel avaliableEnemies] objectAtIndex:rand];
        eparams = [[self enemyDictMutable] objectForKey:enemyName];
        eparams.typeOfPowerUp = [self checkForPowerUp];
        
        newEnemy1 = [[[RobotBlaster alloc]
                      initwithStartPosition:[[UniversalInfo sharedInstance]enemyPosition8] actionTime:2.9*i+delay
                      delegate:scnDelegate enemyParams:eparams enemyPosition:POS8 shootEndPos:[[UniversalInfo sharedInstance]enemyPosition4]] autorelease];
        
        [enemyArray addObject:newEnemy1];
        // Position 4
        rand = arc4random() % typeOfEnemies;
        enemyName = [[loadlevel avaliableEnemies] objectAtIndex:rand];
        eparams = [[self enemyDictMutable] objectForKey:enemyName];
        eparams.typeOfPowerUp = [self checkForPowerUp];
        
        newEnemy1 = [[[RobotBlaster alloc]
                      initwithStartPosition:[[UniversalInfo sharedInstance]enemyPosition4] actionTime:2.5*i+delay
                      delegate:scnDelegate enemyParams:eparams enemyPosition:POS4 shootEndPos:[[UniversalInfo sharedInstance]enemyPosition8]] autorelease];
        
        [enemyArray addObject:newEnemy1];
        // Position 2
        rand = arc4random() % typeOfEnemies;
        enemyName = [[loadlevel avaliableEnemies] objectAtIndex:rand];
        eparams = [[self enemyDictMutable] objectForKey:enemyName];
        eparams.typeOfPowerUp = [self checkForPowerUp];
        
        newEnemy1 = [[[RobotBlaster alloc]
                      initwithStartPosition:[[UniversalInfo sharedInstance]enemyPosition2] actionTime:1*i+delay
                      delegate:scnDelegate enemyParams:eparams enemyPosition:POS2 shootEndPos:[[UniversalInfo sharedInstance]enemyPosition6]] autorelease];
        
        [enemyArray addObject:newEnemy1];
        // Position 6
        rand = arc4random() % typeOfEnemies;
        enemyName = [[loadlevel avaliableEnemies] objectAtIndex:rand];
        eparams = [[self enemyDictMutable] objectForKey:enemyName];
        eparams.typeOfPowerUp = [self checkForPowerUp];
        
        newEnemy1 = [[[RobotBlaster alloc]
                      initwithStartPosition:[[UniversalInfo sharedInstance]enemyPosition6] actionTime:1.8*i+delay
                      delegate:scnDelegate enemyParams:eparams enemyPosition:POS6 shootEndPos:[[UniversalInfo sharedInstance]enemyPosition2]] autorelease];
        
        [enemyArray addObject:newEnemy1];
        // Position 1
        rand = arc4random() % typeOfEnemies;
        enemyName = [[loadlevel avaliableEnemies] objectAtIndex:rand];
        eparams = [[self enemyDictMutable] objectForKey:enemyName];
        eparams.typeOfPowerUp = [self checkForPowerUp];
        
        newEnemy1 = [[[RobotBlaster alloc]
                      initwithStartPosition:[[UniversalInfo sharedInstance]enemyPosition1] actionTime:0.3*i+delay
                      delegate:scnDelegate enemyParams:eparams enemyPosition:POS1 shootEndPos:[[UniversalInfo sharedInstance]enemyPosition5]] autorelease];
        
        [enemyArray addObject:newEnemy1];
        // Position 3
        rand = arc4random() % typeOfEnemies;
        enemyName = [[loadlevel avaliableEnemies] objectAtIndex:rand];
        eparams = [[self enemyDictMutable] objectForKey:enemyName];
        eparams.typeOfPowerUp = [self checkForPowerUp];
        
        newEnemy1 = [[[RobotBlaster alloc]
                      initwithStartPosition:[[UniversalInfo sharedInstance]enemyPosition3] actionTime:0.3*i+5+delay
                      delegate:scnDelegate enemyParams:eparams enemyPosition:POS3 shootEndPos:[[UniversalInfo sharedInstance]enemyPosition7]] autorelease];
        
        [enemyArray addObject:newEnemy1];
        // Position 5
        rand = arc4random() % typeOfEnemies;
        enemyName = [[loadlevel avaliableEnemies] objectAtIndex:rand];
        eparams = [[self enemyDictMutable] objectForKey:enemyName];
        eparams.typeOfPowerUp = [self checkForPowerUp];
        
        newEnemy1 = [[[RobotBlaster alloc]
                      initwithStartPosition:[[UniversalInfo sharedInstance]enemyPosition5] actionTime:0.3*i+5+delay
                      delegate:scnDelegate enemyParams:eparams enemyPosition:POS5 shootEndPos:[[UniversalInfo sharedInstance]enemyPosition1]] autorelease];
        
        [enemyArray addObject:newEnemy1];

    }

    return loadlevel;
}


-(void)loadLevelJson
{
    NSLog(@"Loading json");
   
    NSBundle *appBundle = [NSBundle bundleForClass:[self class]];
    NSString *levelDataPath = [appBundle pathForResource:@"level1" ofType:@"json"];
    NSString *jsonString = [NSString stringWithContentsOfFile:levelDataPath encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary *results = [jsonString JSONValue];
    
    self.totalLevels = [results count];
    
    NSString *level;
    NSNumber *numberWaves;
    NSNumber *enemyAvaliables;
    
    self.loadedLevels = [[[NSMutableArray alloc] init] autorelease];
    
    for (level in results){
        
        NSDictionary *levelInfo = [results valueForKey:level];
        
        Level *readLevel = [[[Level alloc] init] autorelease];
        [readLevel setTotalLevelEnemies:0];
        
        numberWaves = [[[NSNumber alloc] initWithInt:[[levelInfo valueForKey:@"numberOfWaves"] intValue]] autorelease];
        enemyAvaliables = [[[NSNumber alloc] initWithInt:[[levelInfo valueForKey:@"avaliableEnemies"] intValue]] autorelease];
        
        [readLevel setLevelContext:[[levelInfo valueForKey:@"levelContext"] intValue]];
        
        [readLevel setTotalWaveSPerLevel:[[levelInfo valueForKey:@"numberOfWaves"] intValue]];
        
        for ( int i = 0; i < [numberWaves intValue]; i++) {
            int waveEnemies = [[levelInfo valueForKey:[NSString stringWithFormat:@"wave%d", i+1]] intValue];
            readLevel.totalLevelEnemies = readLevel.totalLevelEnemies + waveEnemies;
            [[readLevel waves] addObject:[[[NSNumber alloc] initWithInt:waveEnemies] autorelease]];
                                    
        }
        
        for ( int i = 0; i < [enemyAvaliables intValue]; i++){
            [[readLevel avaliableEnemies] addObject:[levelInfo valueForKey:[NSString stringWithFormat:@"enemy%d", i+1]]];
        }
        
        [[self loadedLevels] addObject:readLevel];
        
    }
    [self loadEnemyDictFromJson];
}

@end
