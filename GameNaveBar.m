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
    self=[super initWithColor:[[CCColor alloc] initWithCcColor4b:ccc4(0, 0, 0, 0)]];
    
    delegateScene = delegate;
    
    //CCMenuItemImage *goMenuButton = [CCMenuItemImage itemFromNormalImage:@"Button menu ON.png"
    //                                                       selectedImage: @"Button menu OFF.png"
    //                                                              target:self
    //                                                            selector:@selector(doBackMenu:)];
    
    
    CCButton *goMenuButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSprite spriteWithImageNamed:@"Button menu ON.png"] highlightedSpriteFrame:[CCSprite spriteWithImageNamed:@"Button menu OFF.png"] disabledSpriteFrame:nil];
    
    [goMenuButton setTarget:self selector:@selector(doBackMenu:)];
    [goMenuButton setScale:scaleFactor];
    
    CCButton *restartButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSprite spriteWithImageNamed:@"Button back ON.png"] highlightedSpriteFrame:[CCSprite spriteWithImageNamed:@"Button back OFF.png"] disabledSpriteFrame:nil];
    
    
    [restartButton setTarget:self selector:@selector(doRestart:)];
    [restartButton setScale:scaleFactor];
    
    //CCMenuItemImage *restartButton = [CCMenuItemImage itemFromNormalImage:@"Button back ON.png"
    //                                                        selectedImage: @"Button back OFF.png"
    //                                                               target:self
    //                                                             selector:@selector(doRestart:)];
    

    CCButton *storeButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSprite spriteWithImageNamed:@"Button store ON.png"] highlightedSpriteFrame:[CCSprite spriteWithImageNamed:@"Button store OFF.png"] disabledSpriteFrame:nil];

    [storeButton setTarget:self selector:@selector(doStore:)];
    [storeButton setScale:scaleFactor];
    
    //CCMenuItemImage *storeButton = [CCMenuItemImage itemFromNormalImage:@"Button store ON.png"
    //                                                        selectedImage: @"Button store OFF.png"
    //                                                               target:self
    //                                                             selector:@selector(doStore:)];
    
    CCButton *nextButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSprite spriteWithImageNamed:@"Button next ON.png"] highlightedSpriteFrame:[CCSprite spriteWithImageNamed:@"Button next OFF.png"] disabledSpriteFrame:nil];

    
    
    //CCMenuItemImage *nextButton = [CCMenuItemImage itemFromNormalImage:@"Button next ON.png"
    //                                                      selectedImage: @"Button next OFF.png"
    //                                                             target:self
    //                                                           selector:@selector(doNext:)];
    
    [nextButton setTarget:self selector:@selector(doNext:)];
    [nextButton setScale:scaleFactor];
    
    
    //CCMenu *navMenu = [CCMenu menuWithItems:goMenuButton, restartButton, storeButton, nextButton, nil];
    CCNode *navMenu = [[CCNode alloc] init];
    [navMenu addChild:goMenuButton];
    [navMenu addChild:restartButton];
    [navMenu addChild:storeButton];
    [navMenu addChild:nextButton];
    
    
    [navMenu setPosition:ccp(160, 80)];
    
    //[navMenu alignItemsHorizontally];
    
    belt = [[CCSprite alloc] initWithImageNamed:@"belt.png"];
    
    [belt setScale:0.5];
    [belt setPosition:ccp(150, 80)];
    
    [self addChild:belt];
    
    [self addChild:navMenu];
    
    
    return self;
}

-(void)doBackMenu:(CCButton *)menuItem
{
    NSLog(@"doBackMenu");
    [delegateScene doBackMenu];
}

-(void)doRestart:(CCButton *)menuItem
{
    NSLog(@"doRestart");
    [delegateScene doRestart];
}

-(void)doStore:(CCButton *)menuItem
{
    NSLog(@"doStore");
    [delegateScene doStore];
}

-(void)doNext:(CCButton *)menuItem
{
    NSLog(@"doNext");
    [delegateScene doNext];
}

@end
