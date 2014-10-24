//
//  ███╗   ███╗███████╗████████╗ █████╗ ██╗          █████╗ ████████╗████████╗ █████╗  ██████╗██╗  ██╗
//  ████╗ ████║██╔════╝╚══██╔══╝██╔══██╗██║         ██╔══██╗╚══██╔══╝╚══██╔══╝██╔══██╗██╔════╝██║ ██╔╝
//  ██╔████╔██║█████╗     ██║   ███████║██║         ███████║   ██║      ██║   ███████║██║     █████╔╝
//  ██║╚██╔╝██║██╔══╝     ██║   ██╔══██║██║         ██╔══██║   ██║      ██║   ██╔══██║██║     ██╔═██╗
//  ██║ ╚═╝ ██║███████╗   ██║   ██║  ██║███████╗    ██║  ██║   ██║      ██║   ██║  ██║╚██████╗██║  ██╗
//  ╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝    ╚═╝  ╚═╝   ╚═╝      ╚═╝   ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
//
//
//  GarageMenu.m
//  EightbitShooter
//
//  Created by Rafael Munhoz on 22/10/14.
//
//

#import "GarageMenu.h"
#import "UniversalInfo.h"
#import "BandStore.h"
#import "CCParallaxNode-Extras.h"

@implementation GarageMenu

@synthesize chestAnim;
@synthesize girlEyeAnim;
@synthesize guyEyeAnim;
@synthesize playAnim;
@synthesize tuningAnim;
@synthesize flamesAnim;
@synthesize batAnim;

int levelNumber;
int bgOrientationMenu = 1;
CCSprite *menu1BG;
CGSize winsize;

CCSprite *wallLeft;
CCSprite *wallRight;
CCSprite *normalGround;
CCSprite *hellGround;
CCSprite *hideCracker;

+(CCScene *) scene
{
    // 'scene' is an autorelease object.
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object.
    GarageMenu *layer = [GarageMenu node];
    
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
    
    CCAnimation *chestanimation = [[CCAnimation animationWithFrames:chestFrames delay:0.5f] retain];
    self.chestAnim = [[CCRepeatForever actionWithAction:
                       [CCAnimate actionWithAnimation:chestanimation restoreOriginalFrame:NO]] retain];
    
    
    //girl eyes animation
    for(int i = 1; i <= 3; i++) {
        CCSpriteFrame *girleyeframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"menu_girleye%d.png",i]];
        [girlEyesFrames addObject:girleyeframe];
    }
    
    CCAnimation *girleyeanimation = [[CCAnimation animationWithFrames:girlEyesFrames delay:0.15f] retain];
    self.girlEyeAnim = [[CCRepeatForever actionWithAction:
                         [CCAnimate actionWithAnimation:girleyeanimation restoreOriginalFrame:NO]] retain];
    
    //guy eyes animation
    for(int i = 1; i <= 2; i++) {
        CCSpriteFrame *guyeyeframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"menu_guy_eye%d.png",i]];
        [guyEyesFrames addObject:guyeyeframe];
    }
    
    CCAnimation *guyeyeanimation = [[CCAnimation animationWithFrames:guyEyesFrames delay:0.15f] retain];
    self.guyEyeAnim = [[CCRepeatForever actionWithAction:
                        [CCAnimate actionWithAnimation:guyeyeanimation restoreOriginalFrame:NO]] retain];
    
    //play animation
    for(int i = 1; i <= 3; i++) {
        CCSpriteFrame *playframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"menu_guy_play%d.png",i]];
        [playFrames addObject:playframe];
    }
    
    CCAnimation *playanimation = [[CCAnimation animationWithFrames:playFrames delay:0.25f] retain];
    self.playAnim = [[CCRepeatForever actionWithAction:
                      [CCAnimate actionWithAnimation:playanimation restoreOriginalFrame:NO]] retain];
    
    //tunning animation
    for(int i = 1; i <= 3; i++) {
        CCSpriteFrame *tunningframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"menu_guita_tune%d.png",i]];
        [tunningFrames addObject:tunningframe];
    }
    
    CCAnimation *tunninganimation = [[CCAnimation animationWithFrames:tunningFrames delay:0.30f] retain];
    self.tuningAnim = [[CCRepeatForever actionWithAction:
                        [CCAnimate actionWithAnimation:tunninganimation restoreOriginalFrame:NO]] retain];
    
    //Candle Fire
    for(int i = 1; i <= 3; i++) {
        CCSpriteFrame *flamesframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"menu_fire%d.png",i]];
        [flamesFrames addObject:flamesframe];
    }
    
    CCAnimation *flameanimation = [[CCAnimation animationWithFrames:flamesFrames delay:0.10f] retain];
    self.flamesAnim = [[CCRepeatForever actionWithAction:
                        [CCAnimate actionWithAnimation:flameanimation restoreOriginalFrame:NO]] retain];
    
    //Bat Anim
    for(int i = 1; i <= 3; i++) {
        CCSpriteFrame *batframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"menu_bat%d.png",i]];
        [batFrames addObject:batframe];
    }
    
    CCAnimation *batanimation = [[CCAnimation animationWithFrames:batFrames delay:0.15f] retain];
    self.batAnim = [[CCRepeatForever actionWithAction:
                     [CCAnimate actionWithAnimation:batanimation restoreOriginalFrame:NO]] retain];
    
    
    
    
}

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
        _spacedust1 = [CCSprite spriteWithFile:@"doodlefinal_iphone5.jpg"];
        _spacedust2 = [CCSprite spriteWithFile:@"doodlefinal_iphone5.jpg"];
        _spacedust3 = [CCSprite spriteWithFile:@"doodlefinal_iphone5.jpg"];
        _spacedust4 = [CCSprite spriteWithFile:@"doodlefinal_iphone5.jpg"];
    }else{
        _spacedust1 = [CCSprite spriteWithFile:@"doodlefinal.jpg"];
        _spacedust2 = [CCSprite spriteWithFile:@"doodlefinal.jpg"];
        _spacedust3 = [CCSprite spriteWithFile:@"doodlefinal.jpg"];
        _spacedust4 = [CCSprite spriteWithFile:@"doodlefinal.jpg"];
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


-(id)init
{
    // always call "super" init
    // Apple recommends to re-assign "self" with the "super" return value
    if( (self=[super init])) {
        
        winsize = [[CCDirector sharedDirector] winSize];
        LevelController *lvcontroller = [LevelController sharedInstance];
        
        [lvcontroller loadLevelJson];
        
        
        // Load sprite sheet once. maybe this part can be moved to the application
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
            menu1BG = [[CCSprite alloc] initWithFile:@"menuIphone5.png"];
        }else{
            menu1BG = [[CCSprite alloc] initWithFile:@"newmenubg.png"];
        }
        
        CCSprite *menugirl = [[CCSprite alloc] initWithFile:@"menu_girl.png"];
        
        CCSprite *menuchest = [[CCSprite alloc] initWithSpriteFrameName:@"menu_chest1.png"];
        CCSprite *girlEyes = [[CCSprite alloc] initWithSpriteFrameName:@"menu_girleye1.png"];
        CCSprite *guyEyes = [[CCSprite alloc] initWithSpriteFrameName:@"menu_guy_eye1.png"];
        CCSprite *menuGuyTunning = [[CCSprite alloc] initWithSpriteFrameName:@"menu_guita_tune1.png"];
        CCSprite *menuGuyPlay = [[CCSprite alloc] initWithSpriteFrameName:@"menu_guy_play1.png"];
        
        CCSprite *menuSkull = [[CCSprite alloc] initWithSpriteFrameName:@"menu_skull_head.png"];
        CCSprite *menuChain = [[CCSprite alloc] initWithSpriteFrameName:@"menu_chain.png"];
        
        CCSprite *menuFlames = [[CCSprite alloc] initWithSpriteFrameName:@"menu_fire1.png"];
        
        CCSprite *menuFacebook = [[CCSprite alloc] initWithSpriteFrameName:@"menu_facebook.png"];
        CCSprite *menuVolume = [[CCSprite alloc] initWithSpriteFrameName:@"menu_vol_buton.png"];
        CCSprite *menuLogo = [[CCSprite alloc] initWithSpriteFrameName:@"menu_logo.png"];
        
        CCSprite *menuBat = [[CCSprite alloc] initWithSpriteFrameName:@"menu_bat1.png"];
        
        /// New menu
        wallLeft = [[CCSprite alloc] initWithFile:@"wallLeftIphone5.png"];
        wallRight = [[CCSprite alloc] initWithFile:@"wallRightIphone5.png"];
        normalGround = [[CCSprite alloc] initWithFile:@"floorNormalIphone5.jpg"];
        hellGround = [[CCSprite alloc] initWithFile:@"hellGroundIphone5.png"];
        hideCracker = [[CCSprite alloc] initWithFile:@"hideCracker.png"];
        CCSprite *menuShelfs = [[CCSprite alloc] initWithFile:@"menuShelfs.png"];
        
        [girlEyes runAction:[self girlEyeAnim]];
        [menuchest runAction:[self chestAnim]];
        [guyEyes runAction:[self guyEyeAnim]];
        [menuGuyTunning runAction:[self tuningAnim]];
        [menuGuyPlay runAction:[self playAnim]];
        [menuFlames runAction:[self flamesAnim]];
        [menuBat runAction:[self batAnim]];
        
        [normalGround setAnchorPoint:ccp(0, 0)];
        [normalGround setPosition:ccp(0,0)];
        [hellGround setAnchorPoint:ccp(0, 0)];
        [hellGround setPosition:ccp(0, 0)];
        [wallLeft setAnchorPoint:ccp(0, 0)];
        [wallLeft setPosition:ccp(0, 0)];
        [wallRight setAnchorPoint:ccp(0, 0)];
        [wallRight setPosition:ccp(225, 183)];
        [wallLeft setAnchorPoint:ccp(0, 0)];
        [wallLeft setPosition:ccp(0, 175)];
        [hideCracker setAnchorPoint:ccp(0, 0)];
        [hideCracker setPosition:ccp(215, 185)];
        [menuShelfs setAnchorPoint:ccp(0, 0)];
        [menuShelfs setPosition:ccp(420, 300)];
        
        [hideCracker setScale:0.5];
        [menuShelfs setScale:0.5];
        
        //[menu1BG setPosition:ccp([[UniversalInfo sharedInstance] screenCenter].x + winsize.width/2,
        //                         [[UniversalInfo sharedInstance] screenCenter].y)];
        
        
        CCMenuItemImage *menuItem1 = [CCMenuItemImage itemFromNormalImage:@"newgame.png"
                                                            selectedImage: @"newgame.png"
                                                                   target:self
                                                                 selector:@selector(doNewGame:)];
        
        CCMenuItemImage *menuItem2 = [CCMenuItemImage itemFromNormalImage:@"credits.png"
                                                            selectedImage: @"credits2.png"
                                                                   target:self
                                                                 selector:@selector(doCredits:)];
        
        
        
        // changed to credits due to testing purposes
        CCMenuItemImage *menuItem3 = [CCMenuItemImage itemFromNormalImage:@"continue.png"
                                                            selectedImage: @"continue.png"
                                                                   target:self
                                                                 selector:@selector(doCredits:)];
        
        
        CCMenuItemImage *storeMenuItem = [CCMenuItemImage itemFromNormalImage:@"menu_chest1.png"
                                                                selectedImage: @"menu_chest2.png"
                                                                       target:self
                                                                     selector:@selector(doStore:)];
        
        
        
        
        menuItem1.scaleX = 0.5;
        menuItem1.scaleY = 0.5;
        
        menuItem3.scaleX = 0.5;
        menuItem3.scaleY = 0.5;
        
        
        
        NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
        levelNumber = [userdef integerForKey:@"Level"];
        
        CCMenu * myMenu;
        if (!levelNumber == 0){
            myMenu = [CCMenu menuWithItems:menuItem3, menuItem1, nil];
        }else{
            // just for testing purposes menuItem3 is from credits remove it from new game.
            myMenu = [CCMenu menuWithItems:menuItem3, menuItem1, nil];
        }
        // Create a menu and add your menu items to it
        
        // Create the handmenu items
        
        [myMenu setPosition:ccp(0,0)];
        
        CCMenuItemImage *handMenu1 = [CCMenuItemImage itemFromNormalImage:@"handbutton01.png"
                                                            selectedImage: @"handbutton01.png"
                                                                   target:self
                                                                 selector:@selector(doLeftSlide:)];
        
        CCMenuItemImage *handMenu2 = [CCMenuItemImage itemFromNormalImage:@"handbutton02.png"
                                                            selectedImage: @"handbutton02.png"
                                                                   target:self
                                                                 selector:@selector(doRightSlide:)];
        
        if ([[UniversalInfo sharedInstance] getDeviceType] == IPHONE_5)  {
            [guyEyes setPosition:ccp(55, 285)];
            [menuGuyTunning setPosition:ccp(175,270)];
            [menuGuyPlay setPosition:ccp(90,200)];
            [handMenu1 setPosition:ccp(430, -232)];
            [menugirl setPosition:ccp(600,180)];
            [menuFlames setPosition:ccp(609,450)];
            [girlEyes setPosition:ccp(585,335)];
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
        CCMenu *handMenu;
        CCMenu *storeMenu;
        [storeMenuItem setPosition:ccp(330,-80)];
        
        handMenu = [CCMenu menuWithItems:handMenu1, handMenu2, nil];
        storeMenu = [CCMenu menuWithItems:storeMenuItem, nil];
        
        
        [self loadBandVault];
        [self scheduleUpdate];
        
        //[self addChild:normalGround z:1];
        [self addChild:hellGround z:1];
        //[self addChild:myMenu];
        //[self addChild:wallRight z:1];
        [hellGround addChild:wallLeft z:1];
        [hellGround addChild:wallRight z:1];
        [hellGround addChild:normalGround];
        [hellGround addChild:handMenu];
        [hellGround addChild:hideCracker z:1];
        [hellGround addChild:menuShelfs z:1];
        
        /*
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
        */
        
        
        
        [self movingBackGround];
        
        
        
    }
    return self;
}

- (void)update:(ccTime)dt
{
    
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
    
}

-(void)doLeftSlide:(CCMenuItem *)menuItem
{
    NSLog(@"Do Left Slide");
    id actionMove = [CCMoveTo actionWithDuration:2.5 position:ccp(0,0)];
    //id actionElastic = [CCEaseElasticInOut actionWithAction:actionMove period:0.5];
    id actionElastic = [CCEaseExponentialOut actionWithAction:actionMove];
    //[CCEaseExponentialIn]
    bgOrientationMenu = -1;
    [hellGround runAction:actionElastic];
    
}

-(void)doRightSlide:(CCMenuItem *)menuItem
{
    NSLog(@"Do Right Slide");
    id actionMove = [CCMoveTo actionWithDuration:2.5 position:ccp(-winsize.width,
                                                                  0)];
    
    id actionElastic = [CCEaseExponentialOut actionWithAction:actionMove];
    bgOrientationMenu = 1;
    [hellGround runAction:actionElastic];
}

-(void)doNewGame:(CCMenuItem *)menuItem
{
    NSLog(@"The first menu was called");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:[BandGamePlay sceneWithLevel:0 wave:0]]];
}

-(void)doCredits:(CCMenuItem *)menuItem
{
    NSLog(@"The second menu was called");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:[Credits scene]]];
}

-(void)doContinue:(CCMenuItem *)menuItem
{
    NSLog(@"Continue game");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:[BandGamePlay sceneWithLevel:levelNumber wave:0]]];
}

-(void)doStore:(CCMenuItem *)menuItem
{
    NSLog(@"Store game");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:[BandStore scene]]];
}

@end
