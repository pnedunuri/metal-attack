//
//  PauseLayer.m
//  EightbitShooter
//
//  Created by Rafael Munhoz on 18/09/14.
//
//

#import "PauseLayer.h"

@implementation PauseLayer

@synthesize gameplayController;

-(id)initWithGamePlay:(BandGamePlay *)gamePlayScene;
{
    if( (self=[super initWithColor:ccc4(0, 0, 0, 200)])) {
        NSLog(@"Pause Layer");
        //[[CCDirector sharedDirector] pause];
        CCSprite* background = [CCSprite spriteWithFile:@"pauseBg2.png"];
        background.tag = 1;
        background.anchorPoint = CGPointMake(0, 0);
        [background setScale:2];
        [self addChild:background];

        self.gameplayController = gamePlayScene;
        
        CCMenuItemImage *goMenuButton = [CCMenuItemImage itemFromNormalImage:@"goMenu.png"
                                                               selectedImage: @"goMenuClk.png"
                                                                      target:self
                                                                    selector:@selector(doBackMenu:)];
        
        [goMenuButton setScale:2.5];
        
        CCMenuItemImage *ctrlSoundButton = [CCMenuItemImage itemFromNormalImage:@"ctrlSound.png"
                                                                  selectedImage: @"ctrlSoundClk.png"
                                                                         target:self
                                                                       selector:@selector(soundControl:)];
        [ctrlSoundButton setScale:2.5];
        
        
        CCMenuItemImage *restartButton = [CCMenuItemImage itemFromNormalImage:@"restart.png"
                                                                selectedImage: @"restartClk.png"
                                                                       target:self
                                                                     selector:@selector(doRestart:)];
        [restartButton setScale:2.5];
        
        
        CCMenu * pauseMenu1 = [CCMenu menuWithItems:goMenuButton, ctrlSoundButton, restartButton, nil];
        
        
        [pauseMenu1 alignItemsHorizontally];
        pauseMenu1.position = ccp(160,240);
        
        
        CCMenuItemImage * menuItem1 = [CCMenuItemImage itemFromNormalImage:@"resume.png"
                                                             selectedImage: @"resumeClk.png"
                                                                    target:self
                                                                  selector:@selector(doResume:)];
        
        [menuItem1 setScale:2];
        
        CCMenu * myMenu = [CCMenu menuWithItems:menuItem1, nil];
        
        CGPoint menuposition;
        menuposition.x = 160;
        menuposition.y = 190;
        
        myMenu.position = menuposition;
        
        [self addChild:pauseMenu1];
        [self addChild:myMenu];
        
        [[CCDirector sharedDirector] pause];
    
    }

    return self;
}

- (void)doResume:(CCMenuItem *)menuItem
{
    NSLog(@"doResume");
    [[CCDirector sharedDirector] resume];
    [[gameplayController hudLayer] removeChild:self cleanup:true];
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
    
    [[CCDirector sharedDirector] replaceScene: [MainMenu scene]];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionRadialCCW transitionWithDuration:0.5f scene:[MainMenu scene]]];
    
}

-(void)soundControl:(CCMenuItem *)menuItem
{
    NSLog(@"soundControl");
    
}


@end
