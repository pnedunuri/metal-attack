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
    if( (self=[super initWithColor:[[CCColor alloc] initWithCcColor4b:ccc4(236, 56, 57, 0)]])) {
        NSLog(@"Pause Layer");
        //[[CCDirector sharedDirector] pause];
        CCSprite* background = [CCSprite spriteWithImageNamed:@"pauseBg2.png"];
        //background.tag = 1;
        background.anchorPoint = CGPointMake(0, 0);
        [background setScale:2];
        [self addChild:background];

        self.gameplayController = gamePlayScene;
        
        //CCMenuItemImage *goMenuButton = [CCMenuItemImage itemFromNormalImage:@"goMenu.png"
        //                                                       selectedImage: @"goMenuClk.png"
        //                                                              target:self
        //                                                            selector:@selector(doBackMenu:)];
        
        CCButton *goMenuButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSprite spriteWithImageNamed:@"goMenu.png"] highlightedSpriteFrame:[CCSprite spriteWithImageNamed:@"goMenuClk.png"]  disabledSpriteFrame:nil];
        [goMenuButton setTarget:self selector:@selector(doBackMenu:)];
        [goMenuButton setScale:2.5];
        
        //CCMenuItemImage *ctrlSoundButton = [CCMenuItemImage itemFromNormalImage:@"ctrlSound.png"
        //                                                          selectedImage: @"ctrlSoundClk.png"
        //                                                                 target:self
        //                                                               selector:@selector(soundControl:)];
       
        CCButton *ctrlSoundButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSprite spriteWithImageNamed:@"ctrlSound.png"] highlightedSpriteFrame:[CCSprite spriteWithImageNamed:@"ctrlSoundClk.png"] disabledSpriteFrame:nil];
        
        [ctrlSoundButton setTarget:self selector:@selector(soundControl:)];
        [ctrlSoundButton setScale:2.5];
        
        
        //CCMenuItemImage *restartButton = [CCMenuItemImage itemFromNormalImage:@"restart.png"
        //                                                        selectedImage: @"restartClk.png"
        //                                                               target:self
        //                                                             selector:@selector(doRestart:)];
        
        CCButton *restartButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSprite spriteWithImageNamed:@"restart.png"] highlightedSpriteFrame:[CCSprite spriteWithImageNamed:@"restartClk.png"] disabledSpriteFrame:nil];
        [restartButton setTarget:self selector:@selector(doRestart)];
        [restartButton setScale:2.5];
        
        
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
        
        
        [menuItem1 setScale:2];
        
        //CCMenu * myMenu = [CCMenu menuWithItems:menuItem1, nil];
        
        CCNode *myMenu = [[CCNode alloc] init];
        
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

- (void)doResume:(CCButton *)menuItem
{
    NSLog(@"doResume");
    [[CCDirector sharedDirector] resume];
    [[gameplayController hudLayer] removeChild:self cleanup:true];
}

- (void)doRestart:(CCButton *)menuItem
{
    NSLog(@"doRestart");
    [[CCDirector sharedDirector] resume];
    
    int levelNumber = [gameplayController levelNumber];
    //[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f
    //                                                                             scene:[BandGamePlay sceneWithLevel:levelNumber wave:0]]];
    
    [[CCDirector sharedDirector] replaceScene:[BandGamePlay sceneWithLevel:levelNumber wave:0] withTransition:[CCTransition transitionFadeWithDuration:0.5f]];

}

-(void)doBackMenu:(CCButton *)menuItem
{
    NSLog(@"doBackMenu");
    NSLog(@"Active enemies %lu",(unsigned long)[[gameplayController activeEnemies] count]);
    NSLog(@"Level number %d",[gameplayController levelNumber]);
    [[CCDirector sharedDirector] resume];
    [gameplayController setState:GAME_OVER];
    [gameplayController clearEnemyFire];
    
    [[CCDirector sharedDirector] replaceScene: [MainMenu scene]];
    //[[CCDirector sharedDirector] replaceScene:[CCTransitionRadialCCW transitionWithDuration:0.5f scene:[MainMenu scene]]];
    
    [[CCDirector sharedDirector] replaceScene:[MainMenu scene] withTransition:[CCTransition transitionFadeWithDuration:0.5f]];
    

}

-(void)soundControl:(CCButton *)menuItem
{
    NSLog(@"soundControl");
    
}


@end
