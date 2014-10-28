//
//  ███╗   ███╗███████╗████████╗ █████╗ ██╗          █████╗ ████████╗████████╗ █████╗  ██████╗██╗  ██╗
//  ████╗ ████║██╔════╝╚══██╔══╝██╔══██╗██║         ██╔══██╗╚══██╔══╝╚══██╔══╝██╔══██╗██╔════╝██║ ██╔╝
//  ██╔████╔██║█████╗     ██║   ███████║██║         ███████║   ██║      ██║   ███████║██║     █████╔╝
//  ██║╚██╔╝██║██╔══╝     ██║   ██╔══██║██║         ██╔══██║   ██║      ██║   ██╔══██║██║     ██╔═██╗
//  ██║ ╚═╝ ██║███████╗   ██║   ██║  ██║███████╗    ██║  ██║   ██║      ██║   ██║  ██║╚██████╗██║  ██╗
//  ╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝    ╚═╝  ╚═╝   ╚═╝      ╚═╝   ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
//
//
//  MainMenu.m
//  HelloWorldCocos
//
//  Created by Rafael Munhoz on 23/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainMenu.h"
#import "UniversalInfo.h"
#import "BandStore.h"
//#import "CCParallaxNode-Extras.h"
#import "CCAnimation.h"

@implementation MainMenu

@synthesize chestAnim;
@synthesize girlEyeAnim;
@synthesize guyEyeAnim;
@synthesize playAnim;
@synthesize tuningAnim;
@synthesize flamesAnim;
@synthesize batAnim;

int levelNumber;
int bgOrientation = 1;
CCSprite *menu1BG;
CGSize winsize;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainMenu *layer = [MainMenu node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void)loadBandVault
{
    NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
    BandVault *vault = [BandVault sharedInstance];
    vault.bandCoins = [userdef integerForKey:@"coins"];
    if (vault.bandCoins == 0) {
        vault.bandCoins = 10000;
    }
    vault.highScore = [userdef integerForKey:@"highScore"];
}

-(void)defineMenuAnimations
{
    
    NSMutableArray *chestFrames = [NSMutableArray array];
    NSMutableArray *girlEyesFrames = [NSMutableArray array];
    NSMutableArray *guyEyesFrames = [NSMutableArray array];
    NSMutableArray *playFrames = [NSMutableArray array];
    NSMutableArray *tunningFrames = [NSMutableArray array];
    NSMutableArray *flamesFrames = [NSMutableArray array];
    NSMutableArray *batFrames = [NSMutableArray array];
    
    
    
    //chest animation
    for(int i = 1; i <= 2; i++) {
        CCSpriteFrame *chestframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"menu_chest%d.png",i]];
        [chestFrames addObject:chestframe];
    }
    
    CCAnimation *chestanimation = [CCAnimation animationWithSpriteFrames:chestFrames delay:0.5f];
    self.chestAnim = [CCActionRepeatForever actionWithAction:
                         [CCActionAnimate actionWithAnimation:chestanimation]];
    
    
    //girl eyes animation
    for(int i = 1; i <= 3; i++) {
        CCSpriteFrame *girleyeframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"menu_girleye%d.png",i]];
        [girlEyesFrames addObject:girleyeframe];
    }
    
    CCAnimation *girleyeanimation = [CCAnimation animationWithSpriteFrames:girlEyesFrames delay:0.15f];
    self.girlEyeAnim = [CCActionRepeatForever actionWithAction:
                       [CCActionAnimate actionWithAnimation:girleyeanimation]];
    
    //guy eyes animation
    for(int i = 1; i <= 2; i++) {
        CCSpriteFrame *guyeyeframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"menu_guy_eye%d.png",i]];
        [guyEyesFrames addObject:guyeyeframe];
    }
    
    CCAnimation *guyeyeanimation = [CCAnimation animationWithSpriteFrames:guyEyesFrames delay:0.15f];
    self.guyEyeAnim = [CCActionRepeatForever actionWithAction:
                         [CCActionAnimate actionWithAnimation:guyeyeanimation]];
    
    //play animation
    for(int i = 1; i <= 3; i++) {
        CCSpriteFrame *playframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"menu_guy_play%d.png",i]];
        [playFrames addObject:playframe];
    }
    
    CCAnimation *playanimation = [CCAnimation animationWithSpriteFrames:playFrames delay:0.25f];
    self.playAnim = [CCActionRepeatForever actionWithAction:
                        [CCActionAnimate actionWithAnimation:playanimation]];
    
    //tunning animation
    for(int i = 1; i <= 3; i++) {
        CCSpriteFrame *tunningframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"menu_guita_tune%d.png",i]];
        [tunningFrames addObject:tunningframe];
    }
    
    CCAnimation *tunninganimation = [CCAnimation animationWithSpriteFrames:tunningFrames delay:0.30f];
    self.tuningAnim = [CCActionRepeatForever actionWithAction:
                      [CCActionAnimate actionWithAnimation:tunninganimation]];
    
    //Candle Fire
    for(int i = 1; i <= 3; i++) {
        CCSpriteFrame *flamesframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"menu_fire%d.png",i]];
        [flamesFrames addObject:flamesframe];
    }
    
    CCAnimation *flameanimation = [CCAnimation animationWithSpriteFrames:flamesFrames delay:0.10f];
    self.flamesAnim = [CCActionRepeatForever actionWithAction:
                        [CCActionAnimate actionWithAnimation:flameanimation]];
    
    //Bat Anim
    for(int i = 1; i <= 3; i++) {
        CCSpriteFrame *batframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"menu_bat%d.png",i]];
        [batFrames addObject:batframe];
    }
    
    CCAnimation *batanimation = [CCAnimation animationWithSpriteFrames:batFrames delay:0.15f];
    self.batAnim = [CCActionRepeatForever actionWithAction:
                        [CCActionAnimate actionWithAnimation:batanimation]];
    
    
    
    
}

/*
-(void)movingBackGround
{
    
    _batchNode = [CCSpriteBatchNode batchNodeWithFile:@"Sprites.pvr.ccz"]; // 1
    [self addChild:_batchNode]; // 2
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Sprites.plist"]; // 3
    
    // 1) Create the CCParallaxNode
    _backgroundNode = [CCParallaxNode node];
    [self addChild:_backgroundNode z:0];
    
    DeviceType devtype = [[UniversalInfo sharedInstance] getDeviceType];
    if (devtype == IPHONE_5){
        _spacedust1 = [CCSprite spriteWithImageNamed:@"doodlefinal_iphone5.jpg"];
        _spacedust2 = [CCSprite spriteWithImageNamed:@"doodlefinal_iphone5.jpg"];
        _spacedust3 = [CCSprite spriteWithImageNamed:@"doodlefinal_iphone5.jpg"];
        _spacedust4 = [CCSprite spriteWithImageNamed:@"doodlefinal_iphone5.jpg"];
    }else{
        _spacedust1 = [CCSprite spriteWithImageNamed:@"doodlefinal.jpg"];
        _spacedust2 = [CCSprite spriteWithImageNamed:@"doodlefinal.jpg"];
        _spacedust3 = [CCSprite spriteWithImageNamed:@"doodlefinal.jpg"];
        _spacedust4 = [CCSprite spriteWithImageNamed:@"doodlefinal.jpg"];
    }
    
    // there is a fault on the iphone 5 background movement.
    
    // 3) Determine relative movement speeds for space dust and background
    
    CGPoint dustSpeed = ccp(1, 1);
    
    // 4) Add children to CCParallaxNode
    
    [_backgroundNode addChild:_spacedust1 z:0 parallaxRatio:dustSpeed positionOffset:ccp(0,_spacedust1.contentSize.height/2)];
    [_backgroundNode addChild:_spacedust2 z:0 parallaxRatio:dustSpeed positionOffset:ccp(_spacedust1.contentSize.width,_spacedust1.contentSize.height/2)];
    
    [_backgroundNode addChild:_spacedust3 z:0 parallaxRatio:dustSpeed positionOffset:ccp(0,_spacedust1.contentSize.height*1.5)];
    [_backgroundNode addChild:_spacedust4 z:0 parallaxRatio:dustSpeed positionOffset:ccp(_spacedust1.contentSize.width,_spacedust1.contentSize.height*1.5)];
    
}
*/

-(id)init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        winsize = [[CCDirector sharedDirector] viewSize];
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
        
        [self defineMenuAnimations];
        
        DeviceType devtype = [[UniversalInfo sharedInstance] getDeviceType];
        
        if (devtype == IPHONE_5){
            menu1BG = [[CCSprite alloc] initWithImageNamed:@"menuIphone5.png"];
        }else{
            menu1BG = [[CCSprite alloc] initWithImageNamed:@"newmenubg.png"];
        }
        
        CCSprite *menugirl = [[CCSprite alloc] initWithImageNamed:@"menu_girl.png"];
        
        CCSprite *menuchest = [[CCSprite alloc] initWithImageNamed:@"menu_chest1.png"];
        CCSprite *girlEyes = [[CCSprite alloc] initWithImageNamed:@"menu_girleye1.png"];
        CCSprite *guyEyes = [[CCSprite alloc] initWithImageNamed:@"menu_guy_eye1.png"];
        CCSprite *menuGuyTunning = [[CCSprite alloc] initWithImageNamed:@"menu_guita_tune1.png"];
        CCSprite *menuGuyPlay = [[CCSprite alloc] initWithImageNamed:@"menu_guy_play1.png"];
        
        CCSprite *menuSkull = [[CCSprite alloc] initWithImageNamed:@"menu_skull_head.png"];
        CCSprite *menuChain = [[CCSprite alloc] initWithImageNamed:@"menu_chain.png"];
        
        CCSprite *menuFlames = [[CCSprite alloc] initWithImageNamed:@"menu_fire1.png"];
        
        CCSprite *menuFacebook = [[CCSprite alloc] initWithImageNamed:@"menu_facebook.png"];
        CCSprite *menuVolume = [[CCSprite alloc] initWithImageNamed:@"menu_vol_buton.png"];
        CCSprite *menuLogo = [[CCSprite alloc] initWithImageNamed:@"menu_logo.png"];
        
        CCSprite *menuBat = [[CCSprite alloc] initWithImageNamed:@"menu_bat1.png"];
        

        [girlEyes runAction:[self girlEyeAnim]];
        [menuchest runAction:[self chestAnim]];
        [guyEyes runAction:[self guyEyeAnim]];
        [menuGuyTunning runAction:[self tuningAnim]];
        [menuGuyPlay runAction:[self playAnim]];
        [menuFlames runAction:[self flamesAnim]];
        [menuBat runAction:[self batAnim]];
        
        
        [menu1BG setPosition:ccp([[UniversalInfo sharedInstance] screenCenter].x + winsize.width/2,
                                 [[UniversalInfo sharedInstance] screenCenter].y)];
        
        
        //CCMenuItemImage *menuItem1 = [CCMenuItemImage itemFromNormalImage:@"newgame.png"
        //                                                     selectedImage: @"newgame.png"
        //                                                            target:self
        //                                                          selector:@selector(doNewGame:)];
        
        
        CCButton *menuItem1 = [CCButton buttonWithTitle:@"" spriteFrame:[[CCSprite spriteWithImageNamed:@"newgame.png"] spriteFrame] highlightedSpriteFrame:[[CCSprite spriteWithImageNamed:@"newgame.png"] spriteFrame] disabledSpriteFrame:nil];
        
        [menuItem1 setTarget:self selector:@selector(doNewGame:)];
        
        //CCMenuItemImage *menuItem2 = [CCMenuItemImage itemFromNormalImage:@"credits.png"
        //                                                     selectedImage: @"credits2.png"
        //                                                            target:self
        //                                                          selector:@selector(doCredits:)];
        
        CCButton *menuItem2 = [CCButton buttonWithTitle:@"" spriteFrame:[[CCSprite spriteWithImageNamed:@"credits.png"] spriteFrame]highlightedSpriteFrame:[[CCSprite spriteWithImageNamed:@"credits2.png"] spriteFrame] disabledSpriteFrame:nil];
        
        [menuItem2 setTarget:self selector:@selector(doCredits:)];
        
        // changed to credits due to testing purposes
        //CCMenuItemImage *menuItem3 = [CCMenuItemImage itemFromNormalImage:@"continue.png"
        //                                                     selectedImage: @"continue.png"
        //                                                            target:self
        //                                                          selector:@selector(doCredits:)];
        
        CCButton *menuItem3 = [CCButton buttonWithTitle:@"" spriteFrame:[[CCSprite spriteWithImageNamed:@"continue.png"] spriteFrame]highlightedSpriteFrame:[[CCSprite spriteWithImageNamed:@"continue.png"] spriteFrame] disabledSpriteFrame:nil];
        
        [menuItem3 setTarget:self selector:@selector(doCredits:)];

        //CCMenuItemImage *storeMenuItem = [CCMenuItemImage itemFromNormalImage:@"menu_chest1.png"
        //                                                    selectedImage: @"menu_chest2.png"
        //                                                           target:self
        //                                                         selector:@selector(doStore:)];
        
        CCButton *storeMenuItem = [CCButton buttonWithTitle:@"" spriteFrame:[[CCSprite spriteWithImageNamed:@"menu_chest1.png"] spriteFrame]highlightedSpriteFrame:[[CCSprite spriteWithImageNamed:@"menu_chest2.png"]spriteFrame] disabledSpriteFrame:nil];
        
        [storeMenuItem setTarget:self selector:@selector(doStore)];
        
        
        menuItem1.scaleX = 0.5;
        menuItem1.scaleY = 0.5;
        
        menuItem3.scaleX = 0.5;
        menuItem3.scaleY = 0.5;
        
        
        
        NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
        levelNumber = [userdef integerForKey:@"Level"];
        
        //CCMenu * myMenu;
        
        CCNode *myMenu = [[CCNode alloc] init];
        
        if (!levelNumber == 0){
            [myMenu addChild:menuItem3];
            [myMenu addChild:menuItem1];
            //myMenu = [CCMenu menuWithItems:menuItem3, menuItem1, nil];
        }else{
            // just for testing purposes menuItem3 is from credits remove it from new game.
            [myMenu addChild:menuItem1];
            [myMenu addChild:menuItem3];
            //myMenu = [CCMenu menuWithItems:menuItem3, menuItem1, nil];
        }
        // Create a menu and add your menu items to it
        
        // Create the handmenu items
        
        [myMenu setPosition:ccp(0,0)];
        
        //CCMenuItemImage *handMenu1 = [CCMenuItemImage itemFromNormalImage:@"handbutton01.png"
        //                                                    selectedImage: @"handbutton01.png"
        //                                                           target:self
        //                                                         selector:@selector(doLeftSlide:)];
        
        CCButton *handMenu1 = [CCButton buttonWithTitle:@"" spriteFrame:[[CCSprite spriteWithImageNamed:@"handbutton01.png"] spriteFrame ]highlightedSpriteFrame:[[CCSprite spriteWithImageNamed:@"handbutton01.png"] spriteFrame] disabledSpriteFrame:nil];
        
        
        [handMenu1 setTarget:self selector:@selector(doLeftSlide:)];
        
        //CCMenuItemImage *handMenu2 = [CCMenuItemImage itemFromNormalImage:@"handbutton02.png"
        //                                                    selectedImage: @"handbutton02.png"
        //                                                           target:self
        //                                                         selector:@selector(doRightSlide:)];
        
        CCButton *handMenu2 = [CCButton buttonWithTitle:@"" spriteFrame:[[CCSprite spriteWithImageNamed:@"handbutton02.png"] spriteFrame] highlightedSpriteFrame:[[CCSprite spriteWithImageNamed:@"handbutton02.png"] spriteFrame]  disabledSpriteFrame:nil];
        
        [handMenu2 setTarget:self selector:@selector(doRightSlide:)];
        
        if ([[UniversalInfo sharedInstance] getDeviceType] == IPHONE_5)  {
            [guyEyes setPosition:ccp(55, 285)];
            [menuGuyTunning setPosition:ccp(175,270)];
            [menuGuyPlay setPosition:ccp(90,200)];
            [handMenu1 setPosition:ccp(430, -232)];
            [menugirl setPosition:ccp(600,180)];
            [menuFlames setPosition:ccp(609,450)];
            [girlEyes setPosition:ccp(585,335)];
            //[menuchest setPosition:ccp(480,225)];
            //[storeMenuItem setPosition:ccp(300, 200)];
            [menuLogo setScale:0.9];
            [menuLogo setPosition:ccp(165, 440)];
            [menuFacebook setPosition:ccp(600,170)];
            [menuItem1 setPosition:ccp(80,170)];
            [menuChain setPosition:ccp(400,520)];
            [menuSkull setPosition:ccp(420,410)];
            [menuVolume setPosition:ccp(455,78)];

        }else{
            [guyEyes setPosition:ccp(190,555)];
            [menuGuyTunning setPosition:ccp(427,527)];
            [menuGuyPlay setPosition:ccp(240,385)];
            [handMenu1 setPosition:ccp(1065,-421)];
            [menugirl setPosition:ccp(1450,450)];
            [menuFlames setPosition:ccp(1300,885)];
            [girlEyes setPosition:ccp(1420,765)];
            [menuchest setPosition:ccp(1220,525)];
            [menuLogo setPosition:ccp(400, 850)];
            [menuFacebook setPosition:ccp(1470,420)];
            [menuItem1 setPosition:ccp(200,380)];
            [menuChain setPosition:ccp(900,950)];
            [menuSkull setPosition:ccp(940,730)];
            [menuVolume setPosition:ccp(1000,145)];

        }
        
        [handMenu2 setPosition:ccp(winsize.width * 0.328, - winsize.height * 0.409)];
        [menuItem3 setPosition:ccp(300,100)]; // ajust to iphone
        [menuBat setPosition:ccp(200, 200)];
        //CCMenu *handMenu;
        //CCMenu *storeMenu;
       
        CCNode *handMenu;
        CCNode *storeMenu;
        
        [storeMenuItem setPosition:ccp(330,-80)];
        
        handMenu = [[CCNode alloc] init];
        storeMenu = [[CCNode alloc] init];;
        
        [handMenu addChild:handMenu1];
        [handMenu addChild:handMenu2];
        [storeMenu addChild:storeMenuItem];
        
        //handMenu = [CCMenu menuWithItems:handMenu1, handMenu2, nil];
        //storeMenu = [CCMenu menuWithItems:storeMenuItem, nil];
        
        
        // Arrange the menu items vertically
        //[myMenu alignItemsVertically];
        
        [self loadBandVault];
        //[self scheduleUpdate];
        
        //[self schedule:@selector(update:) interval:0];
        
        // add the menu to your scene
        [self addChild:menu1BG z:1];
        //[menu1BG addChild:myMenu];
        [self addChild:myMenu];
        //[menu1BG addChild:menuchest];
        [menu1BG addChild:storeMenu];
        [menu1BG addChild:menugirl];
        [menu1BG addChild:handMenu];

        [menu1BG addChild:girlEyes];
        [menu1BG addChild:menuSkull];
        [menu1BG addChild:menuChain];
        [menu1BG addChild:menuFlames];
        [menu1BG addChild:menuFacebook];
        [menu1BG addChild:menuLogo];
        [menu1BG addChild:menuVolume];
        
        [menu1BG addChild:menuGuyPlay];
        [menu1BG addChild:menuGuyTunning];
        [menu1BG addChild:guyEyes];
        
        [menu1BG addChild:menuBat];
        



        //[self movingBackGround];
        
        
        
    }
	return self;
}

- (void)update:(double)dt
{
    /*
    CGPoint backgroundScrollVel = ccp(0, 250);
    
    _backgroundNode.position = ccpAdd(_backgroundNode.position, ccpMult(backgroundScrollVel, dt));
    
    NSArray *spaceDusts = [NSArray arrayWithObjects:_spacedust1, _spacedust2, _spacedust3, _spacedust4, nil];
    for (CCSprite *spaceDust in spaceDusts) {
        
        if ([_backgroundNode convertToWorldSpace:spaceDust.position].x > spaceDust.contentSize.width*1.5) {
            [_backgroundNode incrementOffset:ccp(-2*spaceDust.contentSize.width,0) forChild:spaceDust];
        }
        
        if ([_backgroundNode convertToWorldSpace:spaceDust.position].x < -spaceDust.contentSize.width/2) {
            [_backgroundNode incrementOffset:ccp(2*spaceDust.contentSize.width,0) forChild:spaceDust];
        }
        
        
        if ([_backgroundNode convertToWorldSpace:spaceDust.position].y < -spaceDust.contentSize.height/2) {
            [_backgroundNode incrementOffset:ccp(0,2*spaceDust.contentSize.height) forChild:spaceDust];
        }
        
        if ([_backgroundNode convertToWorldSpace:spaceDust.position].y > spaceDust.contentSize.height*1.5) {
            [_backgroundNode incrementOffset:ccp(0,-2*spaceDust.contentSize.height) forChild:spaceDust];
        }
     
    }
     */
    
}

-(void)doLeftSlide:(CCButton *)menuItem
{
    NSLog(@"Do Left Slide");
    id actionMove = [CCActionMoveTo actionWithDuration:2.5 position:ccp([[UniversalInfo sharedInstance] screenCenter].x + winsize.width/2,
                                                                [[UniversalInfo sharedInstance] screenCenter].y)];
    //id actionElastic = [CCEaseElasticInOut actionWithAction:actionMove period:0.5];
    id actionElastic = [CCActionEaseElasticOut actionWithAction:actionMove];
    //[CCEaseExponentialIn]
    bgOrientation = -1;
    [menu1BG runAction:actionElastic];

}

-(void)doRightSlide:(CCButton *)menuItem
{
    NSLog(@"Do Right Slide");
    id actionMove = [CCActionMoveTo actionWithDuration:2.5 position:ccp([[UniversalInfo sharedInstance] screenCenter].x - winsize.width/2,
                                                                [[UniversalInfo sharedInstance] screenCenter].y)];
    
    id actionElastic = [CCActionEaseElasticOut actionWithAction:actionMove];
    bgOrientation = 1;
    [menu1BG runAction:actionElastic];
}

-(void)doNewGame:(CCButton *)menuItem
{
	NSLog(@"The first menu was called");
    //[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:[BandGamePlay sceneWithLevel:0 wave:0]]];
    
    
    [[CCDirector sharedDirector] replaceScene:[BandGamePlay sceneWithLevel:0 wave:0] withTransition:[CCTransition transitionFadeWithDuration:0.5f]];
}

-(void)doCredits:(CCButton *)menuItem
{
	NSLog(@"The second menu was called");
    //[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:[Credits scene]]];

    [[CCDirector sharedDirector] replaceScene:[Credits scene] withTransition:[CCTransition transitionFadeWithDuration:0.5f]];
}

-(void)doContinue:(CCButton *)menuItem
{
    NSLog(@"Continue game");
    //[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:[BandGamePlay sceneWithLevel:levelNumber wave:0]]];

    [[CCDirector sharedDirector] replaceScene:[BandGamePlay sceneWithLevel:levelNumber wave:0] withTransition:[CCTransition transitionFadeWithDuration:0.5f]];
}

-(void)doStore:(CCButton *)menuItem
{
    NSLog(@"Store game");
    //[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:[BandStore scene]]];

    [[CCDirector sharedDirector] replaceScene:[BandStore scene] withTransition:[CCTransition transitionFadeWithDuration:0.5f]];

}


@end
