//
//  Victory.m
//  EightbitShooter
//
//  Created by Rafael Munhoz on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Victory.h"
#import "MainMenu.h"
#import "GameNaveBar.h"
#import "UniversalInfo.h"
#import "BandVault.h"

@implementation Victory

int nextLevel;

CCSprite *drummerPoster;
CCSprite *guita1Poster;
CCSprite *guita2Poster;
CCSprite *bassPoster;
CCSprite *vocalPoster;

CCSprite *levelClearedBase;
CCSprite *stageText;
CCSprite *clearText;

+(CCScene *)sceneWithNextLevel:(int)number
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Victory *layer = [Victory node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	//nextLevel
    nextLevel = number;
    
    // return the scene
	return scene;
}

-(void)createLevelCleared
{
    levelClearedBase = [[CCSprite alloc] initWithImageNamed:@"StageClearbase.png"];
    stageText = [[CCSprite alloc] initWithImageNamed:@"StageClearSTAGE.png"];
    clearText = [[CCSprite alloc] initWithImageNamed:@"StageClearCLEAR.png"];
    CGPoint basePosition = [[UniversalInfo sharedInstance] screenCenter];
    basePosition = ccpAdd(basePosition,ccp(20,0));
    [levelClearedBase setPosition:basePosition];
    [clearText setPosition:ccp(-150, 157)];
    [stageText setPosition:ccp(450,400)];
    [stageText setScale:0.5];
    [clearText setScale:0.5];
    [levelClearedBase setScale:0.01];
    [levelClearedBase setVisible:false];
    [self addChild:levelClearedBase];
    [self addChild:clearText];
    [self addChild:stageText];
}

-(void)animateLevelCleared
{
    
    [levelClearedBase setVisible:true];
    id endMoveBaseLogo = [CCActionCallFunc actionWithTarget:self selector:@selector(doEndMoveLogoBase:)];
    
    CGPoint basePosition = [[UniversalInfo sharedInstance] screenCenter];
    basePosition = ccpAdd(basePosition,ccp(20,0));
    
    id animateBaseLogo = [CCActionScaleTo actionWithDuration:0.4 scale:0.5];
    id easeEffect = [CCActionEaseBounceInOut actionWithAction:animateBaseLogo];
    id moveLogoBaseSequence = [CCActionSequence actions:easeEffect, endMoveBaseLogo, nil];
    
    [levelClearedBase runAction:moveLogoBaseSequence];
}

-(void)doEndMoveLogoBase:(id)node
{
    CGPoint basePosition = [[UniversalInfo sharedInstance] screenCenter];
    basePosition = ccpAdd(basePosition,ccp(20,0));
    id animateStageText = [CCActionMoveTo actionWithDuration:0.5 position:ccpAdd(basePosition,ccp(-10, 35))];
    id endMoveStageText = [CCActionCallFunc actionWithTarget:self selector:@selector(doEndMoveStageText:)];
    id easeEffect = [CCActionEaseBounceInOut actionWithAction:animateStageText];
    id moveStageTextSequence = [CCActionSequence actions:easeEffect, endMoveStageText, nil];
    [stageText runAction:moveStageTextSequence];
}

-(void)doEndMoveStageText:(id)node
{
    CGPoint basePosition = [[UniversalInfo sharedInstance] screenCenter];
    basePosition = ccpAdd(basePosition,ccp(20,0));
    id animateClearText = [CCActionMoveTo actionWithDuration:0.5 position:ccpAdd(basePosition,ccp(0, -35))];
    id endMoveClearText = [CCActionCallFunc actionWithTarget:self selector:@selector(doEndMoveClearText:)];
    id easeEffect = [CCActionEaseBounceInOut actionWithAction:animateClearText];
    id moveClearTextSequence = [CCActionSequence actions:easeEffect, endMoveClearText, nil];
    [clearText runAction:moveClearTextSequence];
}

-(void)doEndMoveClearText:(id)node
{
    
}


-(void)createPosterSprites
{
    drummerPoster = [[CCSprite alloc] initWithImageNamed:@"Banda01.png"];
    guita1Poster = [[CCSprite alloc] initWithImageNamed:@"Banda02.png"];
    guita2Poster = [[CCSprite alloc] initWithImageNamed:@"Banda04.png"];
    bassPoster = [[CCSprite alloc] initWithImageNamed:@"Banda03.png"];
    vocalPoster = [[CCSprite alloc] initWithImageNamed:@"Banda05.png"];
    
    [drummerPoster setScale:0.40];
    [guita1Poster setScale:0.40];
    [guita2Poster setScale:0.40];
    [bassPoster setScale:0.40];
    [vocalPoster setScale:0.40];
    
    [drummerPoster setPosition:ccp(159, 800)];
    [guita1Poster setPosition:ccp(-100,270)];
    [bassPoster setPosition:ccp(700,300)];
    [guita2Poster setPosition:ccp(700,120)];
    [vocalPoster setPosition:ccp(-100,120)];
    
    [self addChild:drummerPoster];
    [self addChild:bassPoster];
    [self addChild:guita1Poster];
    [self addChild:guita2Poster];
    [self addChild:vocalPoster];
}

-(id)init
{
	if( (self=[super init])) {
        NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
        [userdef setInteger:nextLevel forKey:@"Level"];
        GameNaveBar *navBar = [[GameNaveBar alloc] initWithDelegagte:self];
        [self createPosterSprites];
        [self addChild:navBar];
        [self createLevelCleared];

    }
	return self;
}

-(void)doEndMoveDownDoor:(id)node
{
    if (self.userinfo == NEXT_LEVEL) {
        [[CCDirector sharedDirector] replaceScene:[BandGamePlay sceneWithLevel:nextLevel wave:0]];
    }else{
        [[CCDirector sharedDirector] replaceScene: [MainMenu scene]];
    }
}

-(void)doNext
{
    [self closeDoor];
    [self setUserinfo:NEXT_LEVEL];
}

-(void)doRestart
{
    
}

-(void)doBackMenu
{
    [self closeDoor];
    [self setUserinfo:MENU];
}

-(void)doStore
{
    
}

-(void)animatePoster
{
    // this method will create band poster figure animations
    
    id moveDrummer = [CCActionMoveTo actionWithDuration:0.3 position:ccp(159, 420)];
    id moveGuita1 = [CCActionMoveTo actionWithDuration:0.3 position:ccp(90, 270)];
    id moveGuita2 = [CCActionMoveTo actionWithDuration:0.3 position:ccp(240, 120)];
    id moveBass = [CCActionMoveTo actionWithDuration:0.3 position:ccp(270, 300)];
    id moveVocal = [CCActionMoveTo actionWithDuration:0.3 position:ccp(90, 120)];
    
    // crate the easing and improve the moviment
    
    id endAnimatePoster = [CCActionCallFunc actionWithTarget:self selector:@selector(doEndAnimatePoster:)];
    
    id animatePosterSequence = [CCActionSequence actions:moveDrummer, endAnimatePoster, nil];
    
    [guita1Poster runAction:moveGuita1];
    [guita2Poster runAction:moveGuita2];
    [bassPoster runAction:moveBass];
    [vocalPoster runAction:moveVocal];
    [drummerPoster runAction:animatePosterSequence];
}

-(void)doEndAnimatePoster:(id)node
{
    [self animateLevelCleared];
}

-(void)doEndMoveUpDoor:(id)node
{
    [self animatePoster];
}

@end
