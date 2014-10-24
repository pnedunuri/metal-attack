//
//  Credits.m
//  HelloWorldCocos
//
//  Created by Rafael Munhoz on 23/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Credits.h"

@implementation Credits

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Credits *layer = [Credits node];
	
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
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Devloped by munhra" fontName:@"Marker Felt" fontSize:24];
        
        CGPoint labelposition;
        labelposition.x = 160;
        labelposition.y = 240;
        
        
        label.position = labelposition;
        
        CCMenuItemImage * menuItem1 = [CCMenuItemImage itemFromNormalImage:@"handbutton01.png"
                                                             selectedImage: @"handbutton01.png"
                                                                    target:self
                                                                  selector:@selector(doBack:)];
        
        CCMenu * myMenu = [CCMenu menuWithItems:menuItem1, nil];
        
        CGPoint menuposition;
        menuposition.x = 40;
        menuposition.y = 40;

        myMenu.position = menuposition;
        
        [self addChild:myMenu];
        [self addChild:label];
        
        
    }
	return self;
}

- (void) doBack: (CCMenuItem  *) menuItem 
{
	NSLog(@"Do Back");
    //[[CCDirector sharedDirector] replaceScene: [MainMenu scene]];
    [self closeDoor];
}

-(void)doEndMoveDownDoor:(id)node
{
    //[[CCDirector sharedDirector] replaceScene: [MainMenu scene]];
    //[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.8f scene:[MainMenu scene]]];
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionTurnOffTiles transitionWithDuration:1.5 scene:[MainMenu scene]]];
    
    //[[CCDirector sharedDirector] replaceScene:[CCTransitionShrinkGrow transitionWithDuration:0.8 scene:[MainMenu scene]]];
    
    //[[CCDirector sharedDirector] replaceScene:[CCTransitionScene transitionWithDuration:0.8 scene:[MainMenu scene]]];
    
    //[[CCDirector sharedDirector] replaceScene:[CCTransitionJumpZoom transitionWithDuration:0.8 scene:[MainMenu scene]]];
    
    //[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL transitionWithDuration:0.8 scene:[MainMenu scene]]];
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSplitCols transitionWithDuration:0.8 scene:[MainMenu scene]]];
    
    
    
}

@end
