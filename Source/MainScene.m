//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "BandGamePlay.h"

@implementation MainScene

-(id)init{
    
    self = [super init];
    
    if (self) {
        NSLog(@"MainScene init called !!!");
        /*
        LevelController *lvcontroller = [LevelController sharedInstance];
        
        [lvcontroller loadLevelJson];
        
        
        // Load sprite sheet once.
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"enemySheetNew.plist"];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"heroSheetNew.plist"];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"stage1Sheet.plist"];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"menuSheet.plist"];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"schoolEnemySheet.plist"];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"barEnemySheet.plist"];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"prisionEnemySheet.plist"];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"gasStEnemySheet.plist"];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"hudSheet.plist"];
         */
        
        self.userInteractionEnabled = TRUE;
    }
    
    return self;
}

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"Touch began !!!");
}

-(void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"Touch ended");
}

-(void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"Touch moved");
}

-(void)doRight
{
    NSLog(@"doRight");
}

-(void)doContinue
{
    NSLog(@"doContinue");
    //[[CCDirector sharedDirector] replaceScene:[BandGamePlay sceneWithLevel:0 wave:0] withTransition:[CCTransition transitionFadeWithDuration:0.5f]];

    //[[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"Level1"] withTransition:[CCTransition transitionFadeWithDuration:0.5f]];


    
    //[[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"Level1"] withTransition:[CCTransition transitionCrossFadeWithDuration:0.05]];
    
    CCScene *level1 = [CCBReader loadAsScene:@"BandLevel1"];
    
    [[CCDirector sharedDirector] replaceScene:level1 withTransition:[CCTransition transitionFadeWithDuration:1]];
    
    //[[CCDirector sharedDirector] replaceScene:level1 withTransition:[CCTransition transitionMoveInWithDirection:CCTransitionDirectionRight duration:0.5]];
    
    
    //return [CCBReader loadAsScene:@"MainScene"];

}


@end
