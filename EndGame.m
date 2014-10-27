//
//  EndGame.m
//  EightbitShooter
//
//  Created by Rafael Munhoz on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EndGame.h"

@implementation EndGame

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	EndGame *layer = [EndGame node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        //CCLabel *label = [CCLabel labelWithString:[@"Devloped by munhra" fontName:@"Marker Felt" fontSize:24];
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Game End Thank you for playing" fontName:@"Marker Felt" fontSize:22];
        
        CGPoint labelposition;
        labelposition.x = 160;
        labelposition.y = 240;
        
        
        label.position = labelposition;
        
        //CCMenuItemImage * menuItem1 = [CCMenuItemImage itemFromNormalImage:@"back.png"
        //                                                     selectedImage: @"back.png"
        //                                                            target:self
        //                                                          selector:@selector(doBack:)];
        
        CCButton *menuItem1 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSprite spriteWithImageNamed:@"back.png"] highlightedSpriteFrame:        [CCSprite spriteWithImageNamed:@"back.png"] disabledSpriteFrame:nil];
        
        [menuItem1 setTarget:self selector:@selector(doBack:)];
        
        CCNode * myMenu = [[CCNode alloc] init];
        [myMenu addChild:menuItem1];
        
        CGPoint menuposition;
        menuposition.x = 40;
        menuposition.y = 40;
        
        myMenu.position = menuposition;
        
        [self addChild:myMenu];
        [self addChild:label];
        
        
    }
	return self;
}

-(void)doBack:(CCButton *)menuItem
{
	NSLog(@"Do Back");
    [[CCDirector sharedDirector] replaceScene: [MainMenu scene]];
}

@end
