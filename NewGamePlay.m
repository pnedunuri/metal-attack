//
//  NewGamePlay.m
//  MetalAttack
//
//  Created by Rafael Munhoz on 29/10/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "NewGamePlay.h"
#import "UniversalInfo.h"


@implementation NewGamePlay
/*
// Guitar 1 parameters
int guita1_weaponLeftx = 202; //fixed
int guita1_weaponRightx = 196; // fixed
int guita1_weaponyRight = 220; // fixed
int guita1_weaponyLeft = 220; // fixed
float const guita1_anchorRightX = 0.4545f; // fixed
float const guita1_anchorRightY = 0.952f; // fixed
float const guita1_anchorLeftX = 0.4591; // fixed
float const guita1_anchorLeftY = 0.04878f; //fixed


// Bass Parameters
int bass_weaponLeftx = 202; //fixed
int bass_weaponRightx = 196; // fixed
int bass_weaponyRight = 220; // fixed
int bass_weaponyLeft = 220; // fixed
float const bass_anchorRightX = 0.4545f; // fixed
float const bass_anchorRightY = 0.952f; // fixed
float const bass_anchorLeftX = 0.4591; // fixed
float const bass_anchorLeftY = 0.04878f; //fixed


// Guitar 2 parameters
int guita2_weaponLeftx = 102; //fixed
int guita2_weaponRightx = 98; // fixed
int guita2_weaponyRight = 301; // fixed
int guita2_weaponyLeft = 301; // fixed
float const guita2_anchorRightX = 0.4545f; // fixed
float const guita2_anchorRightY = 0.952f; // fixed
float const guita2_anchorLeftX = 0.4591; // fixed
float const guita2_anchorLeftY = 0.04878f; //fixed
*/


-(id)init{
    
    self = [super init];
    if (self) {
        NSLog(@"NewGamePlay init called !!!");
        
        
        //[self initBandPositions];
        
        self.bandSprite = [[BandSprite alloc] initBand];
        [self.bandSprite setPosition:[[UniversalInfo sharedInstance] screenCenter]];
        
        [[[self bandSprite] guitar1Sprite] setPosition:ccp([[self bandSprite]guita1_weaponRightx], [[self bandSprite] guita1_weaponyRight])];
        [[[self bandSprite] guitar1Sprite] setAnchorPoint:ccp([[self bandSprite]guita1_anchorRightX],[[self bandSprite]guita1_anchorRightY])];
        
        //[[[self bandSprite] guitar1Sprite] setAnchorPoint:ccp(guita1_anchorRightX,guita1_anchorRightY)];
        
        [[[self bandSprite] guitar2Sprite] setPosition:ccp([[self bandSprite]guita2_weaponRightx],[[self bandSprite] guita2_weaponyRight])];
        [[[self bandSprite] guitar2Sprite] setAnchorPoint:ccp([[self bandSprite]guita2_anchorRightX],[[self bandSprite]guita2_anchorRightY])];
        
        
        [[[self bandSprite] bassSprite] setPosition:ccp([[self bandSprite] bass_weaponRightx], [[self bandSprite]bass_weaponyRight])];
        [[[self bandSprite] bassSprite] setAnchorPoint:ccp([[self bandSprite]bass_anchorRightX],[[self bandSprite]bass_anchorRightY])];
        
        
        // the vocalist is inverted the fist position is looking to left side of the screen
        [[[self bandSprite] vocalUpBodySprite] setAnchorPoint:ccp([[self bandSprite] vocal_anchorRightX]
                                                                  ,[[self bandSprite] vocal_anchorRightY])];
        
        [[[self bandSprite] vocalUpBodySprite] setPosition:ccp([[self bandSprite] vocal_weaponLeftx], [[self bandSprite] vocal_weaponyLeft])];
        
        [[self bandSprite] setDelegate:self];
        
        //Another point to be paramitrized
        [[self bandSprite] setBandBlast:10];
        
        /*
        [self addChild:self.bandSprite];
        
        [self addChild:[[self bandSprite] drummerSprite] z:31];
        
        [self addChild:[[self bandSprite] bassBodySprite] z:32];
        [self addChild:[[self bandSprite] bassSprite] z:33];
        
        
        [self addChild:[[self bandSprite] gtBody1Sprite] z:34];
        [self addChild:[[self bandSprite] guitar1Sprite] z:35];
        
        [self addChild:[[self bandSprite] gtBody2Sprite] z:36];
        [self addChild:[[self bandSprite] guitar2Sprite] z:37];
        
        
        [self addChild:[[self bandSprite] vocalLwBodySprite] z:38];
        [self addChild:[[self bandSprite] vocalUpBodySprite] z:39];
         */
        
        //LevelController *lvcontroller = [LevelController sharedInstance];
        self.activeEnemies = [[NSMutableArray alloc] init];
        
        //totalLevel = [lvcontroller totalLevels];
        
        // Here we will have to load from user default settings but for now lets get start every
        // time
        
        //[self setWaveNumber:startWave];
        //[self setLevelNumber:startLevel];
        
        
        //new way to load a level and  wave
        //currentLevel = [lvcontroller loadLevel:[self levelNumber] waveNumber:[self waveNumber] delegate:self];
        // load the first value for the wave and level enemies counter.
        //self.levelEnemiesLeft = currentLevel.totalLevelEnemies;
        //self.waveEnemiesLeft = [(NSNumber *)[[currentLevel waves] objectAtIndex:[self waveNumber]] intValue];
        //self.isTouchEnabled = YES;
        //[self schedule:@selector(nextFrame:)];
        
        //[self createScenarioDecoration:[currentLevel levelContext]];
        
        
        CGPoint location;
        location.x = 0;
        location.y = 160;
        
        self.beginTouch = location;
        self.moved = NO;
        //self.state = GAME_STARTED;
        
        //[self setHudLayer:hud];
        
        //[[self hudLayer] setDelegate:self];
        
        //[[self hudLayer] doLevelPresentation:[self levelNumber]];
        
        BandVault *vault = [BandVault sharedInstance];
        
        self.scoreCount = vault.highScore;
        
        //int waveNumberForHud = waveNumber + 1;
        
        //NSNumber *waveNumberValue = [[NSNumber alloc] initWithInt:waveNumberForHud];
        //[[hudLayer labelWaveValue] setString:[waveNumberValue stringValue]];
        
        
        //NSNumber *totalWaveNumber = [[NSNumber alloc] initWithInt:[currentLevel totalWaveSPerLevel]];
        
        
        //NSString *waveNumberSeparator = [[NSString alloc] initWithString:@"/"];
        
        //waveNumberSeparator = [waveNumberSeparator stringByAppendingString:[totalWaveNumber stringValue]];
        
        //[[hudLayer labelWaveTotal] setString:waveNumberSeparator];
        
        self.touchEnded = YES;
        
        //[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"background-music-aac.caf"];
        
        //[self initPowerUpSprites];
        //[self addChild:hud z:100];
        
        [[self bandSprite] setBandCoins:vault.bandCoins];
        
        //[[self bandSprite] bandCoins];
        
        self.userInteractionEnabled = TRUE;
        
        
        
    }
    return self;
    
}

-(void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    [self addChild:self.bandSprite];
    
    [self addChild:[[self bandSprite] drummerSprite] z:31];
    
    [self addChild:[[self bandSprite] bassBodySprite] z:32];
    [self addChild:[[self bandSprite] bassSprite] z:33];
    
    
    [self addChild:[[self bandSprite] gtBody1Sprite] z:34];
    [self addChild:[[self bandSprite] guitar1Sprite] z:35];
    
    [self addChild:[[self bandSprite] gtBody2Sprite] z:36];
    [self addChild:[[self bandSprite] guitar2Sprite] z:37];
    
    
    [self addChild:[[self bandSprite] vocalLwBodySprite] z:38];
    [self addChild:[[self bandSprite] vocalUpBodySprite] z:39];
    
}

/*
-(void)initBandPositions
{
    NSLog(@"InitBandPositions");
 
    guita1_weaponLeftx = [[UniversalInfo sharedInstance] guita1WeaponLeftx];
    guita1_weaponRightx = [[UniversalInfo sharedInstance] guita1WeaponRightx];
    guita1_weaponyRight = [[UniversalInfo sharedInstance] guita1WeaponyRight];
    guita1_weaponyLeft = [[UniversalInfo sharedInstance] guita1WeaponyLeft];
    
    guita2_weaponLeftx = [[UniversalInfo sharedInstance] guita2WeaponLeftx];
    guita2_weaponRightx = [[UniversalInfo sharedInstance] guita2WeaponRightx];
    guita2_weaponyRight = [[UniversalInfo sharedInstance] guita2WeaponyRight];
    guita2_weaponyLeft = [[UniversalInfo sharedInstance] guita2WeaponyLeft];
    
    bass_weaponLeftx = [[UniversalInfo sharedInstance] bassWeaponLeftx];
    bass_weaponRightx = [[UniversalInfo sharedInstance] bassWeaponRightx];
    bass_weaponyRight = [[UniversalInfo sharedInstance] bassWeaponyRight];
    bass_weaponyLeft = [[UniversalInfo sharedInstance] bassWeaponyLeft];
    
}
 */



@end
