//
//  GameHud.m
//  EightbitShooter
//
//  Created by Rafael Munhoz on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameHud.h"
#import "UniversalInfo.h"

@implementation GameHud

@synthesize hud1;
@synthesize hud2;
@synthesize labelWave;
@synthesize labelWaveValue;
@synthesize labelWaveTotal;
@synthesize labelArmor;
@synthesize labelArmorPercent;
@synthesize menuItem1;
@synthesize myMenu;
@synthesize menuItem2;
@synthesize myMenu2;
@synthesize labelScore; 
@synthesize delegate;
@synthesize labelWaveCleared;
@synthesize labelLevel;
@synthesize coin;
@synthesize labelCoinValue;
@synthesize inAppAmmo;
@synthesize inAppGenereal;
@synthesize inAppArmor;
@synthesize coolDownBar;
@synthesize isBandShooting;
@synthesize guita1Life;
@synthesize guita2Life;
@synthesize drummerLife;
@synthesize bassLife;
@synthesize vocalLife;
@synthesize guita1LifeIcon;
@synthesize guita2LifeIcon;
@synthesize drummerLifeIcon;
@synthesize bassLifeIcon;
@synthesize vocalLifeIcon;
@synthesize comboBG;
@synthesize bgLifeIcon;
@synthesize comboValue;
@synthesize comboBGSequence;
@synthesize moveComboToScreen;
@synthesize endMoveCombo;
@synthesize snakeBG;
@synthesize snakeBar;
@synthesize equipBG;
@synthesize comboLabelValue;
@synthesize blastValue;
@synthesize snakeHead;

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super initWithColor:[[CCColor alloc] initWithCcColor4b:ccc4(236, 56, 57, 0)]])) {

        CGPoint labelposition;
        labelposition.x = 160;
        labelposition.y = 240;
        
        //self.equipBG = [[CCSprite alloc] initWithSpriteFrameName:@"equip.png"];
        
        self.hud1 = [CCSprite spriteWithImageNamed:@"hud.png"];
        self.hud1.position = ccp(260,60);
        
        self.hud2 = [CCSprite spriteWithImageNamed:@"hud2.png"];
        self.hud2.position = ccp(120,457);

        self.coin = [CCSprite spriteWithImageNamed:@"coin.png"];
        self.coin.position = ccp(10,445);
        
        
        self.inAppArmor = [CCSprite spriteWithImageNamed:@"armorInApp.png"];
        self.inAppArmor.position = ccp(300,60);
        
        self.inAppAmmo  = [CCSprite spriteWithImageNamed:@"ammoUpInApp.png"];
        self.inAppAmmo.position = ccp(300,80);
        
        self.inAppGenereal = [CCSprite spriteWithImageNamed:@"coinMultInApp.png"];
        self.inAppGenereal.position = ccp(300,100);
        
        
        //self.labelCoinValue = [CCLabelTTF labelWithString:@"1" fontName:@"Marker Felt" fontSize:15];
        //self.labelCoinValue.position = ccp(80,445);

        self.labelWave = [CCLabelTTF labelWithString:@"Wave" fontName:@"Marker Felt" fontSize:15];
        self.labelWave.position = ccp(230,100);
        
        self.labelWaveValue = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:15];
        self.labelWaveValue.position = ccp(260,100);
        
        self.labelWaveTotal = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:15];
        self.labelWaveTotal.position = ccp(280,100);
        
        self.labelArmor = [CCLabelTTF labelWithString:@"Armor" fontName:@"Marker Felt" fontSize:15];
        self.labelArmor.position = ccp(232,80);
        
        self.labelArmorPercent = [CCLabelTTF labelWithString:@"100%" fontName:@"Marker Felt" fontSize:15];
        self.labelArmorPercent.position = ccp(270,80);

        
        self.labelScore = [CCLabelTTF labelWithString:@"000000000" fontName:@"Marker Felt" fontSize:18];
        [[self labelScore] setPosition:ccp(70,467)];
        
        
        self.labelWaveCleared = [CCLabelTTF labelWithString:@"Wave Cleared !!!" fontName:@"Marker Felt" fontSize:25];
        [[self labelWaveCleared] setPosition:ccp(160,350)];
        [labelWaveCleared setVisible:NO];
        
        
        self.labelLevel = [CCLabelTTF labelWithString:@"Level" fontName:@"Marker Felt" fontSize:25];
        [[self labelLevel] setPosition:ccp(160,350)];
        [labelLevel setVisible:NO];
        
        /*
        self.menuItem1 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSprite spriteWithImageNamed:@"skull-01.png"] highlightedSpriteFrame:        [CCSprite spriteWithImageNamed:@"skull-01.png"] disabledSpriteFrame:nil];
        [self.menuItem1 setTarget:self selector:@selector(doRadioBlast:)];
        
        self.myMenu = [[CCNode alloc] init];
        [self.myMenu addChild:menuItem1];
   
        self.menuItem2 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSprite spriteWithImageNamed:@"pause01.png"] highlightedSpriteFrame:        [CCSprite spriteWithImageNamed:@"pause02.png"] disabledSpriteFrame:nil];
        
        [self.menuItem2 setTarget:self selector:@selector(doPause:)];
        
        
        self.myMenu2 = [[CCNode alloc] init];
        [self.myMenu2 addChild:menuItem2];
         */
        

         
        //blast button Iphone 5
        //self.myMenu.position = ccp(190,390); // 190,390
        //[self.myMenu setScale:0.5];
        
        //pause button Iphone 5
        //[self.myMenu2 setScale:0.40];
        //self.myMenu2.position = ccp(207,375);
        
        
        //[equipBG setPosition:ccp(290,30)];
        //[equipBG setScale:0.4];
        
        self.blastValue = [CCLabelTTF labelWithString:@"x 3" fontName:@"28DaysLater" fontSize:20];
        [self.blastValue setPosition:ccp(262,11)];
        
        /*
        [self addChild:hud1];
        [self addChild:hud2];
        [self addChild:myMenu];
        [self addChild:myMenu2];
        [self addChild:labelWave];
        [self addChild:labelWaveValue];
        [self addChild:labelWaveTotal];
        [self addChild:labelArmor];
        [self addChild:labelArmorPercent];
        [self addChild:labelScore];
        [self addChild:labelWaveCleared];
        [self addChild:labelLevel];
        [self addChild:coin];
        [self addChild:labelCoinValue];
        [self addChild:inAppAmmo];
        [self addChild:inAppArmor];
        [self addChild:inAppGenereal];
        */
        [self initHudCoin];
        [self addChild:blastValue];
        //[self addChild:equipBG];
        [self createCoolDownBar];

        //[self addChild:myMenu];
        //[self addChild:myMenu2];

        [self mockCreateCombo];
        [self mockCreateSnakeToolBar];
        [self createBandLifeIcons];
        [self createBandLifeBar];

        [self schedule:@selector(raiseCooldownBar:) interval:0.01];
        [self schedule:@selector(mockDoComboPresentation:) interval:2];
        
        //[[CCScheduler sharedScheduler] scheduleSelector:@selector(raiseCooldownBar:) forTarget:self interval:0.01 paused:NO];
        //[[CCScheduler sharedScheduler] scheduleSelector:@selector(mockDoComboPresentation:) forTarget:self interval:2 paused:NO];

        
        self.isBandShooting = NO;

    }
	return self;
}

-(void)initHudCoin
{
    CCSprite *coinBg = [[CCSprite alloc] initWithImageNamed:@"coin-board.png"];
    [coinBg setScale:0.45];
    [coinBg setPosition:ccp(205,532)];
    [self addChild:coinBg];
    CCSprite *hudcoin = [[UniversalInfo sharedInstance] getSpriteWithCoinAnimation];
    [hudcoin setScale:0.16];
    [hudcoin setPosition:ccp(183,529)];
    [self addChild:hudcoin];
    self.labelCoinValue = [CCLabelTTF labelWithString:@"x 9999999" fontName:@"28DaysLater" fontSize:13];
    [self.labelCoinValue setPosition:ccp(211,529)];
    [self addChild:self.labelCoinValue];
}

-(void)mockCreateSnakeToolBar
{
    NSLog(@"Create Snake tool bar");
    
    self.snakeHead = [[CCSprite alloc] initWithImageNamed:@"snake-color-opened.png"];
    [self.snakeHead setScale:0.38];
    [self.snakeHead setPosition:ccp(240,540)];
    [self addChild:self.snakeHead];
    
    self.snakeBG = [[CCSprite alloc] initWithImageNamed:@"snake-flesh-body.png"];
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    
    self.snakeBar = [CCProgressNode progressWithSprite:[[CCSprite alloc] initWithImageNamed:@"snake-color-body.png"]];
    //self.snakeBar.type = kCCProgressTimerTypeHorizontalBarRL;
    
    self.snakeBar.percentage = 100;
    
    if ([[UniversalInfo sharedInstance] getDeviceType] == IPHONE_5) {

        //snakeBG.scaleY = 0.4;
        //snakeBG.scaleX = 0.35;
        [snakeBG setScale:0.38];
        
        //snakeBar.scaleY = 0.4;
        //snakeBar.scaleX = 0.35;
        [snakeBar setScale:0.38];

        self.snakeBG.position = ccp(122,533);
        snakeBar.position = ccp(122,533);
    }else{
        self.snakeBar.scaleX = 0.75;
        snakeBG.scaleX = 0.75;
        self.snakeBar.position = ccp(winSize.width/2 + 320, winSize.height/2);
        snakeBG.position = ccp(winSize.width/2 + 320, winSize.height/2);
    }
    
    [self addChild:snakeBG];
    [self addChild:self.snakeBar];
}

-(void)createCoolDownBar
{
    CCSprite *coolDownBarBoard = [[CCSprite alloc] initWithImageNamed:@"guitar-normal.png"];
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    self.coolDownBar = [CCProgressNode progressWithSprite:[[CCSprite alloc] initWithImageNamed:@"guitar-color.png"]];
    
    //self.coolDownBar.type = kCCProgressTimerTypeHorizontalBarLR;
    self.coolDownBar.percentage = 100;
    
    if ([[UniversalInfo sharedInstance] getDeviceType] == IPHONE_5) {
        [coolDownBarBoard setScale:0.38];
        [coolDownBar setScale:0.38];
        self.coolDownBar.position = ccp(148,543);
        coolDownBarBoard.position = ccp(148,543);
    }else{
        self.coolDownBar.scaleX = 0.75;
        coolDownBarBoard.scaleX = 0.75;
        self.coolDownBar.position = ccp(winSize.width/2 + 320, winSize.height/2);
        coolDownBarBoard.position = ccp(winSize.width/2 + 320, winSize.height/2);
    }
    
    [self addChild:coolDownBarBoard];
    [self addChild:self.coolDownBar];
}


-(void)mockCreateCombo
{
    // NSLog(@"mockCreateCombo");
    self.comboBG = [[CCSprite alloc] initWithImageNamed:@"backcombo.png"];
    [comboBG setScale:0.5];
    
    self.comboValue = [[CCSprite alloc] initWithImageNamed:@"como teste.png"];
    [comboValue setScale:0.5];
    [self.comboBG setPosition:ccp(-50,-50)];
    [self.comboValue setPosition:ccp(-50,-40)];
    
    
    self.comboLabelValue = [CCLabelTTF labelWithString:@"Combo x 3" fontName:@"28DaysLater" fontSize:40];
    //[self.comboLabelValue setColor:ccc3(255, 0, 0)];
    
    
    [comboLabelValue setPosition:ccpAdd([self.comboBG position], ccp(300,200))];
    [comboBG addChild:self.comboLabelValue];
    
    //[self addChild:comboLabelValue];
    [self addChild:comboBG];
    [self addChild:comboValue];
    
}

-(void)reverseComboPresentation
{
    //NSLog(@"reverseComboPresentation");
    id removeCombo = [CCActionMoveTo actionWithDuration:0.1 position:ccp(-50,-50)];
    [self.comboBG runAction:removeCombo];
    [self unscheduleAllSelectors];
    //[[CCScheduler sharedScheduler] unscheduleSelector:@selector(reverseComboPresentation:) forTarget:self];
}

-(void)doEndComboBgAnim:(id)node
{
    //NSLog(@"doEndComboBgAnim");
    
    [self schedule:@selector(reverseComboPresentation:) interval:1];
    
    //[[CCScheduler sharedScheduler] scheduleSelector:@selector(reverseComboPresentation:) forTarget:self interval:1 paused:NO];
}

-(void)mockDoComboPresentation
{
    //NSLog(@"mockDoComboPresentation");
    moveComboToScreen = [CCActionMoveBy actionWithDuration:0.1 position:ccp(80,80)];
    endMoveCombo = [CCActionCallFunc actionWithTarget:self selector:@selector(doEndComboBgAnim:)];
    comboBGSequence = [CCActionSequence actions:moveComboToScreen, endMoveCombo, nil];
    [self.comboBG runAction:self.comboBGSequence];
    self.snakeBar.percentage = self.snakeBar.percentage - 10;
}

-(void)createBandLifeIcons
{
    self.guita1LifeIcon = [[CCSprite alloc] initWithImageNamed:@"life_rash01.png"];
    self.guita2LifeIcon = [[CCSprite alloc] initWithImageNamed:@"life_evil01.png"];
    self.bassLifeIcon = [[CCSprite alloc] initWithImageNamed:@"life_war01.png"];
    self.drummerLifeIcon = [[CCSprite alloc] initWithImageNamed:@"life_ace01.png"];
    self.vocalLifeIcon = [[CCSprite alloc] initWithImageNamed:@"life_laxe01.png"];
    
    [self.guita1LifeIcon setScale:0.35];
    [self.guita2LifeIcon setScale:0.35];
    [self.bassLifeIcon setScale:0.35];
    [self.drummerLifeIcon setScale:0.35];
    [self.vocalLifeIcon setScale:0.35];
    
    [self.guita1LifeIcon setPosition:ccp(30,542)];
    [self.guita2LifeIcon setPosition:ccp(65,542)];
    [self.bassLifeIcon setPosition:ccp(99,542)];
    [self.drummerLifeIcon setPosition:ccp(132,542)];
    [self.vocalLifeIcon setPosition:ccp(164,542)];

    [self addChild:guita1LifeIcon];
    [self addChild:guita2LifeIcon];
    [self addChild:bassLifeIcon];
    [self addChild:vocalLifeIcon];
    [self addChild:drummerLifeIcon];
}


-(void)raiseCooldownBar
{
    // this will be a parameter of the band
    if (!self.isBandShooting) {
        self.coolDownBar.percentage = self.coolDownBar.percentage + 0.1;
    }
}

-(void)createBandLifeBar
{
    
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    
    self.guita1Life = [CCProgressNode progressWithSprite:[[CCSprite alloc] initWithImageNamed:@"lifebar.jpg"]];
    self.guita2Life = [CCProgressNode progressWithSprite:[[CCSprite alloc] initWithImageNamed:@"lifebar.jpg"]];
    self.bassLife = [CCProgressNode progressWithSprite:[[CCSprite alloc] initWithImageNamed:@"lifebar.jpg"]];
    self.drummerLife = [CCProgressNode progressWithSprite:[[CCSprite alloc] initWithImageNamed:@"lifebar.jpg"]];
    self.vocalLife = [CCProgressNode progressWithSprite:[[CCSprite alloc] initWithImageNamed:@"lifebar.jpg"]];
    
    //self.guita1Life.type = kCCProgressTimerTypeHorizontalBarLR;
    //self.guita2Life.type = kCCProgressTimerTypeHorizontalBarLR;
    //self.bassLife.type = kCCProgressTimerTypeHorizontalBarLR;
    //self.drummerLife.type = kCCProgressTimerTypeHorizontalBarLR;
    //self.vocalLife.type = kCCProgressTimerTypeHorizontalBarLR;
    
    [self.guita1Life setScale:0.25];
    [self.guita2Life setScale:0.25];
    [self.bassLife setScale:0.25];
    [self.drummerLife setScale:0.25];
    [self.vocalLife setScale:0.25];
    
    self.guita1Life.percentage = 100;
    self.guita1Life.position = ccp(30,533);
    
    self.guita2Life.percentage = 100;
    self.guita2Life.position = ccp(65,533);
    
    self.bassLife.percentage = 100;
    self.bassLife.position = ccp(98,533);
    
    self.drummerLife.percentage = 100;
    self.drummerLife.position = ccp(132,533);
    
    self.vocalLife.percentage = 100;
    self.vocalLife.position = ccp(163,533);
    
    [self addChild:self.guita1Life];
    [self addChild:self.guita2Life];
    [self addChild:self.drummerLife];
    [self addChild:self.vocalLife];
    [self addChild:self.bassLife];
}

-(void)updateBandLifeBar:(BandSprite *)bandSprite
{
    // this method will update the life bar of each caracter
    self.guita1Life.percentage = [bandSprite guitar1Armor] / [bandSprite totalGuitar1Armor] * 100;
    self.guita2Life.percentage = [bandSprite guitar2Armor] / [bandSprite totalGuitar2Armor] * 100;
    self.bassLife.percentage = [bandSprite bassArmor] / [bandSprite totalBassArmor] * 100;
    self.drummerLife.percentage = [bandSprite drummerArmor] / [bandSprite totalDrummerArmor] * 100;
    self.vocalLife.percentage = [bandSprite vocalArmor] / [bandSprite totalVocalArmor] * 100;
}


-(void)doRadioBlast
{
    NSLog(@"Trigger Radio Blast");
    //[[self delegate] triggerRadioExplosion];
}

-(void)doPause
{
    NSLog(@"Pause game");
    [[self delegate] pauseGame];

}

-(void)doWaveClearedAnimation
{
    NSLog(@"do wave cleared.");
    [[self labelWaveCleared] setVisible:YES];
    id fadeIn = [CCActionFadeIn actionWithDuration:1];
    id fadeOut = [CCActionFadeOut actionWithDuration:1];
    id sequence = [CCActionSequence actions: fadeIn, fadeOut, nil];
    [[self labelWaveCleared] runAction:sequence];
}

-(void)doLevelPresentation:(int)levelNumber;
{
    NSLog(@"do level presentation");
    
    levelNumber++;
    
    NSNumber *level = [[NSNumber alloc] initWithInt:levelNumber];
    NSString *levelString = [[NSString alloc] initWithFormat:@"Level %d",[level intValue]];
    
    [[self labelLevel] setString:levelString];
    [[self labelLevel] setVisible:YES];
    id fadeIn = [CCActionFadeIn actionWithDuration:1];
    id fadeOut = [CCActionFadeOut actionWithDuration:1];
    id sequence = [CCActionSequence actions: fadeIn, fadeOut, nil];
    [[self labelLevel] runAction:sequence];
}




@end
