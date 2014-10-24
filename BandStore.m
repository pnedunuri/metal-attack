//
//  BandStore.m
//  EightbitShooter
//
//  Created by Rafael Munhoz on 08/04/13.
//
//

#import "BandStore.h"
#import "UniversalInfo.h"
#import "BandStoreItemsCtrl.h"
#import "ItemShelfCtrl.h"
#import "BandBuyPoster.h"


@implementation BandStore

CCSprite *storeSprite;
CCSprite *usrMoneyBg;
CCLabelTTF *bandCoinsLabel;
CCSprite *ownedTag;
CCMenu *selectMenu;
CCMenu *buyMenu;
int itemCount;
int labelfontSize;
CGSize winsize;
CCSprite* storeBackground;
CCSprite* storeFrontBackGround;
int storeBgOrient = 1;
CCSprite *bandMenuBg;
CCSprite *bandBuy;
BandBuyPoster *bandBuyPoster;

CGPoint const bandSelectionMenuHidePosition = {150, 800};
CGPoint const bandSelectionMenuShowPosition = {150, 400};



@synthesize labelCredits;

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	BandStore *layer = [BandStore node];
	[scene addChild: layer];
	return scene;
}

-(CCAction *)loadSpriteAnimation:(NSString *)frameName numberOfFrames:(int)frames
{
    NSString *itemFrame = [frameName stringByAppendingString:@"%d.png"];
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 1; i <= frames; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:itemFrame,i]];
        [animFrames addObject:frame];
    }
    CCAnimation *animation = [CCAnimation animationWithFrames:animFrames delay:0.2f];
    CCAction *itemAction = [CCRepeatForever actionWithAction:
                            [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO]];
    return itemAction;
}

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSLog(@"Product Request %d",[[response products] count]);
    if ([[response products] count] != 0) {
        SKProduct *coinPack = [[response products] objectAtIndex:0];
        SKPayment *coinPackPayment = [SKPayment paymentWithProduct:coinPack];
        SKPaymentQueue *paymentQueue = [SKPaymentQueue defaultQueue];
        [paymentQueue addPayment:coinPackPayment];
    }else{
        NSLog(@"Try latter");
    }
}

-(NSString *)unselectBandGuy:(BandItemType )itemType
{
    // search the array for the selected item per itemType
    // only one selected item shall be avalible
    // returns the id of the unselected item
    for (int i = 0; i < [[bandBuyPoster itemsToShow] count]; i++) {
        BandStoreItem *item = (BandStoreItem *)[[bandBuyPoster itemsToShow] objectAtIndex:i];
        if (item.itemType == itemType){
            
            if (item.selected == YES){
                item.selected = NO;
                return item.appStoreId;
            }
        }
    }
    return nil;
}

-(void)doBuy:(CCMenuItem *)menuItem
{
    //#### found a crash solve it 20/10/2014 ######//
    
    BandVault *vault = [BandVault sharedInstance];
    //NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
    NSString *previousSelectedGuy;
    BandStoreItem *bandStoreItem = [[bandBuyPoster itemsToShow] objectAtIndex:itemCount];
    
    if (bandStoreItem.owned == YES) {
        // the item is owned by the user so just select it
        NSLog(@"Active the item on the hero !");
        switch ([bandStoreItem itemType]) {
            case DRUMMER:
                bandStoreItem.selected = YES;
                previousSelectedGuy = [self unselectBandGuy:DRUMMER];
                [vault selectBandGuy:bandStoreItem.appStoreId bandGuyType:DRUMMER oldSelectedGuy:previousSelectedGuy];
                [vault setDrummerIndex:itemCount];
                //[vault setDrummerId:[[[bandBuyPoster itemsToShow] objectAtIndex:itemCount] appStoreId]];
                break;
            case BASSGUY:
                [vault setBassId:[[[bandBuyPoster itemsToShow] objectAtIndex:itemCount] appStoreId]];
                [vault setBassIndex:itemCount];
                break;
            case VOCALIST:
                [vault setVocalId:[[[bandBuyPoster itemsToShow] objectAtIndex:itemCount] appStoreId]];
                [vault setVocalIndex:itemCount];
                break;
            case GUITARRIST_1:
                [vault setGuitar1Id:[[[bandBuyPoster itemsToShow] objectAtIndex:itemCount] appStoreId]];
                [vault setGuitar1Index:itemCount];
                break;
            case GUITARRIST_2:
                [vault setGuitar2Id:[[[bandBuyPoster itemsToShow] objectAtIndex:itemCount] appStoreId]];
                [vault setGuitar2Index:itemCount];
                break;
            default:
                break;
        }

    }else{
        // comunicate with appstore only for coin packs
        NSLog(@"Buy the item");
        
        if ([bandStoreItem itemType] == BAND_COIN_PACK) {
            NSLog(@"Coin pack connect to app store for product %@",[bandStoreItem appStoreId]);
            
            // not working maybe there is a problem with the sandbox
            // store entry point
            
            NSSet *products = [[NSSet alloc] initWithObjects:[[[bandBuyPoster itemsToShow] objectAtIndex:itemCount] appStoreId], nil];
            
            SKProductsRequest *prequest = [[SKProductsRequest alloc] initWithProductIdentifiers:products];
            
            prequest.delegate = self;
            
            [prequest start];
            
            
            /*
             SKPayment *coinPackPayment = [SKPayment paymentWithProductIdentifier:@"coinPack4"];
             
             SKPaymentQueue *paymentQueue = [SKPaymentQueue defaultQueue];
             [paymentQueue addPayment:coinPackPayment];
             */
            
        }else{
            //The user dont have this item yet, so this item will be marked as owned
            if ([vault bandCoins] >= [bandStoreItem credits]) {
                NSLog(@"Purchase complete");
                [vault storeBandGuy:[bandStoreItem appStoreId] indexPosition:itemCount];
                [vault updateBandCoins:-bandStoreItem.credits];
                //vault.bandCoins = vault.bandCoins - [[[bandBuyPoster itemsToShow] objectAtIndex:itemCount] credits];
                //[userdef setInteger:vault.bandCoins forKey:@"coins"];
                //[userdef setBool:YES forKey:[[[bandBuyPoster itemsToShow] objectAtIndex:itemCount] appStoreId]];
                bandStoreItem.owned = YES;
                //[[[bandBuyPoster itemsToShow] objectAtIndex:itemCount] setOwned:YES];
                ownedTag.visible = YES;
                NSNumber *bandCoins = [[[NSNumber alloc] initWithInt:[vault bandCoins]] autorelease];
                [bandCoinsLabel setString:[[UniversalInfo sharedInstance] addZeroesToNumber:[bandCoins stringValue]]];
                [buyMenu setVisible:YES];
                [selectMenu setVisible:YES];
            }else{
                // put a message for the user.
                NSLog(@"You don't have enought coins");
            }
        }
    }

    [self replaceBandMenu];
}

-(void)doBack:(CCMenuItem *)menuItem
{
    NSLog(@"Do Back");
    [[CCDirector sharedDirector] replaceScene: [MainMenu scene]];
}

/*
-(void)doShowCoinPacks:(CCMenuItem *)menuItem
{
    
    [self removeChild:storeSprite cleanup:YES];
    [self removeChild:itemLabel cleanup:YES];
    [self removeChild:itemPrice cleanup:YES];
    
    itemCount = 0;
    NSLog(@"Do show packs");
    BandStoreItemsCtrl *itemsCtrl = [BandStoreItemsCtrl sharedInstance];
    //itemsToShow = [BandItemsCtrl coinPackItems];
    
    //storeSprite = [[[CCSprite alloc] init] autorelease];
    //[storeSprite runAction:[self loadSpriteAnimation:@"coin1_frm"]];
    
    [storeSprite runAction:[self loadSpriteAnimation:[[itemsToShow objectAtIndex:0] storeItemFrmName] numberOfFrames:[[itemsToShow objectAtIndex:0] itemframes]]];
    
    
    //[storeSprite runAction:[self loadSpriteAnimation:[[itemsToShow objectAtIndex:0] itemframes] numberOfFrames:[[itemsToShow objectAtIndex:0] itemArmFrmName]]];
    

    itemLabel = [CCLabelTTF labelWithString:[[itemsToShow objectAtIndex:0] description] fontName:@"Marker Felt" fontSize:labelfontSize];
    
    itemPrice = [CCLabelTTF labelWithString:[[[NSNumber alloc] initWithInt:[[itemsToShow objectAtIndex:0] credits]] stringValue] fontName:@"Marker Felt" fontSize:labelfontSize];
    
    ownedTag.visible = [[itemsToShow objectAtIndex:0] owned];
    
    if ([[itemsToShow objectAtIndex:0] owned]){
        //selectButton.visible = YES;
        //buyButton.visible = NO;
        
        [selectMenu setVisible:YES];
        [buyMenu setVisible:NO];
    }else{
        //selectButton.visible = NO;
        //buyButton.visible = YES;
    
        [selectMenu setVisible:NO];
        [buyMenu setVisible:YES];
    }
    
    if ([[UniversalInfo sharedInstance] isDeviceIpad]) {
        storeSprite.position = ccp(384,620);
        itemLabel.position = ccp(384,550);
        itemPrice.position = ccp(384,530);
    }else{
        storeSprite.position = ccp(160,270);
        itemLabel.position = ccp(160,200);
        itemPrice.position = ccp(160,180);
    }

    [self addChild:storeSprite];
    [self addChild:itemLabel];
    [self addChild:itemPrice];
}
 */

-(void)doShowItemDefault
{
    [bandBuyPoster doShowGuitarrist];
}

-(CCMenu *)createBandSelectionMenu
{
    
    CCMenuItemImage *guitar1MenuBnt = [CCMenuItemImage itemFromNormalImage:@"Guitar01ON.png"
                                                             selectedImage: @"Guitar01OFF.png"
                                                                    target:self
                                                                  selector:@selector(doBandSelect:)];
    
    [guitar1MenuBnt setTag:1];
    
    CCMenuItemImage *guitar2MenuBnt = [CCMenuItemImage itemFromNormalImage:@"Guitar02ON.png"
                                                             selectedImage: @"Guitar02OFF.png"
                                                                    target:self
                                                                  selector:@selector(doBandSelect:)];
    
    [guitar2MenuBnt setTag:2];
    
    CCMenuItemImage *drummerMenuBnt = [CCMenuItemImage itemFromNormalImage:@"DrumerON.png"
                                                             selectedImage: @"DrumerOFF.png"
                                                                    target:self
                                                                  selector:@selector(doBandSelect:)];
    
    [drummerMenuBnt setTag:3];
    
    CCMenuItemImage *bassMenuBnt = [CCMenuItemImage itemFromNormalImage:@"BassON.png"
                                                             selectedImage: @"BassOFF.png"
                                                                    target:self
                                                                  selector:@selector(doBandSelect:)];
    
    [bassMenuBnt setTag:4];
    
    CCMenuItemImage *vocalMenuBnt = [CCMenuItemImage itemFromNormalImage:@"VocalON.png"
                                                             selectedImage: @"VocalOFF.png"
                                                                    target:self
                                                                  selector:@selector(doBandSelect:)];
    
    [vocalMenuBnt setTag:5];
    
    [vocalMenuBnt setPosition:ccp(-130,-130)];
    [guitar1MenuBnt setPosition:ccp(-130,75)];
    [drummerMenuBnt setPosition:ccp(-15,130)];
    [bassMenuBnt setPosition:ccp(85, 55)];
    [guitar2MenuBnt setPosition:ccp(82,-125)];
    
    CCMenu *bandSelectMenu = [CCMenu menuWithItems:guitar1MenuBnt, guitar2MenuBnt, drummerMenuBnt, bassMenuBnt, vocalMenuBnt, nil];
    
    return bandSelectMenu;
    
}

-(void)doBandSelect:(CCMenuItem *)menuItem
{
    NSLog(@"Band component select");
    id moveOutBandMenu = [CCMoveTo actionWithDuration:1.2 position:bandSelectionMenuHidePosition];
    id moveOutBandMenuElastic = [CCEaseBackInOut actionWithAction:moveOutBandMenu];
    [bandMenuBg runAction:moveOutBandMenuElastic];
    
    
    switch (menuItem.tag) {
        case 1:
            NSLog(@"show guitarrist 1");
            [bandBuyPoster doShowGuitarrist];
            break;
        case 2:
            NSLog(@"show guitarrist 2");
            [bandBuyPoster doShowGuitarrist];
            break;
        case 3:
            NSLog(@"show drummer");
            [bandBuyPoster doShowDrummer:menuItem];
            break;
        case 4:
            NSLog(@"Show bass guy");
            [bandBuyPoster doShowBass:menuItem];
            break;
        case 5:
            NSLog(@"Show vocal");
            [bandBuyPoster doShowVocalist:menuItem];
            break;
            
        default:
            break;
    }
    
    id moveInBandBuy = [CCMoveTo actionWithDuration:1.2 position:bandSelectionMenuShowPosition];
    id moveInBandBuyElastic = [CCEaseBackInOut actionWithAction:moveInBandBuy];
    [bandBuy runAction:moveInBandBuyElastic];
    
}


-(void)showBandMenu
{
    // this method will create the menu for the band componetns to be buyed
    bandMenuBg = [[CCSprite alloc] initWithFile:@"posterBand.png"];
    [bandMenuBg setScale:0.5];
    [bandMenuBg setPosition:bandSelectionMenuHidePosition];
    [storeBackground addChild:bandMenuBg z:5];

    
    id moveBandMenu = [CCMoveTo actionWithDuration:1.2 position:bandSelectionMenuShowPosition];
    id moveBandMenuElastic = [CCEaseBackInOut actionWithAction:moveBandMenu];

    bandBuy = [[CCSprite alloc] initWithFile:@"posterBand.png"];
    [bandBuy setScale:0.5];
    [bandBuy setPosition:bandSelectionMenuHidePosition];
    [storeBackground addChild:bandBuy z:5];
    
    CCMenuItemImage *selectRightButton = [CCMenuItemImage itemFromNormalImage:@"rightArrow.png"
                                                                  selectedImage: @"rightArrow.png"
                                                                         target:self
                                                                       selector:@selector(doBandSelectRight:)];
    [selectRightButton setScale:0.5];
    
    
    CCMenuItemImage *selectLeftButton = [CCMenuItemImage itemFromNormalImage:@"leftArrow.png"
                                                                  selectedImage: @"leftArrow.png"
                                                                         target:self
                                                                       selector:@selector(doBandSelectLeft:)];
    
    [selectLeftButton setScale:0.5];
    
    CCMenuItemImage *buyRightButton = [CCMenuItemImage itemFromNormalImage:@"rightArrow.png"
                                                                  selectedImage: @"rightArrow.png"
                                                                         target:self
                                                                       selector:@selector(doBandSelectRight:)];
    [buyRightButton setScale:0.5];
    
    
    CCMenuItemImage *buyLeftButton = [CCMenuItemImage itemFromNormalImage:@"leftArrow.png"
                                                                 selectedImage: @"leftArrow.png"
                                                                        target:self
                                                                      selector:@selector(doBandSelectLeft:)];
    
    [buyLeftButton setScale:0.5];
    
    
    CCMenuItemImage *buyButton = [CCMenuItemImage itemFromNormalImage:@"buyItem.png"
                                       selectedImage: @"buyItem.png" target:self selector:@selector(doBuy:)];
    
    
    CCMenuItemImage *selectButton = [CCMenuItemImage itemFromNormalImage:@"selectItem.png"
                                          selectedImage: @"selectItem.png" target:self selector:@selector(doBuy:)];
    
    CCMenu *bandSelectMenu = [self createBandSelectionMenu];
    
    selectMenu = [CCMenu menuWithItems:selectLeftButton,selectButton, selectRightButton, nil];
    buyMenu = [CCMenu menuWithItems:buyLeftButton,buyButton, buyRightButton, nil];
    
    [buyMenu setVisible:NO];
    
    [bandSelectMenu setPosition:ccp(260, 295)];
    
    [selectMenu alignItemsHorizontallyWithPadding:1];
    [selectMenu setPosition:ccp(316, 150)];
    
    [buyMenu alignItemsHorizontallyWithPadding:1];
    [buyMenu setPosition:ccp(316, 150)];
    
    bandBuyPoster = [[BandBuyPoster alloc] init];
    [bandBuyPoster setSelectMenu:selectMenu];
    [bandBuyPoster setBuyMenu:buyMenu];
    [bandBuyPoster setBandBuy:bandBuy];
    
    
    [bandBuy addChild:buyMenu];
    [bandBuy addChild:selectMenu];
    [bandMenuBg addChild:bandSelectMenu];
    [bandMenuBg runAction:moveBandMenuElastic];

}

-(void)doBandSelectLeft:(CCMenuItem *)menuItem
{
    NSLog(@"doBandSelectLeft");
    [bandBuyPoster doScrLeft:menuItem];
}

-(void)doBandSelectRight:(CCMenuItem *)menuItem
{
    NSLog(@"doBandSelectRight");
    [bandBuyPoster doScrRigh:menuItem];
}

-(void)replaceBandMenu
{
    NSLog(@"replaceBandMenu");
    
    id moveInBandBuy = [CCMoveTo actionWithDuration:1.2 position:bandSelectionMenuHidePosition];
    id moveInBandBuyElastic = [CCEaseBackInOut actionWithAction:moveInBandBuy];
    [bandBuy runAction:moveInBandBuyElastic];
    
    id moveOutBandMenu = [CCMoveTo actionWithDuration:1.2 position:bandSelectionMenuShowPosition];
    id moveOutBandMenuElastic = [CCEaseBackInOut actionWithAction:moveOutBandMenu];
    [bandMenuBg runAction:moveOutBandMenuElastic];
}

-(void)onEnterTransitionDidFinish
{
    [self showBandMenu];
}

-(void)buildIphone5StoreScreen
{
    
    
    CCSprite *cachier = [[CCSprite alloc] initWithFile:@"cachier.png"];
    CCSprite *punk = [[CCSprite alloc] initWithFile:@"punk.png"];
    
    [cachier setPosition:ccp(180,220)];
    [punk setPosition:ccp(580,200)];
  
    [cachier setScale:0.48];
    [punk setScale:0.5];
    
    storeBackground = [CCSprite spriteWithFile:@"storebg_iphone5.jpg"];
    storeFrontBackGround = [CCSprite spriteWithFile:@"storeFrontBG_iphone5.png"];
    
    
    [storeBackground setPosition:ccp([[UniversalInfo sharedInstance] screenCenter].x + winsize.width/2,
                             [[UniversalInfo sharedInstance] screenCenter].y)];
    
    [storeFrontBackGround setPosition:ccp([[UniversalInfo sharedInstance] screenCenter].x + winsize.width/2,
                                     [[UniversalInfo sharedInstance] screenCenter].y)];
    
    
    CCMenuItemImage * backMenuItem = [CCMenuItemImage itemFromNormalImage:@"Button back ON.png"
                                                         selectedImage: @"Button back OFF.png"
                                                                target:self
                                                              selector:@selector(doBack:)];
    [backMenuItem setScale:0.5];
    [backMenuItem setPosition:ccp(-110,-232)];
    
    CCMenuItemImage *handMenu1 = [CCMenuItemImage itemFromNormalImage:@"handbutton01.png"
                                                        selectedImage: @"handbutton01.png"
                                                               target:self
                                                             selector:@selector(doLeftSlide:)];
    
    [handMenu1 setPosition:ccp(430, -232)];
    
    CCMenuItemImage *handMenu2 = [CCMenuItemImage itemFromNormalImage:@"handbutton02.png"
                                                        selectedImage: @"handbutton02.png"
                                                               target:self
                                                             selector:@selector(doRightSlide:)];
    
    [handMenu2 setPosition:ccp(winsize.width * 0.328, - winsize.height * 0.409)];

    CCMenu * storeButtons = [CCMenu menuWithItems:handMenu1, handMenu2, backMenuItem,  nil];
    
    
    usrMoneyBg = [[CCSprite alloc] initWithFile:@"userMoney.png"];
    [usrMoneyBg setScale:0.25];
    [usrMoneyBg setPosition:ccp(155, 10)];
    
    CCSprite *coinAnimated = [[UniversalInfo sharedInstance] getSpriteWithCoinAnimation];
    
    BandVault *vault = [BandVault sharedInstance];
    
    
    NSString *strCoins = [[NSString alloc] initWithFormat:@"%d",vault.bandCoins];
    
    bandCoinsLabel = [CCLabelTTF labelWithString:[[UniversalInfo sharedInstance] addZeroesToNumber:strCoins] dimensions:CGSizeMake(470, 200) alignment:UITextAlignmentCenter fontName:@"28DaysLater" fontSize:78];
    
    
    [bandCoinsLabel setPosition:ccp(300,15)];
    
    ItemShelfCtrl *itemShelfCtrl = [[ItemShelfCtrl alloc] initwithCoinLabel:bandCoinsLabel];
    [coinAnimated setPosition:ccp(100,80)];
    [usrMoneyBg addChild:bandCoinsLabel];
    [usrMoneyBg addChild:coinAnimated];
    
    [self addChild:storeBackground];
    [self addChild:usrMoneyBg];
    [storeBackground addChild:storeFrontBackGround z:6];
    [storeBackground addChild:cachier z:10];
    [storeBackground addChild:itemShelfCtrl];
    [storeBackground addChild:punk z:10];
    [storeBackground addChild:storeButtons z:11];

}


-(void)doLeftSlide:(CCMenuItem *)menuItem
{
    NSLog(@"Do Left Slide");
    id actionMove = [CCMoveTo actionWithDuration:2.5 position:ccp([[UniversalInfo sharedInstance] screenCenter].x + winsize.width/2,
                                                                  [[UniversalInfo sharedInstance] screenCenter].y)];
    id actionElastic = [CCEaseExponentialOut actionWithAction:actionMove];
    storeBgOrient = -1;
    [storeBackground runAction:actionElastic];
    
    
}

-(void)doRightSlide:(CCMenuItem *)menuItem
{
    NSLog(@"Do Right Slide");
    id actionMove = [CCMoveTo actionWithDuration:2.5 position:ccp([[UniversalInfo sharedInstance] screenCenter].x - winsize.width/2,
                                                                  [[UniversalInfo sharedInstance] screenCenter].y)];
    id actionElastic = [CCEaseExponentialOut actionWithAction:actionMove];
    storeBgOrient = 1;
    [storeBackground runAction:actionElastic];
}



-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        winsize = [[CCDirector sharedDirector] winSize];
        
        DeviceType devtype = [[UniversalInfo sharedInstance] getDeviceType];
        
        if (devtype == IPHONE_5){
            [self buildIphone5StoreScreen];
        }else{
            //menu1BG = [[CCSprite alloc] initWithFile:@"newmenubg.png"];
        }

    }
	return self;
}


@end
