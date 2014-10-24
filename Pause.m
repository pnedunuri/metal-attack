//
//  Pause.m
//  EightbitShooter
//
//  Created by Rafael Munhoz on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Pause.h"
#import "MainMenu.h"

@implementation Pause

@synthesize gameplayController;

+(CCLayerColor *) pauseWithGamePlay:(BandGamePlay*)gamePlayScene
{
    
    // 'scene' is an autorelease object.
	CCLayerColor *scene = [CCLayerColor node];
    
    // 'layer' is an autorelease object.
	Pause *layer = [[[Pause alloc] initWithGamePlay:gamePlayScene] autorelease];
    
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id)initWithGamePlay:(BandGamePlay*)gamePlayScene
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super initWithColor:ccc4(100, 100, 1000, 200)])) {

        
        CCSprite* background = [CCSprite spriteWithFile:@"pauseBg2.png"];
        background.tag = 1;
        background.anchorPoint = CGPointMake(0, 0);
        [self addChild:background];
        
        self.gameplayController = gamePlayScene;

        
        CCMenuItemImage *goMenuButton = [CCMenuItemImage itemFromNormalImage:@"goMenu.png"
                                                              selectedImage: @"goMenuClk.png"
                                                                     target:self
                                                                   selector:@selector(doBackMenu:)];
        
        CCMenuItemImage *ctrlSoundButton = [CCMenuItemImage itemFromNormalImage:@"ctrlSound.png"
                                                              selectedImage: @"ctrlSoundClk.png"
                                                                     target:self
                                                                   selector:@selector(soundControl:)];
        
        CCMenuItemImage *restartButton = [CCMenuItemImage itemFromNormalImage:@"restart.png"
                                                              selectedImage: @"restartClk.png"
                                                                     target:self
                                                                   selector:@selector(doRestart:)];
        
            
        
        CCMenu * pauseMenu1 = [CCMenu menuWithItems:goMenuButton, ctrlSoundButton, restartButton, nil];
        
        
        [pauseMenu1 alignItemsHorizontally];
        pauseMenu1.position = ccp(160,240);
        
            
        CCMenuItemImage * menuItem1 = [CCMenuItemImage itemFromNormalImage:@"resume.png"
                                                             selectedImage: @"resumeClk.png"
                                                                    target:self
                                                                  selector:@selector(doResume:)];
        
        CCMenu * myMenu = [CCMenu menuWithItems:menuItem1, nil];
        
        CGPoint menuposition;
        menuposition.x = 160;
        menuposition.y = 190;
        
        myMenu.position = menuposition;
        
        [self addChild:pauseMenu1];
        [self addChild:myMenu];
        
        //[[CCScheduler sharedScheduler] scheduleSelector:@selector(pauseDirector:) forTarget:self interval:1.0f paused:NO];

       
        
        
        
    }
	return self;
}

-(void) onEnterTransitionDidFinish{
    [[CCDirector sharedDirector] pause];
    
}

-(void)pauseDirector:(ccTime)dt
{
    NSLog(@"Pause Director");
    [[CCDirector sharedDirector] resume];
    [[CCScheduler sharedScheduler] unscheduleAllSelectorsForTarget:self];
    
    
}

- (void)doBack:(CCMenuItem *)menuItem 
{
	NSLog(@"Do Back");
    [[CCDirector sharedDirector] resume];
    //[[CCDirector sharedDirector] replaceScene: [MainMenu scene]];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionRadialCCW transitionWithDuration:0.5f scene:[MainMenu scene]]];
    //[[CCDirector sharedDirector] popScene];
}

- (void)doResume:(CCMenuItem *)menuItem
{
    NSLog(@"doResume");
    [[CCDirector sharedDirector] resume];
    // just for test
    [[CCDirector sharedDirector] resume];
    [[CCDirector sharedDirector] popScene];
    //[[CCDirector sharedDirector] popScene:[CCTransitionFadeTR transitionWithDuration:0.5f scene:nil]];
}

- (void)doRestart:(CCMenuItem *)menuItem
{
    NSLog(@"doRestart");
    [[CCDirector sharedDirector] resume];
    
    int levelNumber = [gameplayController levelNumber];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f
                                                                                 scene:[BandGamePlay sceneWithLevel:levelNumber wave:0]]];
 
}

-(void)doBackMenu:(CCMenuItem *)menuItem
{
    NSLog(@"doBackMenu");
    NSLog(@"Active enemies %d",[[gameplayController activeEnemies] count]);
    NSLog(@"Level number %d",[gameplayController levelNumber]);
    [[CCDirector sharedDirector] resume];
    [gameplayController setState:GAME_OVER];
    [gameplayController clearEnemyFire];
    
    //[[CCDirector sharedDirector] replaceScene: [MainMenu scene]];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionRadialCCW transitionWithDuration:0.5f scene:[MainMenu scene]]];
  
}

-(void)soundControl:(CCMenuItem *)menuItem
{
    NSLog(@"soundControl");    

}


@end
