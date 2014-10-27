//
//  BandGamePlay.m
//  EightbitShooter
//
//  Created by Rafael Munhoz on 13/03/13.
//
//

/*
 Some Definitions
 ================
 
 Comments
 ========
 Retina display is disabled as the ipad simulator does not work
 with it enabled.
 
 Apple device resolutions
 ========================
 
 iphone 5 -> 1136 x 640 center 568 x 320
 4.0 in (100 mm);71:40aspect ratio;1,136 x 640 px
 screen resolution at 326 ppi
 
 iphone 4/4S -> 960 x 640 center 480 x 320
 960 × 640 px at 326 ppi, 800:1
 
 iphone 3GS -> 480 x 320 center 240 x 160
 480 × 320 px (HVGA) at 163 ppi, 200:1
 
 Ipad Mini -> 1024 x 768 screen center 512 x 384
 1024 × 768 px at 163 PPI 4:3 aspect ratio
 
 Ipad 2 -> 1024 x 768
 1,024 × 768 px (XGA) at 132 ppi, 800:1
 
 Ipad 3 -> 2048 x 1536 screen center 1024 x 768
 2,048 × 1,536 px resolution at 264 ppi
 
 Ipad 4 -> 2048 x 1536
 2,048 × 1,536 px resolution at 264 ppi
 
 Cocos2D file Sufix
 ===================
 
 Non-retina iPhone: image.png
 Retina iPhone: image-hd.png
 Non-retina iPad: image-ipad.png
 Retina iPad: image-ipadhd.png
 
 WARNING dont use apple sufix it can generate bugs
 
 
 Effort to turn to Universal App
 ===============================
 
 - Change the position of band creation
 - Change position of all pivots
 - Change position of all weapons
 - Change the position of the enemies creation
 - Change position of game hud
 
 */

#import "BandGamePlay.h"
//#import "CCTouchDispatcher.h"
#import "CCAnimation.h"
#import "Pause.h"
#import "UniversalInfo.h"
#import "PauseLayer.h"

@implementation BandGamePlay

Level *currentLevel;
int totalLevel;
// Guitar 1 parameters
int guita1_weaponLeftx = 202; //fixed
int guita1_weaponRightx = 196; // fixed
int guita1_weaponyRight = 220; // fixed
int guita1_weaponyLeft = 220; // fixed
float const guita1_anchorRightX = 0.4545f; // fixed
float const guita1_anchorRightY = 0.952f; // fixed
float const guita1_anchorLeftX = 0.4591; // fixed
float const guita1_anchorLeftY = 0.04878f; //fixed
//*** end of guitar1 parameters ***//

// Bass Parameters
int bass_weaponLeftx = 202; //fixed
int bass_weaponRightx = 196; // fixed
int bass_weaponyRight = 220; // fixed
int bass_weaponyLeft = 220; // fixed
float const bass_anchorRightX = 0.4545f; // fixed
float const bass_anchorRightY = 0.952f; // fixed
float const bass_anchorLeftX = 0.4591; // fixed
float const bass_anchorLeftY = 0.04878f; //fixed
//*** end of bass parameters ***//

// Guitar 2 parameters
int guita2_weaponLeftx = 102; //fixed
int guita2_weaponRightx = 98; // fixed
int guita2_weaponyRight = 301; // fixed
int guita2_weaponyLeft = 301; // fixed
float const guita2_anchorRightX = 0.4545f; // fixed
float const guita2_anchorRightY = 0.952f; // fixed
float const guita2_anchorLeftX = 0.4591; // fixed
float const guita2_anchorLeftY = 0.04878f; //fixed
//*** end of guitar2 parameters ***//


//*** end of vocal parameters ***//


@synthesize bandSprite;
@synthesize beginTouch;
@synthesize endTouch;
@synthesize rotationAngle;
@synthesize moved;
@synthesize activeEnemies;
@synthesize heroParticle;
@synthesize waveEnemiesLeft;
@synthesize levelEnemiesLeft;
@synthesize state;
@synthesize hudLayer;
@synthesize scoreCount;
@synthesize waveNumber;
@synthesize levelNumber;
@synthesize touchEnded;
@synthesize playerTouch;
@synthesize coinAnimFrames;
@synthesize coinAnimation;

+(CCScene *)sceneWithLevel:(int)levelNumber wave:(int)waveNumber
{
	CCScene *scene = [CCScene node];
    GameHud *hud = [GameHud node];
    //[scene addChild:hud z:1];
	BandGamePlay *layer = [[BandGamePlay alloc] initWithHudAndLevel:hud level:levelNumber wave:waveNumber];
	[scene addChild: layer];
	return scene;
}

-(void)initBandPositions
{
    /*
        
     The best way is to move all these information related to positioning and
     anchor points to class BandSprite.
     
     */
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

-(void)clearEnemyFire
{
    //NSLog(@"Clear Enemies");
    for (int j = 0; j< [[self activeEnemies] count]; j++){
        //[[CCScheduler sharedScheduler] unscheduleAllSelectorsForTarget: [[self activeEnemies] objectAtIndex:j]];
    
        [[[self activeEnemies] objectAtIndex:j] unscheduleAllSelectors];
    }
}

-(void)scenarioSoundBox:(CGPoint)backLPos backRightSprt:(CGPoint)backRPos frontRightSprt:(CGPoint)frontRPos frontLeftSprt:(CGPoint)frontLPos
{
    // this is just a method to insert the scenario decoration, this method
    // shall be sooner moved to the level controller.
    
    CCAnimation *ampAnim;
    
    CCSprite *ampBackLeftSprt = [[CCSprite alloc] init];
    CCAction *ampBackLeftAnim = [[CCAction alloc] init];
    
    CCSprite *ampBackRightSprt = [[CCSprite alloc] init];
    CCAction *ampBackRightAnim = [[CCAction alloc] init];
    
    CCSprite *ampFrontLeftSprt = [[CCSprite alloc] init];
    CCAction *ampFrontLeftAnim = [[CCAction alloc] init];
    
    CCSprite *ampFrontRightSprt = [[CCSprite alloc] init];
    CCAction *ampFrontRightAnim = [[CCAction alloc] init];
    
    
    NSMutableArray *ampBackLeftFrms = [[NSMutableArray alloc] init];
    NSMutableArray *ampBackRightFrms = [[NSMutableArray alloc] init];
    NSMutableArray *ampFrontLeftFrms = [[NSMutableArray alloc] init];
    NSMutableArray *ampFrontRightFrms = [[NSMutableArray alloc] init];
    
    for(int i = 1; i <= 3; ++i) {
        
        [ampBackLeftFrms addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"ampbackleft_frm%d.png", i]]];
        
        [ampBackRightFrms addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"ampbackright_frm%d.png", i]]];
        
        [ampFrontLeftFrms addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"ampfrontleft_frm%d.png", i]]];
        
        [ampFrontRightFrms addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"ampfrontright_frm%d.png", i]]];
        
    }
    

    
    ampAnim = [CCAnimation animationWithSpriteFrames:ampBackLeftFrms delay:0.05f];
    ampBackLeftAnim = [CCActionRepeatForever actionWithAction:[CCActionAnimate actionWithAnimation:ampAnim]];
    [ampBackLeftSprt runAction:ampBackLeftAnim];
    
    ampAnim = [CCAnimation animationWithSpriteFrames:ampBackRightFrms delay:0.05f];
    ampBackRightAnim = [CCActionRepeatForever actionWithAction:[CCActionAnimate actionWithAnimation:ampAnim]];
    [ampBackRightSprt runAction:ampBackRightAnim];
    
    ampAnim = [CCAnimation animationWithSpriteFrames:ampFrontRightFrms delay:0.05f];
    ampFrontRightAnim = [CCActionRepeatForever actionWithAction:[CCActionAnimate actionWithAnimation:ampAnim]];
    [ampFrontRightSprt runAction:ampFrontRightAnim];
    
    ampAnim = [CCAnimation animationWithSpriteFrames:ampFrontLeftFrms delay:0.05f];
    ampFrontLeftAnim = [CCActionRepeatForever actionWithAction:[CCActionAnimate actionWithAnimation:ampAnim]];
    [ampFrontLeftSprt runAction:ampFrontLeftAnim];
    
    ampBackLeftSprt.position = backLPos;
    ampBackRightSprt.position = backRPos;
    ampFrontRightSprt.position = frontRPos;
    ampFrontLeftSprt.position = frontLPos;
    
    [self addChild:ampBackLeftSprt z:20];
    [self addChild:ampBackRightSprt z:20];
    [self addChild:ampFrontRightSprt z:40];
    [self addChild:ampFrontLeftSprt z:40];
    
}

-(void)reportScore:(int64_t)score forCategory:(NSString*)category
{
    //NSLog(@"Reporting score");
    GKScore *scoreReporter = [[GKScore alloc] initWithCategory:category];
    scoreReporter.value = score;
    
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
        if (error != nil)
        {
            NSLog(@"Problem when publishing score");
        }
    }];
}

-(id)initWithHudAndLevel:(GameHud *)hud level:(int)startLevel wave:(int)startWave
{
	if( (self=[super init])) {
        

        [self initBandPositions];
    
        //[self schedule:@selector(nextFrame:)];
        
        [self schedule:@selector(nextFrame:) interval:0];
        
        self.bandSprite = [[BandSprite alloc] initBand];
        [self.bandSprite setPosition:[[UniversalInfo sharedInstance] screenCenter]];
        
        [[[self bandSprite] guitar1Sprite] setPosition:ccp([[self bandSprite]guita1_weaponRightx], [[self bandSprite] guita1_weaponyRight])];
        [[[self bandSprite] guitar1Sprite] setAnchorPoint:ccp([[self bandSprite]guita1_anchorRightX],[[self bandSprite]guita1_anchorRightY])];
        
        [[[self bandSprite] guitar1Sprite] setAnchorPoint:ccp(guita1_anchorRightX,guita1_anchorRightY)];
                
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
        
        [self addChild:bandSprite];
        
        [self addChild:[[self bandSprite] drummerSprite] z:31];
        
        [self addChild:[[self bandSprite] bassBodySprite] z:32];
        [self addChild:[[self bandSprite] bassSprite] z:33];

        
        [self addChild:[[self bandSprite] gtBody1Sprite] z:34];
        [self addChild:[[self bandSprite] guitar1Sprite] z:35];
        
        [self addChild:[[self bandSprite] gtBody2Sprite] z:36];
        [self addChild:[[self bandSprite] guitar2Sprite] z:37];
        
               
        [self addChild:[[self bandSprite] vocalLwBodySprite] z:38];
        [self addChild:[[self bandSprite] vocalUpBodySprite] z:39];
        
        LevelController *lvcontroller = [LevelController sharedInstance];
        self.activeEnemies = [[NSMutableArray alloc] init];
        
        totalLevel = [lvcontroller totalLevels];
        
        // Here we will have to load from user default settings but for now lets get start every
        // time
    
        [self setWaveNumber:startWave];
        [self setLevelNumber:startLevel];
        
    
        //new way to load a level and  wave
        currentLevel = [lvcontroller loadLevel:[self levelNumber] waveNumber:[self waveNumber] delegate:self];
        // load the first value for the wave and level enemies counter.
        self.levelEnemiesLeft = currentLevel.totalLevelEnemies;
        self.waveEnemiesLeft = [(NSNumber *)[[currentLevel waves] objectAtIndex:[self waveNumber]] intValue];
        //self.isTouchEnabled = YES;
        //[self schedule:@selector(nextFrame:)];
        
        [self createScenarioDecoration:[currentLevel levelContext]];
        
        
        CGPoint location;
        location.x = 0;
        location.y = 160;
        
        self.beginTouch = location;
        self.moved = NO;
        self.state = GAME_STARTED;

        [self setHudLayer:hud];

        [[self hudLayer] setDelegate:self];
        
        [[self hudLayer] doLevelPresentation:[self levelNumber]];
        
        BandVault *vault = [BandVault sharedInstance];
        
        self.scoreCount = vault.highScore;
        
        int waveNumberForHud = waveNumber + 1;
        
        NSNumber *waveNumberValue = [[NSNumber alloc] initWithInt:waveNumberForHud];
        [[hudLayer labelWaveValue] setString:[waveNumberValue stringValue]];
        
        
        NSNumber *totalWaveNumber = [[NSNumber alloc] initWithInt:[currentLevel totalWaveSPerLevel]];
        
        
        NSString *waveNumberSeparator = [[NSString alloc] initWithString:@"/"];
        
        waveNumberSeparator = [waveNumberSeparator stringByAppendingString:[totalWaveNumber stringValue]];
        
        [[hudLayer labelWaveTotal] setString:waveNumberSeparator];
        
        self.touchEnded = YES;
        
        //[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"background-music-aac.caf"];
        
        [self initPowerUpSprites];
        [self addChild:hud z:100];

        [[self bandSprite] setBandCoins:vault.bandCoins];
        
        //[[self bandSprite] bandCoins];
        
        self.userInteractionEnabled = TRUE;
        
    }
	return self;
}

-(void)createIpadScenario:(int)context
{
    NSLog(@"createIpadScenario resolution 768 x 1024");
    
    CCSprite* background;
    
    
    switch (context) {
        case 1:{
        NSLog(@"TheGarageScenario");
        background = [CCSprite spriteWithImageNamed:@"IpadSt1BG.jpg"];
        
        // this is another point that will be required to change as the level
        // decorations will depend on wich level is loaded
        CCSprite *leftWall = [[CCSprite alloc] initWithImageNamed:@"leftWall.png"];
        CCSprite *rightWall = [[CCSprite alloc] initWithImageNamed:@"rightWall.png"];
        CCSprite *garageDoor = [[CCSprite alloc] initWithImageNamed:@"portaGaragem.png"];
        
        leftWall.position = ccp(70,487);
        rightWall.position = ccp(690,470);
        garageDoor.position = ccp(377,980);
        
        [self addChild:leftWall z:45];
        [self addChild:rightWall z:45];
        [self addChild:garageDoor z:45];
        }
        
        break;
        
        case 2:{
        NSLog(@"TheSchoolScenario");
        background = [CCSprite spriteWithImageNamed:@"TheSchoolBgIpad.jpg"];
        
        // this is another point that will be required to change as the level
        // decorations will depend on wich level is loaded
        CCSprite *flags = [[CCSprite alloc] initWithImageNamed:@"Flags.png"];
        CCSprite *bus = [[CCSprite alloc] initWithImageNamed:@"Bus.png"];
        CCSprite *tree = [[CCSprite alloc] initWithImageNamed:@"tree.png"];
        CCSprite *rightBuildPart = [[CCSprite alloc] initWithImageNamed:@"rightBuildPart.png"];
        
        flags.position = ccp(400,770);
        bus.position = ccp(180,160);
        tree.position = ccp(500,960);
        rightBuildPart.position = ccp(377,980);
        
        [self addChild:flags z:45];
        [self addChild:bus z:45];
        [self addChild:tree z:45];
        // check why this asset does not fit.
        //[self addChild:rightBuildPart z:45];
        }
        
        break;
        
        case 3:{
        NSLog(@"TheBar");
        
        background = [CCSprite spriteWithImageNamed:@"TheBarBG.jpg"];
        
        // this is another point that will be required to change as the level
        // decorations will depend on wich level is loaded
        CCSprite *tables = [[CCSprite alloc] initWithImageNamed:@"tables.png"];
        CCSprite *pool = [[CCSprite alloc] initWithImageNamed:@"pool.png"];
        CCSprite *counter = [[CCSprite alloc] initWithImageNamed:@"counter.png"];
        CCSprite *backwall = [[CCSprite alloc] initWithImageNamed:@"BackWall.png"];
        
        tables.position = ccp(384,512);
        pool.position = ccp(384,512);
        counter.position = ccp(384,512);
        backwall.position = ccp(384,512);
        
        [self addChild:tables z:19];
        [self addChild:pool z:45];
        [self addChild:counter z:45];
        // check why this asset does not fit.
        [self addChild:backwall z:45];
        
        }
        break;
        
        case 4:{
        NSLog(@"ThePrision");
        background = [CCSprite spriteWithImageNamed:@"prisionBG.jpg"];
        
        // this is another point that will be required to change as the level
        // decorations will depend on wich level is loaded
        CCSprite *upwallright = [[CCSprite alloc] initWithImageNamed:@"upwallright.png"];
        CCSprite *upwallleft = [[CCSprite alloc] initWithImageNamed:@"upwallleft.png"];
        CCSprite *upwallcenter = [[CCSprite alloc] initWithImageNamed:@"upwallcenter.png"];
        CCSprite *walls = [[CCSprite alloc] initWithImageNamed:@"walls.png"];
        
        upwallright.position = ccp(384,512);
        upwallleft.position = ccp(384,512);
        upwallcenter.position = ccp(384,512);
        walls.position = ccp(384,512);
        
        [self addChild:upwallright z:19];
        [self addChild:upwallleft z:45];
        [self addChild:upwallcenter z:19];
        // check why this asset does not fit.
        [self addChild:walls z:45];
        }
        break;
        
        case 5:{
        NSLog(@"TheGasStation");
        background = [CCSprite spriteWithImageNamed:@"GasStationBG.jpg"];
        
        // this is another point that will be required to change as the level
        // decorations will depend on wich level is loaded
        CCSprite *roofup = [[CCSprite alloc] initWithImageNamed:@"roofup.png"];
        CCSprite *roofdown = [[CCSprite alloc] initWithImageNamed:@"roofdown.png"];
        CCSprite *frontPlate = [[CCSprite alloc] initWithImageNamed:@"frontPlate.png"];
        CCSprite *carright = [[CCSprite alloc] initWithImageNamed:@"carright.png"];
        CCSprite *carleft = [[CCSprite alloc] initWithImageNamed:@"carleft.png"];
        CCSprite *backwalls = [[CCSprite alloc] initWithImageNamed:@"backwalls.png"];
        
        roofup.position = ccp(384,512);
        roofdown.position = ccp(384,512);
        frontPlate.position = ccp(384,512);
        carright.position = ccp(384,512);
        carleft.position = ccp(384,512);
        backwalls.position = ccp(384,512);
        
        [self addChild:roofup z:19];
        [self addChild:roofdown z:80];
        [self addChild:frontPlate z:19];
        [self addChild:carright z:45];
        [self addChild:carleft z:19];
        [self addChild:backwalls z:18];
        }
        
        break;
        default:
        break;
    }
    
    //background.tag = 1;
    background.anchorPoint = CGPointMake(0, 0);
    [self addChild:background z:0];
    
    [self scenarioSoundBox:ccp(190,620) backRightSprt:ccp(580,620) frontRightSprt:ccp(575,390) frontLeftSprt:ccp(200,390)];
    
    /*
     ampBackLeftSprt.position = ccp(190,620);
     ampBackRightSprt.position = ccp(580,620);
     ampFrontRightSprt.position = ccp(575,390);
     ampFrontLeftSprt.position = ccp(200,390);
   */
    
    //[self scenarioSoundBox];
}

-(void)createIpadRetinaScenario:(int)context
{
    NSLog(@"createIpadRetinaScenario resolution 1536 x 2048");
}

-(void)createIphoneScenario:(int)context
{
    NSLog(@"createIphoneScenario resolution  640 x 960");
}

-(void)createIphone5Scenario:(int)context
{
    NSLog(@"createIphone5Scenario resolution 640 x 1136");
    
    CCSprite* background;
    
    
    switch (context) {
        case 1:{
        NSLog(@"TheGarageScenario");
        background = [CCSprite spriteWithImageNamed:@"garageBgIphone5.jpg"];
        
        // this is another point that will be required to change as the level
        // decorations will depend on wich level is loaded
        CCSprite *leftWall = [[CCSprite alloc] initWithImageNamed:@"leftWall.png"];
        CCSprite *rightWall = [[CCSprite alloc] initWithImageNamed:@"rightWall.png"];
        CCSprite *garageDoor = [[CCSprite alloc] initWithImageNamed:@"portaGaragem.png"];
        
        leftWall.position = ccp(20,255);
        rightWall.position = ccp(310,255);
        garageDoor.position = ccp(120,530);
        
        [self addChild:leftWall z:45];
        [self addChild:rightWall z:45];
        [self addChild:garageDoor z:45];
        
        }
        break;
        
        case 2:{
        NSLog(@"TheSchoolScenario");
        background = [CCSprite spriteWithImageNamed:@"schoolBgIphone5.jpg"];
        
        // this is another point that will be required to change as the level
        // decorations will depend on wich level is loaded
        CCSprite *flags = [[CCSprite alloc] initWithImageNamed:@"Flags.png"];
        CCSprite *bus = [[CCSprite alloc] initWithImageNamed:@"Bus.png"];
        CCSprite *tree = [[CCSprite alloc] initWithImageNamed:@"tree.png"];
        CCSprite *rightBuildPart = [[CCSprite alloc] initWithImageNamed:@"rightBuildPart.png"];
        
        flags.position = ccp(200,385);
        bus.position = ccp(90,80);
        tree.position = ccp(220,510);
        rightBuildPart.position = ccp(377,980);
        
        [self addChild:flags z:45];
        [self addChild:bus z:100];
        [self addChild:tree z:45];
        // check why this asset does not fit.
        //[self addChild:rightBuildPart z:45];
        
        }
        break;
        
        case 3:{
        NSLog(@"TheBar");
        
        background = [CCSprite spriteWithImageNamed:@"barBgIphone5.jpg"];
        
        // this is another point that will be required to change as the level
        // decorations will depend on wich level is loaded
        CCSprite *tables = [[CCSprite alloc] initWithImageNamed:@"tablesIphone5.png"];
        CCSprite *pool = [[CCSprite alloc] initWithImageNamed:@"poolIphone5.png"];
        CCSprite *counter = [[CCSprite alloc] initWithImageNamed:@"counterIphone5.png"];
        CCSprite *backwall = [[CCSprite alloc] initWithImageNamed:@"BackWallIphone5.png"];
        
        tables.position = ccp(160,284);
        pool.position = ccp(160,284);
        counter.position = ccp(160,284);
        backwall.position = ccp(160,284);
        
        [self addChild:tables z:19];
        [self addChild:pool z:45];
        [self addChild:counter z:45];
        // check why this asset does not fit.
        [self addChild:backwall z:45];
        }
        
        break;
        
        case 4:{
        NSLog(@"ThePrision");
        background = [CCSprite spriteWithImageNamed:@"prisionBGIphone5.jpg"];
        
        // this is another point that will be required to change as the level
        // decorations will depend on wich level is loaded
        CCSprite *upwallright = [[CCSprite alloc] initWithImageNamed:@"upwallrightIphone5.png"];
        CCSprite *upwallleft = [[CCSprite alloc] initWithImageNamed:@"upwallleftIphone5.png"];
        CCSprite *upwallcenter = [[CCSprite alloc] initWithImageNamed:@"upwallcenterIphone5.png"];
        CCSprite *walls = [[CCSprite alloc] initWithImageNamed:@"wallsIphone5.png"];
        
        upwallright.position = ccp(160,284);
        upwallleft.position = ccp(160,284);
        upwallcenter.position = ccp(160,284);
        walls.position = ccp(160,284);
        
        [self addChild:upwallright z:19];
        [self addChild:upwallleft z:45];
        [self addChild:upwallcenter z:19];
        // check why this asset does not fit.
        [self addChild:walls z:45];
        }
        break;
        
        case 5:{
        NSLog(@"TheGasStation");
        background = [CCSprite spriteWithImageNamed:@"gasStationBGIphone5.jpg"];
        
        // this is another point that will be required to change as the level
        // decorations will depend on wich level is loaded
        CCSprite *roofup = [[CCSprite alloc] initWithImageNamed:@"roofupIphone5.png"];
        CCSprite *roofdown = [[CCSprite alloc] initWithImageNamed:@"roofdownIphone5.png"];
        CCSprite *frontPlate = [[CCSprite alloc] initWithImageNamed:@"frontPlateIphone5.png"];
        CCSprite *carright = [[CCSprite alloc] initWithImageNamed:@"carrightIphone5.png"];
        CCSprite *carleft = [[CCSprite alloc] initWithImageNamed:@"carleftIphone5.png"];
        CCSprite *backwalls = [[CCSprite alloc] initWithImageNamed:@"backwallsIphone5.png"];
        
        roofup.position = ccp(160,284);
        roofdown.position = ccp(160,284);
        frontPlate.position = ccp(160,284);
        carright.position = ccp(160,284);
        carleft.position = ccp(160,284);
        backwalls.position = ccp(160,284);
        
        [self addChild:roofup z:19];
        [self addChild:roofdown z:100];
        [self addChild:frontPlate z:19];
        [self addChild:carright z:45];
        [self addChild:carleft z:19];
        [self addChild:backwalls z:18];
        }
        
        break;
        default:
        break;
    }
    
    //background.tag = 1;
    background.anchorPoint = CGPointMake(0, 0);
    [self addChild:background z:0];
    [self scenarioSoundBox:ccp(60,335) backRightSprt:ccp(260,335) frontRightSprt:ccp(252,223) frontLeftSprt:ccp(68,223)];
}



-(void)createScenarioDecoration:(int)context;
{
    // this method will create all the scenario decorations including it's background and
    // other decoration images, it will call other methods according the device that is running
    
    NSLog(@"Create Scenario Decoration !!");
    
    if ([[UniversalInfo sharedInstance] getDeviceType] == IPAD) {
        [self createIpadScenario:context];
    }else if ([[UniversalInfo sharedInstance] getDeviceType] == IPAD_RETINA){
        [self createIpadRetinaScenario:context];
    }else if ([[UniversalInfo sharedInstance] getDeviceType] == IPHONE_5) {
        [self createIphone5Scenario:context];
    }else if ([[UniversalInfo sharedInstance] getDeviceType] == IPHONE_4) {
        [self createIphone5Scenario:context];
    }
}

-(void)initPowerUpSprites
{
    // this method will start the powerup sprites animations the right thing
    // to do here is to create a new class called PowerUps that will handle
    // this kind of things
    
    // coin animation
    
    NSString *coinFrameName = @"coinflip0";
    
    self.coinAnimFrames = [[NSMutableArray alloc] init];
    
    for(int i = 1; i <= 6; i++) {
        NSString *frameName = [coinFrameName stringByAppendingString:@"%d.png"];
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:frameName,i]];
        [self.coinAnimFrames addObject:frame];
    }

    CCAnimation *animation = [CCAnimation animationWithSpriteFrames:self.coinAnimFrames delay:0.09f];
    
    self.coinAnimation = [CCActionRepeatForever actionWithAction:
                         [CCActionAnimate actionWithAnimation:animation]];
    
}

-(void)performPowerUp:(PowerUp)type initialPoint:(CGPoint)point;
{
    CCSprite *powerUp;
    id jump;
    id fadeOut;
    CCActionSequence *actionSequence;
    
    // force only coin for test purposes
    type = COIN;
    
    switch (type) {
        case HEALTHPOWER:
            //NSLog(@"Release HEALTHPOWER power up !!!");
            powerUp = [[CCSprite alloc] initWithImageNamed:@"healthUp.png"];
            powerUp.position = point;
            [self addChild:powerUp];
            //jump = [CCJumpTo actionWithDuration:1 position:ccp(160,240) height:250 jumps:1];
            jump = [CCActionJumpTo actionWithDuration:1 position:[[UniversalInfo sharedInstance] screenCenter] height:250 jumps:1];
            fadeOut = [CCActionFadeOut actionWithDuration:0.5];
            actionSequence = [CCActionSequence actions:jump,fadeOut, nil];
            [powerUp runAction:actionSequence];
            [[self bandSprite] receiveHealthPowerUp:20];
            break;
        case GUNPOWER_1:
            //NSLog(@"Release GUNPOWER_1 power up !!!");
            powerUp = [[CCSprite alloc] initWithImageNamed:@"gunUp1.png"];
            powerUp.position = point;
            [self addChild:powerUp];
            jump = [CCActionJumpTo actionWithDuration:1 position:[[UniversalInfo sharedInstance] screenCenter] height:250 jumps:1];
            fadeOut = [CCActionFadeOut actionWithDuration:0.5];
            actionSequence = [CCActionSequence actions:jump,fadeOut, nil];
            [powerUp runAction:actionSequence];
            [[self bandSprite] setShootPower:30];
            break;
        case GUNPOWER_2:
            //NSLog(@"Release GUNPOWER_2 power up !!!");
            powerUp = [[CCSprite alloc] initWithImageNamed:@"gunUp2.png"];
            powerUp.position = point;
            [self addChild:powerUp];
            jump = [CCActionJumpTo actionWithDuration:1 position:[[UniversalInfo sharedInstance] screenCenter] height:250 jumps:1];
            fadeOut = [CCActionFadeOut actionWithDuration:0.5];
            actionSequence = [CCActionSequence actions:jump,fadeOut, nil];
            [powerUp runAction:actionSequence];
            [[self bandSprite] setShootPower:60];
            break;
        case RADIOPOWER:
            //NSLog(@"Release RADIOPOWER power up !!!");
            powerUp = [[CCSprite alloc] initWithImageNamed:@"radioUP.png"];
            powerUp.position = point;
            [self addChild:powerUp];
            jump = [CCActionJumpTo actionWithDuration:1 position:[[UniversalInfo sharedInstance] screenCenter] height:250 jumps:1];
            fadeOut = [CCActionFadeOut actionWithDuration:0.5];
            actionSequence = [CCActionSequence actions:jump,fadeOut, nil];
            [powerUp runAction:actionSequence];
            [[self bandSprite] setBandBlast:1];
            break;
        case COIN:
            //NSLog(@"Give one coin");
            //powerUp = [[[CCSprite alloc] initWithFile:@"coin.png"]autorelease];
            powerUp = [[CCSprite alloc] init];
            [powerUp runAction:self.coinAnimation];
            [powerUp setScale:0.30];
            powerUp.position = point;
            [self addChild:powerUp];
            jump = [CCActionJumpTo actionWithDuration:1 position:[[UniversalInfo sharedInstance] screenCenter] height:250 jumps:1];
            fadeOut = [CCActionFadeOut actionWithDuration:0.5];
            actionSequence = [CCActionSequence actions:jump,fadeOut, nil];
            [powerUp runAction:actionSequence];
            self.bandSprite.bandCoins = self.bandSprite.bandCoins + 1;
            break;
        default:
            break;
    }
}

-(void)checkEnemyHeroColision
{
    // this method will check if the a enemy has collided with each one of the heroes
    // this will only be valid for meele and autodestruction enemies
    // Maybe it will be required to parametrize the inset values.
    
    CGRect guita1Rect;
    CGRect guita2Rect;
    CGRect bassRect;
    CGRect drummerRect;
    CGRect vocalRectUp;
    CGRect vocalRectDn;

    if ([[UniversalInfo sharedInstance] getDeviceType] == IPHONE_5) {
        
        guita1Rect = CGRectInset([[[self bandSprite] gtBody1Sprite] boundingBox],25, 25);
        guita2Rect = CGRectInset([[[self bandSprite] gtBody2Sprite] boundingBox],25, 25);
        bassRect = CGRectInset([[[self bandSprite] bassBodySprite] boundingBox],25, 25);
        drummerRect = CGRectInset([[[self bandSprite] drummerSprite] boundingBox],25, 65);
        vocalRectUp = CGRectInset([[[self bandSprite] vocalUpBodySprite] boundingBox],25, 25);
        vocalRectDn = CGRectInset([[[self bandSprite] vocalLwBodySprite] boundingBox],25, 25);
        
    }else{
        
        guita1Rect = CGRectInset([[[self bandSprite] gtBody1Sprite] boundingBox],50, 50);
        guita2Rect = CGRectInset([[[self bandSprite] gtBody2Sprite] boundingBox],50, 50);
        bassRect = CGRectInset([[[self bandSprite] bassBodySprite] boundingBox], 50,50);
        drummerRect = CGRectInset([[[self bandSprite] drummerSprite] boundingBox],50,130);
        vocalRectUp = CGRectInset([[[self bandSprite] vocalUpBodySprite] boundingBox],50, 50);
        vocalRectDn = CGRectInset([[[self bandSprite] vocalLwBodySprite] boundingBox],50,50);
    }
    
    for (int i = 0; i< [[self activeEnemies] count]; i++){
 
        CGRect enemyBoundBox;
        
        if ([[[self activeEnemies] objectAtIndex:i] attackType] == MEELEE){
            enemyBoundBox = [[[self activeEnemies] objectAtIndex:i] meeleRect];
        }else{
            enemyBoundBox =[[[[self activeEnemies] objectAtIndex:i] enemySprite] boundingBox];
        }
        
        if (!CGRectIsNull(CGRectIntersection(enemyBoundBox, guita1Rect)) && !([[self bandSprite] isGuita1Death])){
            //NSLog(@"guita1Rect was hitted by enemy");
            if ([[[self activeEnemies] objectAtIndex:i] attackType] == MEELEE){
                [[[self activeEnemies] objectAtIndex:i] meeleAttack:self.bandSprite bandComponent:GUITARRIST1_TYPE hitrect:CGRectIntersection(enemyBoundBox,guita1Rect)];
            }else if ([[[self activeEnemies] objectAtIndex:i] attackType] == AUTODESTRUCTION){
                float damagePoints = [[[self activeEnemies] objectAtIndex:i] autoDestruction];
                [[[self activeEnemies] objectAtIndex:i] setRemoveObject:YES];
                [[self bandSprite] hitByEnemy:damagePoints component:GUITARRIST1_TYPE rect:CGRectIntersection(enemyBoundBox, guita1Rect)];
            }
        }
        if (!CGRectIsNull(CGRectIntersection(enemyBoundBox, guita2Rect)) && !([[self bandSprite] isGuita2Death])){
            //NSLog(@"guita2Rect was hitted by enemy");
            if ([[[self activeEnemies] objectAtIndex:i] attackType] == MEELEE){
                [[[self activeEnemies] objectAtIndex:i] meeleAttack:self.bandSprite bandComponent:GUITARRIST2_TYPE hitrect:CGRectIntersection(enemyBoundBox,guita2Rect)];
            }else if ([[[self activeEnemies] objectAtIndex:i] attackType] == AUTODESTRUCTION){
                float damagePoints = [[[self activeEnemies] objectAtIndex:i] autoDestruction];
                [[[self activeEnemies] objectAtIndex:i] setRemoveObject:YES];
                [[self bandSprite] hitByEnemy:damagePoints component:GUITARRIST2_TYPE rect:CGRectIntersection(enemyBoundBox, guita2Rect)];
            }
        }
        
        if (!CGRectIsNull(CGRectIntersection(enemyBoundBox, bassRect)) && !([[self bandSprite] isBassDeath])){
            //NSLog(@"bassRect was hitted by enemy");
            if ([[[self activeEnemies] objectAtIndex:i] attackType] == MEELEE){
                [[[self activeEnemies] objectAtIndex:i] meeleAttack:self.bandSprite bandComponent:BASS_TYPE hitrect:CGRectIntersection(enemyBoundBox,bassRect)];
            }else if ([[[self activeEnemies] objectAtIndex:i] attackType] == AUTODESTRUCTION){
                float damagePoints = [[[self activeEnemies] objectAtIndex:i] autoDestruction];
                [[[self activeEnemies] objectAtIndex:i] setRemoveObject:YES];
                [[self bandSprite] hitByEnemy:damagePoints component:BASS_TYPE rect:CGRectIntersection(enemyBoundBox, bassRect)];
            }
         }
        
        if (!CGRectIsNull(CGRectIntersection(enemyBoundBox, drummerRect)) && !([[self bandSprite] isDrummerDeath])){
            //NSLog(@"drummerRect was hitted by enemy");
            if ([[[self activeEnemies] objectAtIndex:i] attackType] == MEELEE){
                [[[self activeEnemies] objectAtIndex:i] meeleAttack:self.bandSprite bandComponent:DRUMMER_TYPE hitrect:CGRectIntersection(enemyBoundBox,drummerRect)];
            }else if ([[[self activeEnemies] objectAtIndex:i] attackType] == AUTODESTRUCTION){
                float damagePoints = [[[self activeEnemies] objectAtIndex:i] autoDestruction];
                [[[self activeEnemies] objectAtIndex:i] setRemoveObject:YES];
                [[self bandSprite] hitByEnemy:damagePoints component:DRUMMER_TYPE rect:CGRectIntersection(enemyBoundBox, drummerRect)];
            }
        }
        
        if (!CGRectIsNull(CGRectIntersection(enemyBoundBox, vocalRectDn)) && !([[self bandSprite] isVocalDeath])){
            //NSLog(@"vocal was hitted by enemy");
            
            if ([[[self activeEnemies] objectAtIndex:i] attackType] == MEELEE){
                [[[self activeEnemies] objectAtIndex:i] meeleAttack:self.bandSprite bandComponent:VOCALS_TYPE hitrect:CGRectIntersection(enemyBoundBox,vocalRectDn)];
            }else if ([[[self activeEnemies] objectAtIndex:i] attackType] == AUTODESTRUCTION){
                float damagePoints = [[[self activeEnemies] objectAtIndex:i] autoDestruction];
                [[[self activeEnemies] objectAtIndex:i] setRemoveObject:YES];
                [[self bandSprite] hitByEnemy:damagePoints component:VOCALS_TYPE rect:CGRectIntersection(enemyBoundBox, vocalRectDn)];
            }
        }
        
        if (!CGRectIsNull(CGRectIntersection(enemyBoundBox, vocalRectUp)) && !([[self bandSprite] isVocalDeath])){
            //NSLog(@"vocal was hitted by enemy");
            
            if ([[[self activeEnemies] objectAtIndex:i] attackType] == MEELEE){
                [[[self activeEnemies] objectAtIndex:i] meeleAttack:self.bandSprite bandComponent:VOCALS_TYPE hitrect:CGRectIntersection(enemyBoundBox,vocalRectUp)];
            }else if ([[[self activeEnemies] objectAtIndex:i] attackType] == AUTODESTRUCTION){
                float damagePoints = [[[self activeEnemies] objectAtIndex:i] autoDestruction];
                [[[self activeEnemies] objectAtIndex:i] setRemoveObject:YES];
                [[self bandSprite] hitByEnemy:damagePoints component:VOCALS_TYPE rect:CGRectIntersection(enemyBoundBox, vocalRectUp)];
            }
        }
    }
}

/*
 Check if a enemy has colided with the band. There is a problem here, the problem is
 that the collision rect of the band is rect with no dimension, only a point, because of
 that the enemy projectil pass trought the band, it is better to divide the band and check
 the collision per component.
 */

-(BOOL)robotShootCollidedHero
{
    // this is the character colision separation, the same code will be needed to
    // autodestruction enemies.
    
    CGRect shootRect;
    // Maybe it will be required to parametrize the inset values.
    CGRect guita1Rect;
    CGRect guita2Rect;
    CGRect bassRect;
    CGRect drummerRect;
    CGRect vocalRectUp;
    CGRect vocalRectDn;
    
    if ([[UniversalInfo sharedInstance] getDeviceType] == IPHONE_5) {
        guita1Rect = CGRectInset([[[self bandSprite] gtBody1Sprite] boundingBox],5, 5);
        guita2Rect = CGRectInset([[[self bandSprite] gtBody2Sprite] boundingBox],5, 5);
        bassRect = CGRectInset([[[self bandSprite] bassBodySprite] boundingBox],5, 5);
        drummerRect = CGRectInset([[[self bandSprite] drummerSprite] boundingBox],5, 25);
        vocalRectUp = CGRectInset([[[self bandSprite] vocalUpBodySprite] boundingBox],5, 5);
        vocalRectDn = CGRectInset([[[self bandSprite] vocalLwBodySprite] boundingBox],5, 5);
    }else{
        guita1Rect = CGRectInset([[[self bandSprite] gtBody1Sprite] boundingBox],10, 10);
        guita2Rect = CGRectInset([[[self bandSprite] gtBody2Sprite] boundingBox],10, 10);
        bassRect = CGRectInset([[[self bandSprite] bassBodySprite] boundingBox], 10,10);
        drummerRect = CGRectInset([[[self bandSprite] drummerSprite] boundingBox],10,50);
        vocalRectUp = CGRectInset([[[self bandSprite] vocalUpBodySprite] boundingBox],10, 10);
        vocalRectDn = CGRectInset([[[self bandSprite] vocalLwBodySprite] boundingBox],10,10);
    }
    
    CCNode *robotShoot;
    
    for (int j = 0; j< [[self activeEnemies] count]; j++){
        for (int i = 0; i < [[[[self activeEnemies] objectAtIndex:j] activeShoots] count] ; i++){
            robotShoot = [[[[self activeEnemies] objectAtIndex:j] activeShoots] objectAtIndex:i];
            shootRect = [robotShoot boundingBox];
            
            // if there is a collision remove the enemy shoot.
            // a good implementation is to not remove the shoot when the
            // hero is death.
            
            if (!CGRectIsNull(CGRectIntersection(shootRect, guita1Rect)) ||
                !CGRectIsNull(CGRectIntersection(shootRect, guita2Rect)) ||
                !CGRectIsNull(CGRectIntersection(shootRect, bassRect))   ||
                !CGRectIsNull(CGRectIntersection(shootRect, drummerRect))||
                !CGRectIsNull(CGRectIntersection(shootRect, vocalRectDn))||
                !CGRectIsNull(CGRectIntersection(shootRect, vocalRectUp))){
                [robotShoot stopAllActions];
                [self removeChild:robotShoot cleanup:YES];
                [[[[self activeEnemies] objectAtIndex:j] activeShoots] removeObjectAtIndex:i];
            }
            // check if the hero is dead.
            if (!CGRectIsNull(CGRectIntersection(shootRect, guita1Rect)) && !([[self bandSprite] isGuita1Death])){
                //NSLog(@"guita1Rect was hitted by enemy");
                //change autoDestruction for blaster power
                float damagePoints = [[[self activeEnemies] objectAtIndex:j] weaponDamage];
                [[self bandSprite] hitByEnemy:damagePoints component:GUITARRIST1_TYPE rect:CGRectIntersection(shootRect, guita1Rect)];
            }
            
            if (!CGRectIsNull(CGRectIntersection(shootRect, guita2Rect)) && !([[self bandSprite] isGuita2Death])){
                //NSLog(@"guita2Rect was hitted by enemy");
                //change autoDestruction for blaster power
                float damagePoints = [[[self activeEnemies] objectAtIndex:j] weaponDamage];
                [[self bandSprite] hitByEnemy:damagePoints component:GUITARRIST2_TYPE rect:CGRectIntersection(shootRect, guita2Rect)];
            }
            
            if (!CGRectIsNull(CGRectIntersection(shootRect, bassRect)) && !([[self bandSprite] isBassDeath])){
                //NSLog(@"bassRect was hitted by enemy");
                //change autoDestruction for blaster power
                float damagePoints = [[[self activeEnemies] objectAtIndex:j] weaponDamage];
                [[self bandSprite] hitByEnemy:damagePoints component:BASS_TYPE rect:CGRectIntersection(shootRect, bassRect)];
            }
            
            if (!CGRectIsNull(CGRectIntersection(shootRect, drummerRect)) && !([[self bandSprite] isDrummerDeath])){
                //NSLog(@"drummerRect was hitted by enemy");
                //change autoDestruction for blaster power
                float damagePoints = [[[self activeEnemies] objectAtIndex:j] weaponDamage];
                [[self bandSprite] hitByEnemy:damagePoints component:DRUMMER_TYPE rect:CGRectIntersection(shootRect, drummerRect)];
            }
            
            if (!CGRectIsNull(CGRectIntersection(shootRect, vocalRectDn)) && !([[self bandSprite] isVocalDeath])){
                //NSLog(@"vocal was hitted by enemy");
                //change autoDestruction for blaster power
                float damagePoints = [[[self activeEnemies] objectAtIndex:j] weaponDamage];
                [[self bandSprite] hitByEnemy:damagePoints component:VOCALS_TYPE rect:CGRectIntersection(shootRect, vocalRectDn)];
            }
            
            if (!CGRectIsNull(CGRectIntersection(shootRect, vocalRectUp)) && !([[self bandSprite] isVocalDeath])){
                //NSLog(@"vocal was hitted by enemy");
                //change autoDestruction for blaster power
                float damagePoints = [[[self activeEnemies] objectAtIndex:j] weaponDamage];
                [[self bandSprite] hitByEnemy:damagePoints component:VOCALS_TYPE rect:CGRectIntersection(shootRect, vocalRectUp)];
            }
        }
    }
    
    return YES;
}

/*
 Check if the shoot of the band has collided with the enemy.
 */

-(BOOL)shootCollidedToTarget
{
    CGRect targetRect;
    CGRect shootRect;
    CGRect heroRect = [[self bandSprite] boundingBox];
    
    for (int j = 0; j< [[self activeEnemies] count]; j++){
        
        targetRect = [[[[self activeEnemies] objectAtIndex:j] enemySprite] boundingBox];
        for (int i = 0; i< [[bandSprite activeShoots] count]; i++){
            shootRect = [(CCNode *)[[bandSprite activeShoots] objectAtIndex:i] boundingBox];
            if (!CGRectIsNull(CGRectIntersection(shootRect, targetRect))){
                
                //first destroy the target.
                int enemyScore = [[[self activeEnemies] objectAtIndex:j]
                                  receiveHeroShoot:[[self bandSprite] shootPower] killNow:NO shootRect:shootRect];
                
                self.scoreCount = self.scoreCount + enemyScore;
                [[[bandSprite activeShoots] objectAtIndex:i] setRemoveObject:YES];
                
                if ([[[self activeEnemies] objectAtIndex:j] armor] <= 0){
                    [[[self activeEnemies] objectAtIndex:j] setRemoveObject:YES];
                }
            }
        }
        
        //On this point the enemy reached the hero this will work for autodestruction
        //enemies not for all, it should be put on a separeted method.
        if (!CGRectIsNull(CGRectIntersection(heroRect, targetRect))){
            // The enemy gets the hero
            
            if ([[[self activeEnemies] objectAtIndex:j] attackType] == MEELEE){
                //[[[self activeEnemies] objectAtIndex:j] meeleAttack:self.bandSprite];
            }else{
                //float damagePoints = [[[self activeEnemies] objectAtIndex:j] autoDestruction];
                //[[[self activeEnemies] objectAtIndex:j] setRemoveObject:YES];
                //[[self bandSprite] hitByEnemy:damagePoints];
            }
        }
    }
    
    // clean fire and enemy arrays
    
    for (int j = 0; j< [[self activeEnemies] count]; j++){
        if ([[[self activeEnemies] objectAtIndex:j] removeObject] == YES) {
            
            // Check for power up before remove the enemy. put this if again to include the coins
            //if ([[[self activeEnemies] objectAtIndex:j] typeOfPowerUp] != NOPOWERUP) {
                [self performPowerUp:[[[self activeEnemies] objectAtIndex:j] typeOfPowerUp]
                        initialPoint:[[[[self activeEnemies] objectAtIndex:j] enemySprite] position]];
            //}
            
            [[self activeEnemies] removeObjectAtIndex:j];
            self.waveEnemiesLeft = self.waveEnemiesLeft - 1;
            self.levelEnemiesLeft = self.levelEnemiesLeft - 1;
            //NSLog(@"Level Enemies left %d",self.levelEnemiesLeft);
            //NSLog(@"Wave Enemies left %d",self.levelEnemiesLeft);
        }
    }
    
    for (int i = 0; i< [[bandSprite activeShoots] count]; i++){
        
        if ([[[[self bandSprite] activeShoots] objectAtIndex:i] removeObject] == YES){
            [[[bandSprite activeShoots] objectAtIndex:i] stopAllActions];
            [self removeChild:[[bandSprite activeShoots] objectAtIndex:i] cleanup:YES];
            [[bandSprite activeShoots] removeObjectAtIndex:i];
        }
    }
    
    return YES;
}

- (void) nextFrame:(float)dt
{
    [self shootCollidedToTarget];
    [self robotShootCollidedHero];
    [self checkEnemyHeroColision];
    
    if ((!self.touchEnded) && ([[self bandSprite] guita1ReleaseFire] == YES)) {
        [self performBandShoot:self.playerTouch];
    }
    
    [hudLayer setIsBandShooting:!self.touchEnded];

    NSNumber *score = [[NSNumber alloc] initWithInt:[self scoreCount]];
    NSNumber *armor = [[NSNumber alloc] initWithFloat:[[self bandSprite] getTotalArmor]];
    NSNumber *heroCoins = [[NSNumber alloc] initWithFloat:[[self bandSprite] bandCoins]];
    
    [[hudLayer labelArmorPercent] setString:[armor stringValue]];
    [[hudLayer labelScore] setString:[score stringValue]];
    
    
    [[hudLayer labelCoinValue] setString:[[UniversalInfo sharedInstance] addZeroesToNumber:[heroCoins stringValue]]];
    
    
    
    if ([[self bandSprite] getTotalArmor] <= 0) {
        [self setState:GAME_OVER];
        //[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:[GameOver sceneWithNextLevel:[self levelNumber]]]];
        
        [[CCDirector sharedDirector] replaceScene:[GameOver sceneWithNextLevel:[self levelNumber]] withTransition:[CCTransition transitionFadeWithDuration:0.5f]];
        
        [self clearEnemyFire];
    }
    
    if ((self.levelEnemiesLeft == 0) && (self.state == GAME_STARTED)){
        NSLog(@"Level cleared !!!");
        // load the victory screen, on the victory screen implement a button to go to the next level.
        self.state = LEVEL_CLEARED;
        self.levelNumber++;
        
        NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
        [userdef setInteger:[[self bandSprite] bandCoins] forKey:@"coins"];
        [userdef setInteger:[self scoreCount] forKey:@"highScore"];
        
        BandVault *vault = [BandVault sharedInstance];
        vault.bandCoins = [[self bandSprite] bandCoins];
        vault.highScore = scoreCount;
        
        [self reportScore:vault.highScore forCategory:@"main_leader_board"];
        
        if ([self levelNumber] == totalLevel) {
            // the player finished the game
            //[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:[EndGame scene]]];
            [[CCDirector sharedDirector] replaceScene:[EndGame scene] withTransition:[CCTransition transitionFadeWithDuration:0.5f]];
        }else{
            // level cleared !!!
            //[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:[Victory sceneWithNextLevel:[self levelNumber]]]];
            [self closeDoor];
        }
        
    }else if ((self.waveEnemiesLeft == 0) && (self.state == GAME_STARTED)){
        NSLog(@"Wave cleared !");
        self.state = WAVE_CLEARED;
        [[self hudLayer] doWaveClearedAnimation];
        // show in the hud that the wave was cleared. At this point it necessary to load a new wave
        self.waveNumber = self.waveNumber + 1;
        NSNumber *waveNumberValue = [[NSNumber alloc] initWithInt:[self waveNumber] + 1];
        
        
        
        [[hudLayer labelWaveValue] setString:[waveNumberValue stringValue]];
        
        LevelController *lvcontroller = [LevelController sharedInstance];
        currentLevel = [lvcontroller loadLevel:[self levelNumber] waveNumber:[self waveNumber] delegate:self];
        self.waveEnemiesLeft = [(NSNumber *)[[currentLevel waves] objectAtIndex:[self waveNumber]] intValue];
        self.state = GAME_STARTED;
    }
    
    [self.hudLayer updateBandLifeBar:self.bandSprite];
}

-(void)doEndMoveDownDoor:(id)node
{
    NSLog(@"doEndMoveDownDoor BandGamePlay");
    //[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:[Victory sceneWithNextLevel:[self levelNumber]]]];
    
    //[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:2.0f scene:[Victory sceneWithNextLevel:levelNumber]]];
    
    //[[CCDirector sharedDirector] replaceScene:[CCTransitionZoomFlipX transitionWithDuration:2.0f scene:[Victory sceneWithNextLevel:levelNumber]]];
    
    [[CCDirector sharedDirector] replaceScene:[Victory sceneWithNextLevel:levelNumber]];
    
    
    //[[CCDirector sharedDirector] replaceScene:[CCTransitionZoomFlipX transitionWithDuration:2.0f scene:[Victory sceneWithNextLevel:levelNumber]]];
}

-(float)convertDegreeToRad:(float)angle
{
    return (angle/180)*M_PI;
}

-(float)convertRadToDegree:(float)angle
{
    return (180/M_PI)*angle;
}

- (CGPoint)fireCirclePoint
{
    CGPoint circle;
    circle.x = [[UniversalInfo sharedInstance] screenCenter].x + 1000*sin([self convertDegreeToRad:[self rotationAngle]]);
    circle.y = [[UniversalInfo sharedInstance] screenCenter].y + 1000*cos([self convertDegreeToRad:[self rotationAngle]]);
    
    return circle;
}

-(void)doEndFire:(id)node
{
    [(HeroShoot *)node setRemoveObject:YES];
    [self removeChild:node cleanup:YES];
}

-(void)fireLaser:(CGPoint)touchEndPoint
{
    if ([[CCDirector sharedDirector]isPaused] == NO){
        
        CGPoint shootPoint;
        CGPoint targetPoint;
        HeroShoot *laserbean;
        
        targetPoint = [self fireCirclePoint];
        // only increase the shoot power
        if ([[self bandSprite] shootPower] == 20){
            laserbean = [[HeroShoot alloc] initWithImageNamed:@"laser1.png"];
        }else if ([[self bandSprite] shootPower] == 30){
            laserbean = [[HeroShoot alloc] initWithImageNamed:@"bullet3.png"];
        }else{
            laserbean = [[HeroShoot alloc] initWithImageNamed:@"bomb3.png"];
        }
        
        [[bandSprite activeShoots] addObject:laserbean];
        [laserbean setRotation:self.rotationAngle+90];
        [[[self bandSprite] guitar1Sprite] setRotation:[self rotationAngle]+270];
        [[[self bandSprite] guitar2Sprite] setRotation:[self rotationAngle]+270];
        [[[self bandSprite] bassSprite] setRotation:[self rotationAngle]+270];
        
        if (![[self bandSprite] isVocalDeath]){
            [[[self bandSprite] vocalUpBodySprite] setRotation:[self rotationAngle]+270];
        }
        
        if (([self rotationAngle] <= 260) && ([self rotationAngle] >= 80)) {
            // blind spot for the vocalist
            if (![[self bandSprite] isVocalDeath]){
                self.bandSprite.vocalUpBodySprite.flipX = YES;
                self.bandSprite.vocalLwBodySprite.flipX = YES;
                [[[self bandSprite] vocalUpBodySprite] setAnchorPoint:ccp([[self bandSprite] vocal_anchorLeftX],[[self bandSprite] vocal_anchorLeftY])];
                [[[self bandSprite] vocalUpBodySprite] setPosition:ccp([[self bandSprite]vocal_weaponRightx], [[self bandSprite]vocal_weaponyRight])];
            }
        }else{
            if (![[self bandSprite] isVocalDeath]){
                //rotate vocal, the vocal is inverted on horizontal axis
                self.bandSprite.vocalUpBodySprite.flipX = NO;
                self.bandSprite.vocalLwBodySprite.flipX = NO;
                [[[self bandSprite] vocalUpBodySprite] setAnchorPoint:ccp([[self bandSprite] vocal_anchorRightX],[[self bandSprite] vocal_anchorRightY])];
                [[[self bandSprite] vocalUpBodySprite] setPosition:ccp([[self bandSprite] vocal_weaponLeftx], [[self bandSprite]vocal_weaponyLeft])];
            }
        }
        
        if (([self rotationAngle] <= 360) && ([self rotationAngle] >= 180)) {
            
            //rotate guitar 1
            if (![[self bandSprite] isGuita1Death]){
                self.bandSprite.guitar1Sprite.flipY = YES;
                self.bandSprite.gtBody1Sprite.flipX = YES;
                [[[self bandSprite] guitar1Sprite] setPosition:ccp([[self bandSprite ]guita1_weaponLeftx],[[self bandSprite ]guita1_weaponyLeft])];
                [[[self bandSprite] guitar1Sprite] setAnchorPoint:ccp([[self bandSprite ] guita1_anchorLeftX], [[self bandSprite ]guita1_anchorLeftY])];
            }
            
            //rotate guitar 2
            if (![[self bandSprite] isGuita2Death]){
                self.bandSprite.guitar2Sprite.flipY = YES;
                self.bandSprite.gtBody2Sprite.flipX = YES;
                [[[self bandSprite] guitar2Sprite] setPosition:ccp([[self bandSprite]guita2_weaponLeftx],[[self bandSprite] guita2_weaponyLeft])];
                [[[self bandSprite] guitar2Sprite] setAnchorPoint:ccp([[self bandSprite]guita2_anchorLeftX],[[self bandSprite]guita2_anchorLeftY])];
            }
            
            //rotate bass
            if (![[self bandSprite] isBassDeath]){
                self.bandSprite.bassSprite.flipY = YES;
                self.bandSprite.bassBodySprite.flipX = YES;
                [[[self bandSprite] bassSprite] setPosition:ccp([[self bandSprite]bass_weaponLeftx], [[self bandSprite]bass_weaponyLeft])];
                [[[self bandSprite] bassSprite] setAnchorPoint:ccp([[self bandSprite]bass_anchorLeftX],[[self bandSprite]bass_anchorLeftY])];
            }
    
            shootPoint = ccp([[self bandSprite]guita1_weaponLeftx],[[self bandSprite] guita1_weaponyLeft] - 30);
            
        }else{
            //rotate guitar 1
            if (![[self bandSprite] isGuita1Death]){
                self.bandSprite.guitar1Sprite.flipY = NO;
                self.bandSprite.gtBody1Sprite.flipX = NO;
                [[[self bandSprite] guitar1Sprite] setPosition:ccp([[self bandSprite] guita1_weaponRightx], [[self bandSprite] guita1_weaponyRight])];
                [[[self bandSprite] guitar1Sprite] setAnchorPoint:ccp([[self bandSprite] guita1_anchorRightX],[[self bandSprite] guita1_anchorRightY])];
            }
            
            //rotate guitar 2
            if (![[self bandSprite] isGuita2Death]){
                self.bandSprite.guitar2Sprite.flipY = NO;
                self.bandSprite.gtBody2Sprite.flipX = NO;
                [[[self bandSprite] guitar2Sprite] setPosition:ccp([[self bandSprite]guita2_weaponRightx],[[self bandSprite] guita2_weaponyRight])];
                [[[self bandSprite] guitar2Sprite] setAnchorPoint:ccp([[self bandSprite]guita2_anchorRightX],[[self bandSprite]guita2_anchorRightY])];
            }
            
            //rotate bass
            if (![[self bandSprite] isBassDeath]){
                self.bandSprite.bassSprite.flipY = NO;
                self.bandSprite.bassBodySprite.flipX = NO;
                [[[self bandSprite] bassSprite] setPosition:ccp([[self bandSprite]bass_weaponRightx], [[self bandSprite]bass_weaponyRight])];
                [[[self bandSprite] bassSprite] setAnchorPoint:ccp([[self bandSprite]bass_anchorRightX],[[self bandSprite]bass_anchorRightY])];
            }
            shootPoint = ccp([[self bandSprite]guita1_weaponRightx] + 10, [[self bandSprite] guita1_weaponyRight] - 30);
        }
        
        //it is needed to include this validation for all shooting chars
        //if ((![[self bandSprite] isGuita1Death]) && ([[self bandSprite] guita1ReleaseFire] == YES)) {
        
        float cooldownvalue = hudLayer.coolDownBar.percentage;
        
        if  (cooldownvalue > 0) {
            if (![[self bandSprite] isGuita1Death]) {
                [laserbean setPosition:shootPoint];
                [self addChild:laserbean];
                [laserbean stopAllActions];
                
                id actionFire = [CCActionMoveTo actionWithDuration:0.5 position:targetPoint];
                id endFireCallBack = [CCActionCallFunc actionWithTarget:self selector:@selector(doEndFire:)];
                id actionSequence = [CCActionSequence actions:actionFire, endFireCallBack, nil];
                
                [laserbean runAction:actionSequence];
                //[[SimpleAudioEngine sharedEngine] playEffect:@"pew-pew-lei.caf"];
                [[self bandSprite] runShootAnimation];
                
            }
        }
    }
}

-(float)getHeroRotationAngle
{
    float normaBegin = sqrtf(powf(self.beginTouch.x,2)+pow(self.beginTouch.y,2));
    float normaEnd = sqrtf(powf(self.endTouch.x,2)+powf(self.endTouch.y,2));
    float dotProduct = self.beginTouch.x * self.endTouch.x + self.beginTouch.y * self.endTouch.y;
    float angleDegrees = [self convertRadToDegree:acosf(dotProduct/(normaEnd*normaBegin))];
    if (self.endTouch.x < 0) {
        return 360 - angleDegrees;
    }else{
        return angleDegrees;
    }
}

/*
-(void)registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}*/

-(void)performBandShoot:(UITouch *)touch
{
    //NSLog(@"PerformBandShoot");
    //CGPoint location = [self convertTouchToNodeSpace: touch];
    CGPoint location = [touch locationInNode:self];
    
    location.x = location.x - self.bandSprite.position.x;
    location.y = location.y - self.bandSprite.position.y;
    self.endTouch = location;
    self.rotationAngle = self.getHeroRotationAngle;
    self.moved = YES;
    
    //[[[self hudLayer] coolDownBar] setPercentage:5];
    
    if ([[self bandSprite] guita1ReleaseFire] == YES) {
        [[self hudLayer] setIsBandShooting:YES];
        [self lowerCooldownBar];
        //[self fireLaser:[self convertTouchToNodeSpace:touch]];
        [self fireLaser:[touch locationInNode:self]];
    }
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"TouchBegan");
    self.playerTouch = touch;
    self.touchEnded = NO;
    return YES;
}


-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"TouchMoved");
    self.playerTouch = touch;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"TouchEnded");
    self.playerTouch = touch;
    self.touchEnded = YES;
}

-(void)removeEnemySprite:(CCSprite *)enemySprite
{
    [self removeChild:enemySprite cleanup:YES];
    if ([[self bandSprite] getTotalArmor] <= 0) {
        [self setState:GAME_OVER];
        //[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:[GameOver sceneWithNextLevel:[self levelNumber]]]];
        [[CCDirector sharedDirector] replaceScene:[GameOver sceneWithNextLevel:[self levelNumber]] withTransition:[CCTransition transitionFadeWithDuration:0.5f]];
    }
}

-(void)addEnemySprite:(Enemy *)enemy;
{
    if ((enemy.definedPosition == POS3) || (enemy.definedPosition == POS4)
        || (enemy.definedPosition == POS5)){
        [self addChild:[enemy enemySprite] z:2];
    }else if((enemy.definedPosition == POS6) || (enemy.definedPosition == POS2)){
        [self addChild:[enemy enemySprite] z:39];
    }else if ((enemy.definedPosition == POS1) || (enemy.definedPosition == POS8) ||
              (enemy.definedPosition == POS7)){
        [self addChild:[enemy enemySprite] z:50];
    }
    [[self activeEnemies] addObject:enemy];
}

-(BOOL)isGameOver;
{
    if (state == GAME_OVER) {
        return YES;
    }else{
        return FALSE;
    }
}

-(void)triggerRadioExplosion
{
    /*
    NSLog(@"Trigger RadioExplosion");
    // it is possible to implement a partial explosion
    if ([[self bandSprite] bandBlast] > 0 ) {
        [[self bandSprite] setBandBlast:0];
        [[self bandSprite] performBandBlast];
        // kill all enemies
        for (int j = 0; j< [[self activeEnemies] count]; j++){
            //first destroy the target.
#warning put receive hero shoot back
            //int enemyScore = 0;
            int enemyScore = [[[self activeEnemies] objectAtIndex:j]
                              receiveHeroShoot:[[self bandSprite] shootPower] killNow:YES];
            self.scoreCount = self.scoreCount + enemyScore;
            [[[self activeEnemies] objectAtIndex:j] setRemoveObject:YES];
        }
        
    }
     */
}


-(void)raiseCooldownBar
{
    CCProgressNode *cooldown = [[self hudLayer] coolDownBar];
    cooldown.percentage = cooldown.percentage + 0.5;
}

-(void)lowerCooldownBar
{
    CCProgressNode *cooldown = [[self hudLayer] coolDownBar];
    cooldown.percentage = cooldown.percentage - 0.5;
    
}

-(void)pauseGame
{
    if ([[CCDirector sharedDirector]isPaused] == YES){
        [self setState:GAME_STARTED];
        [[CCDirector sharedDirector] resume];
        [[self hudLayer] setOpacity:0];
        [[[self hudLayer] labelScore] setOpacity:255];
    }else{
        //[[CCDirector sharedDirector] pushScene:[CCTransitionRadialCCW transitionWithDuration:0.5f scene:[Pause pauseWithGamePlay:self]]];

        
        //[[CCDirector sharedDirector] pushScene:[Pause pauseWithGamePlay:self]];
        
        //[self addChild:pauseMenuLayer z:1];
        //[[CCDirector sharedDirector] pause];
        
        //PauseLayer *pauseLayer = [[PauseLayer alloc] initWithColor:ccc4(0, 0, 0, 200)];
        
        //PauseLayer *pauseLayer = [[PauseLayer alloc] init];
        
        PauseLayer *pauseLayer = [[PauseLayer alloc] initWithGamePlay:self];
        
        [hudLayer addChild:pauseLayer];
        //[hudLayer addChild:pauseMenuLayer];
        


    }
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    
    //NSLog(@"dealloc %d",activeEnemies.count);
    // in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	//[super dealloc];
}

@end
