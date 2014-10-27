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

+(CCNodeColor *) pauseWithGamePlay:(BandGamePlay*)gamePlayScene
{
    
    // 'scene' is an autorelease object.
	CCNodeColor *scene = [CCNodeColor node];
    
    // 'layer' is an autorelease object.
	Pause *layer = [[Pause alloc] initWithGamePlay:gamePlayScene];
    
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id)initWithGamePlay:(BandGamePlay*)gamePlayScene
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	
    
    if( (self=[super initWithColor:[[CCColor alloc] initWithCcColor4b:ccc4(100, 100, 1000, 200)]])) {

        
        CCSprite* background = [CCSprite spriteWithImageNamed:@"pauseBg2.png"];
        //background.tag = 1;
        background.anchorPoint = CGPointMake(0, 0);
        [self addChild:background];
        
        self.gameplayController = gamePlayScene;

        
        //CCMenuItemImage *goMenuButton = [CCMenuItemImage itemFromNormalImage:@"goMenu.png"
        //                                                      selectedImage: @"goMenuClk.png"
        //                                                             target:self
        //                                                selector:@selector(doBackMenu:)];

        
        CCButton *goMenuButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSprite spriteWithImageNamed:@"goMenu.png"] highlightedSpriteFrame:        [CCSprite spriteWithImageNamed:@"goMenu.png"] disabledSpriteFrame:nil];
        
        [goMenuButton setTarget:self selector:@selector(doBackMenu)];
        
        
        //CCMenuItemImage *ctrlSoundButton = [CCMenuItemImage itemFromNormalImage:@"ctrlSound.png"
        //                                                      selectedImage: @"ctrlSoundClk.png"
        //                                                             target:self
        //                                                           selector:@selector(soundControl:)];
        
        
        CCButton *ctrlSoundButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSprite spriteWithImageNamed:@"ctrlSound.png"] highlightedSpriteFrame:        [CCSprite spriteWithImageNamed:@"ctrlSoundClk.png"] disabledSpriteFrame:nil];
        
        [ctrlSoundButton setTarget:self selector:@selector(soundControl:)];
        
        //CCMenuItemImage *restartButton = [CCMenuItemImage itemFromNormalImage:@"restart.png"
        //                                                      selectedImage: @"restartClk.png"
        //                                                             target:self
        //                                                           selector:@selector(doRestart:)];
        
        CCButton *restartButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSprite spriteWithImageNamed:@"restart.png"] highlightedSpriteFrame:        [CCSprite spriteWithImageNamed:@"restartClk.png"] disabledSpriteFrame:nil];
        
        [restartButton setTarget:self selector:@selector(doRestart)];
            
        
        //CCMenu * pauseMenu1 = [CCMenu menuWithItems:goMenuButton, ctrlSoundButton, restartButton, nil];
        
        CCNode *pauseMenu1 = [[CCNode alloc] init];
        
        [pauseMenu1 addChild:goMenuButton];
        [pauseMenu1 addChild:ctrlSoundButton];
        [pauseMenu1 addChild:restartButton];
        
        //[pauseMenu1 alignItemsHorizontally];
        pauseMenu1.position = ccp(160,240);
        
            
        //CCMenuItemImage * menuItem1 = [CCMenuItemImage itemFromNormalImage:@"resume.png"
        //                                                     selectedImage: @"resumeClk.png"
        //                                                            target:self
        //                                                          selector:@selector(doResume:)];
        
        

        
        CCButton *menuItem1 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSprite spriteWithImageNamed:@"resume.png"] highlightedSpriteFrame:[CCSprite spriteWithImageNamed:@"resumeClk.png"] disabledSpriteFrame:nil];
        
        [menuItem1 setTarget:self selector:@selector(doResume:)];
        
        CCNode * myMenu = [[CCNode alloc] init];
        [myMenu addChild:menuItem1];
        
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

-(void)pauseDirector:(float)dt
{
    NSLog(@"Pause Director");
    [[CCDirector sharedDirector] resume];
    //[[CCScheduler sharedScheduler] unscheduleAllSelectorsForTarget:self];
    [self unscheduleAllSelectors];
}

- (void)doBack:(CCButton *)menuItem
{
	NSLog(@"Do Back");
    [[CCDirector sharedDirector] resume];
    //[[CCDirector sharedDirector] replaceScene: [MainMenu scene]];
    //[[CCDirector sharedDirector] replaceScene:[CCTransitionRadialCCW transitionWithDuration:0.5f scene:[MainMenu scene]]];
    //[[CCDirector sharedDirector] popScene];
    [[CCDirector sharedDirector] replaceScene:[MainMenu scene] withTransition:[CCTransition transitionFadeWithDuration:0.5f]];
}

- (void)doResume:(CCButton *)menuItem
{
    NSLog(@"doResume");
    [[CCDirector sharedDirector] resume];
    // just for test
    [[CCDirector sharedDirector] resume];
    [[CCDirector sharedDirector] popScene];
    //[[CCDirector sharedDirector] popScene:[CCTransitionFadeTR transitionWithDuration:0.5f scene:nil]];
}

- (void)doRestart:(CCButton *)menuItem
{
    NSLog(@"doRestart");
    [[CCDirector sharedDirector] resume];
    
    int levelNumber = [gameplayController levelNumber];
    //[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f
        //                                                                         scene:[BandGamePlay sceneWithLevel:levelNumber wave:0]]];
 
    [[CCDirector sharedDirector] replaceScene:[BandGamePlay sceneWithLevel:levelNumber wave:0] withTransition:[CCTransition transitionFadeWithDuration:0.5]];

}

-(void)doBackMenu:(CCButton *)menuItem
{
    NSLog(@"doBackMenu");
    //NSLog(@"Active enemies %d",[[gameplayController activeEnemies] count]);
    NSLog(@"Level number %d",[gameplayController levelNumber]);
    [[CCDirector sharedDirector] resume];
    [gameplayController setState:GAME_OVER];
    [gameplayController clearEnemyFire];
    
    //[[CCDirector sharedDirector] replaceScene: [MainMenu scene]];
    //[[CCDirector sharedDirector] replaceScene:[CCTransitionRadialCCW transitionWithDuration:0.5f scene:[MainMenu scene]]];
    [[CCDirector sharedDirector] replaceScene:[MainMenu scene] withTransition:[CCTransition transitionCrossFadeWithDuration:0.5f]];
}


-(void)soundControl:(CCButton *)menuItem
{
    NSLog(@"soundControl");    

}


@end
