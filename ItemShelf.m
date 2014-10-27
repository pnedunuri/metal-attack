//
//  ███╗   ███╗███████╗████████╗ █████╗ ██╗          █████╗ ████████╗████████╗ █████╗  ██████╗██╗  ██╗
//  ████╗ ████║██╔════╝╚══██╔══╝██╔══██╗██║         ██╔══██╗╚══██╔══╝╚══██╔══╝██╔══██╗██╔════╝██║ ██╔╝
//  ██╔████╔██║█████╗     ██║   ███████║██║         ███████║   ██║      ██║   ███████║██║     █████╔╝
//  ██║╚██╔╝██║██╔══╝     ██║   ██╔══██║██║         ██╔══██║   ██║      ██║   ██╔══██║██║     ██╔═██╗
//  ██║ ╚═╝ ██║███████╗   ██║   ██║  ██║███████╗    ██║  ██║   ██║      ██║   ██║  ██║╚██████╗██║  ██╗
//  ╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝    ╚═╝  ╚═╝   ╚═╝      ╚═╝   ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
//
//
//  ItemShelf.m
//  EightbitShooter
//
//  Created by Rafael Munhoz on 03/10/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//  This class represents a set of tree shelfs of items

#import "ItemShelf.h"
#import "BandStoreItem.h"
#import "UniversalInfo.h"
#import "BandVault.h"


@implementation ItemShelf

@synthesize shelfItems;
// solved the problem of copying array elements transforming this attribute into a property
// I don't know why but it seams that an attribute declared as not a @property has a static
// behavior.

CCNode *shelf1;
CCNode *shelf2;
CCNode *shelf3;

CCSprite *itemSummaryBG;
CCLabelTTF *bandCoinsLabel;

NSMutableArray *menuItems;
BandVault *vault;



CGPoint const itemSummaryPositionHide = {485, 800};
CGPoint const itemSummaryPositionShow = {485, 300};

-(id)initWithItems:(NSArray *)allItems coinsLabel:(CCLabelTTF*)coinsLabel range:(NSRange)itemsRange;
{
    if([super initWithColor:[[CCColor alloc] initWithCcColor4b:ccc4(0, 0, 0, 0)]]) {
    
        //iterate over items array to produce the items for the
        //menus to make the UI feasible it is possible to
        //assume that items has 5 elemnts
        
        shelfItems = [[NSArray alloc] initWithArray:[allItems subarrayWithRange:itemsRange]];
        menuItems = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [shelfItems count]; i++) {
            BandStoreItem *item = (BandStoreItem *)[shelfItems objectAtIndex:i];
            //CCMenuItem *menuItem = [CCMenuItemImage itemFromNormalImage:item.storeItemFrmName selectedImage: item.storeItemFrmName target:self selector:@selector(doShowItemSummary:)];
            
            CCButton *menuItem = [CCButton buttonWithTitle:@"" spriteFrame:[CCSprite spriteWithImageNamed:item.storeItemFrmName] highlightedSpriteFrame:[CCSprite spriteWithImageNamed:item.storeItemFrmName] disabledSpriteFrame:nil];
            
            [menuItem setTarget:self selector:@selector(doShowItemSummary:)];
#warning find a way to replace the use of setTag
            //[menuItem setTag:i];
            [menuItem setScale:0.5];
            [menuItems addObject:menuItem];
        }
    }
    
    //shelf1 = [CCMenu menuWithItems:[menuItems objectAtIndex:0], [menuItems objectAtIndex:1], nil];
    //shelf2 = [CCMenu menuWithItems:[menuItems objectAtIndex:2], [menuItems objectAtIndex:3], nil];
    //shelf3 = [CCMenu menuWithItems:[menuItems objectAtIndex:4], nil];
    
    [shelf1 addChild:[menuItems objectAtIndex:0]];
    [shelf1 addChild:[menuItems objectAtIndex:1]];
    
    [shelf2 addChild:[menuItems objectAtIndex:2]];
    [shelf2 addChild:[menuItems objectAtIndex:3]];
    
    [shelf3 addChild:[menuItems objectAtIndex:4]];
  
    //[shelf1 alignItemsHorizontallyWithPadding:20];
    //[shelf2 alignItemsHorizontallyWithPadding:20];
    //[shelf3 alignItemsHorizontally];
    
    [shelf1 setPosition:ccp(470,398)];
    [self addChild:shelf1];
    [shelf2 setPosition:ccp(470,295)];
    [self addChild:shelf2];
    [shelf3 setPosition:ccp(460,185)];
    [self addChild:shelf3];
    
    vault = [BandVault sharedInstance];
    bandCoinsLabel = coinsLabel;
    
    return self;
}

-(void)doShowItemSummary:(CCButton *)menuItem
{
    NSLog(@"doShowItemSummary");
    //BandStoreItem *selectedItem = [shelfItems objectAtIndex:menuItem.tag];
    BandStoreItem *selectedItem = [shelfItems objectAtIndex:0];
    
    //NSLog(@"Buy Item %@",selectedItem.name);

    //MAX 10 Chars
    
    NSString *itemCostStr = [[NSString alloc] initWithFormat:@"%d",selectedItem.value];
    

    
    CCLabelTTF *itemName = [CCLabelTTF labelWithString:selectedItem.itemName fontName:@"28DaysLater" fontSize:45];
    CCLabelTTF *itemCost = [CCLabelTTF labelWithString:itemCostStr fontName:@"28DaysLater" fontSize:45];
    
    CCLabelTTF *itemDescription = [CCLabelTTF labelWithString:selectedItem.description fontName:@"28DaysLater" fontSize:45 dimensions:CGSizeMake(300, 400)];
    
    //CCLabelTTF *itemDescription = [CCLabelTTF labelWithString:selectedItem.description dimensions:CGSizeMake(300, 400) alignment:UITextAlignmentCenter fontName:@"28DaysLater" fontSize:35];
    
    
    CCSprite *itemImage = [[CCSprite alloc] initWithImageNamed:selectedItem.storeItemFrmName];
    
    itemSummaryBG = [[CCSprite alloc] initWithImageNamed:@"itemBg.png"];
    
    [itemSummaryBG setPosition:itemSummaryPositionHide];
    [itemSummaryBG setScale:0.5];
    
    //CCMenuItemImage *closeSummaryButton = [CCMenuItemImage itemFromNormalImage:@"close.png"
    //                                                     selectedImage: @"close.png"
    //                                                            target:self
    //                                                          selector:@selector(doCloseSummary:)];
    
    CCButton *closeSummaryButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSprite spriteWithImageNamed:@"close.png"] highlightedSpriteFrame:[CCSprite spriteWithImageNamed:@"close.png"] disabledSpriteFrame:nil];
    
    
    //CCMenuItemImage *buyItemButton = [CCMenuItemImage itemFromNormalImage:@"buyItem.png"
    //                                                        selectedImage: @"buyItem.png"
    //                                                               target:self
    //                                                             selector:@selector(doBuyItem:)];
    
    
    CCButton *buyItemButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSprite spriteWithImageNamed:@"buyItem.png"] highlightedSpriteFrame:[CCSprite spriteWithImageNamed:@"buyItem.png"] disabledSpriteFrame:nil];
    
    
    
    //CCMenu *closeMenu = [CCMenu menuWithItems:closeSummaryButton, nil];
    
    //CCMenu *buyMenu = [CCMenu menuWithItems:buyItemButton, nil];

    CCNode *closeMenu = [[CCNode alloc] init];
    [closeMenu addChild:closeSummaryButton];
    
    CCNode *buyMenu = [[CCNode alloc] init];
    [buyMenu addChild:buyItemButton];
    
    //[buyItemButton setTag:menuItem.tag];
    
    [itemImage setPosition:ccp(220, 600)];
    
    [buyItemButton setPosition:ccp(-50,-150)];
    [closeMenu setPosition:ccp(60,700)];
    [itemName setPosition:ccp(270,700)];
    [itemDescription setPosition:ccp(200,310)];
    
    CCSprite *spriteCoin = [[UniversalInfo sharedInstance] getSpriteWithCoinAnimation];
    
    [itemCost setPosition:ccp(150,240)];
    [spriteCoin setPosition:ccp(50, 250)];
    
    [itemSummaryBG addChild:itemName];
    [itemSummaryBG addChild:itemImage];
    [itemSummaryBG addChild:buyMenu];
    [itemSummaryBG addChild:closeMenu];
    [itemSummaryBG addChild:itemCost];
    [itemSummaryBG addChild:itemDescription];
    [itemSummaryBG addChild:spriteCoin];
    [self addChild:itemSummaryBG];
    
    id moveInItemSummary = [CCActionMoveTo actionWithDuration:0.5 position:itemSummaryPositionShow];
    id moveInItemSummaryElastic = [CCActionEaseBackInOut actionWithAction:moveInItemSummary];
    [itemSummaryBG runAction:moveInItemSummaryElastic];
    
}

-(void)doCloseSummary:(CCButton *)menuItem
{
    NSLog(@"Close item summary");
    [self moveOutItemSummary];

}

-(void)doBuyItem:(CCButton *)menuItem
{
    
    //BandStoreItem *itemTobuy = [shelfItems objectAtIndex:menuItem.tag];
    
    BandStoreItem *itemTobuy = [shelfItems objectAtIndex:0];
    NSLog(@"Buy Item ");
    
    if ([itemTobuy itemType] == BAND_COIN_PACK) {
        NSLog(@"Not ready yeat it will be required to comunicate with the appstore");
        //#### NOT READY YETT
        // This product requires access to appstore
        //NSLog(@"Coin pack connect to app store for product %@",[itemTobuy appStoreId]);
        //NSSet *products = [[NSSet alloc] initWithObjects:[itemTobuy appStoreId], nil];
        //SKProductsRequest *prequest = [[SKProductsRequest alloc] initWithProductIdentifiers:products];
        //prequest.delegate = self;
        //[prequest start];
    }else{
        // the purchase of this product does not require access to appstore
        // remove the coins from inventory here and store the product
        if ([itemTobuy credits] <= [vault bandCoins]){
            [vault storeItem:[itemTobuy appStoreId]];
            [vault updateBandCoins:-[itemTobuy credits]];
            NSNumber *bandCoins = [[NSNumber alloc] initWithInt:[vault bandCoins]];
            [bandCoinsLabel setString:[[UniversalInfo sharedInstance] addZeroesToNumber:[bandCoins stringValue]]];
            [self moveOutItemSummary];
        }else{
            NSLog(@"No money pal");
        }
        
    }
    
}

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSLog(@"Product Request %d",[[response products] count]);
    if ([[response products] count] != 0) {
        SKProduct *coinPack = [[response products] objectAtIndex:0];
        SKPayment *coinPackPayment = [SKPayment paymentWithProduct:coinPack];
        SKPaymentQueue *paymentQueue = [SKPaymentQueue defaultQueue];
        [paymentQueue addPayment:coinPackPayment];
        // it is necessary to know how to get the value of the credits from the coin pack
        //[vault updateBandCoins:[itemTobuy credits]];
    }else{
        NSLog(@"Try latter");
        // show a message that says to try again latter
    }
}


-(void)moveOutItemSummary
{
    id moveOutItemSummary = [CCActionMoveTo actionWithDuration:0.5 position:itemSummaryPositionHide];
    id moveOutItemSummaryElastic = [CCActionEaseBackInOut actionWithAction:moveOutItemSummary];
    [itemSummaryBG runAction:moveOutItemSummaryElastic];
}

@end
