//
//  GameNaveBar.m
//  EightbitShooter
//
//  Created by Rafael Munhoz on 24/09/14.
//
//

#import "GameNaveBar.h"

@implementation GameNaveBar

float scaleFactor = 0.5;

id delegateScene;

CCSprite *belt;

-(id)initWithDelegagte:(id)delegate;
{
    [super initWithColor:ccc4(0, 0, 0, 0)];
    
    delegateScene = delegate;
    
    CCMenuItemImage *goMenuButton = [CCMenuItemImage itemFromNormalImage:@"Button menu ON.png"
                                                           selectedImage: @"Button menu OFF.png"
                                                                  target:self
                                                                selector:@selector(doBackMenu:)];
    
    [goMenuButton setScale:scaleFactor];
    
    CCMenuItemImage *restartButton = [CCMenuItemImage itemFromNormalImage:@"Button back ON.png"
                                                            selectedImage: @"Button back OFF.png"
                                                                   target:self
                                                                 selector:@selector(doRestart:)];
    
    [restartButton setScale:scaleFactor];
    
    CCMenuItemImage *storeButton = [CCMenuItemImage itemFromNormalImage:@"Button store ON.png"
                                                            selectedImage: @"Button store OFF.png"
                                                                   target:self
                                                                 selector:@selector(doStore:)];
    [storeButton setScale:scaleFactor];
    
    CCMenuItemImage *nextButton = [CCMenuItemImage itemFromNormalImage:@"Button next ON.png"
                                                          selectedImage: @"Button next OFF.png"
                                                                 target:self
                                                               selector:@selector(doNext:)];
    [nextButton setScale:scaleFactor];
    
    
    CCMenu *navMenu = [CCMenu menuWithItems:goMenuButton, restartButton, storeButton, nextButton, nil];

    
    [navMenu setPosition:ccp(160, 80)];
    
    [navMenu alignItemsHorizontally];
    
    belt = [[CCSprite alloc] initWithFile:@"belt.png"];
    
    [belt setScale:0.5];
    [belt setPosition:ccp(150, 80)];
    
    [self addChild:belt];
    
    [self addChild:navMenu];
    
    
    return self;
}

-(void)doBackMenu:(CCMenuItem *)menuItem
{
    NSLog(@"doBackMenu");
    [delegateScene doBackMenu];
}

-(void)doRestart:(CCMenuItem *)menuItem
{
    NSLog(@"doRestart");
    [delegateScene doRestart];
}

-(void)doStore:(CCMenuItem *)menuItem
{
    NSLog(@"doStore");
    [delegateScene doStore];
}

-(void)doNext:(CCMenuItem *)menuItem
{
    NSLog(@"doNext");
    [delegateScene doNext];
}

@end
