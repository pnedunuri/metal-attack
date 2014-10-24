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
        
        CCMenuItemImage * menuItem1 = [CCMenuItemImage itemFromNormalImage:@"back.png"
                                                             selectedImage: @"back.png"
                                                                    target:self
                                                                  selector:@selector(doBack:)];
        
        CCMenu * myMenu = [CCMenu menuWithItems:menuItem1, nil];
        
        CGPoint menuposition;
        menuposition.x = 40;
        menuposition.y = 40;
        
        myMenu.position = menuposition;
        
        CCMenuItemImage * menuItem2 = [CCMenuItemImage itemFromNormalImage:@"reload.png"
                                                             selectedImage: @"reloadClicked.png"
                                                                    target:self
                                                                  selector:@selector(doRestartLevel:)];
        
        CCMenu * myMenu2 = [CCMenu menuWithItems:menuItem2, nil];
        
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

-(void)doBack:(CCMenuItem *)menuItem 
{
    NSLog(@"Do Back");
    [[CCDirector sharedDirector] replaceScene: [MainMenu scene]];
}

-(void)doRestartLevel:(CCMenuItem *)menuItem
{
    NSLog(@"Do Restart Level");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f 
                                        scene:[BandGamePlay sceneWithLevel:levelNumber wave:0]]];
}

@end
