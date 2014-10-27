//
//  GameOver.m
//  EightbitShooter
//
//  Created by Rafael Munhoz on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameOver.h"

@implementation GameOver

int levelNumber;

+(CCScene *)sceneWithNextLevel:(int)number;
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameOver *layer = [GameOver node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
    //level
    levelNumber = number;
	
	// return the scene
	return scene;
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        //CCLabel *label = [CCLabel labelWithString:[@"Devloped by munhra" fontName:@"Marker Felt" fontSize:24];
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Game Over" fontName:@"Marker Felt" fontSize:24];
        
        CGPoint labelposition;
        labelposition.x = 160;
        labelposition.y = 240;
        
        
        label.position = labelposition;
        
        //CCMenuItemImage * menuItem1 = [CCMenuItemImage itemFromNormalImage:@"back.png"
        //                                                     selectedImage: @"back.png"
        //                                                            target:self
        //                                                          selector:@selector(doBack:)];
        
        CCButton *menuItem1 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSprite spriteWithImageNamed:@"back.png"] highlightedSpriteFrame:[CCSprite spriteWithImageNamed:@"back.png"] disabledSpriteFrame:nil];
        
        [menuItem1 setTarget:self selector:@selector(doBack:)];
        
        CCNode *myMenu = [[CCNode alloc] init];
        [myMenu addChild:menuItem1];
        
        CGPoint menuposition;
        menuposition.x = 40;
        menuposition.y = 40;
        
        myMenu.position = menuposition;
        
        //CCMenuItemImage * menuItem2 = [CCMenuItemImage itemFromNormalImage:@"reload.png"
        //                                                     selectedImage: @"reloadClicked.png"
        //                                                            target:self
        //                                                          selector:@selector(doRestartLevel:)];
        
        CCButton *menuItem2 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSprite spriteWithImageNamed:@"reload.png"] highlightedSpriteFrame:[CCSprite spriteWithImageNamed:@"reload.png"] disabledSpriteFrame:nil];
        
        [menuItem2 setTarget:self selector:@selector(doRestartLevel:)];
        
        CCNode *myMenu2 = [[CCNode alloc] init];
        [myMenu2 addChild:menuItem2];
        
        CGPoint menuposition2;
        menuposition2.x = 280;
        menuposition2.y = 40;
        
        myMenu2.position = menuposition2;
    
        [self addChild:myMenu];
        [self addChild:myMenu2];
        [self addChild:label];
    }
	return self;
}

-(void)doBack:(CCButton *)menuItem
{
    NSLog(@"Do Back");
    [[CCDirector sharedDirector] replaceScene: [MainMenu scene]];
}

-(void)doRestartLevel:(CCButton *)menuItem
{
    NSLog(@"Do Restart Level");
    //[[CCDirector sharedDirector] replaceScene:[CCTransition transitionFadeWithDuration:0.5f
    //                                    scene:[BandGamePlay sceneWithLevel:levelNumber wave:0]]];
    
    [[CCDirector sharedDirector] replaceScene:[BandGamePlay sceneWithLevel:levelNumber wave:0] withTransition:[CCTransition transitionFadeWithDuration:0.5f]];
}

@end
