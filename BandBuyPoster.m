//
//  BandBuyPoster.m
//  EightbitShooter
//
//  Created by Rafael Munhoz on 08/10/14.
//
//

#import "BandBuyPoster.h"
#import "BandStoreItemsCtrl.h"
#import "CCAnimation.h"

@implementation BandBuyPoster
@synthesize itemsToShow;
@synthesize selectMenu;
@synthesize buyMenu;
@synthesize bandBuy;
@synthesize delegate;

int itemCount;
int labelfontSize;
CCSprite *storeSprite;

CCLabelTTF *itemLabel;
CCLabelTTF *itemPrice;
CCLabelTTF *itemArmor;
CCLabelTTF *itemDamage;

CCSprite *ownedTag;

CGPoint const storeSpritePosition = {340, 360};

-(id)init
{
    self = [super init];
    NSLog(@"Init BandBuyPoster");
    //[super init];
    ownedTag = [[CCSprite alloc] initWithImageNamed:@"owned.png"];
    return self;
}

-(void)setBandBuy:(CCSprite *)bandBuySprite
{
    NSLog(@"setBandBuy");
    bandBuy = bandBuySprite;
    [ownedTag setPosition:ccp(420, 530)];
    [bandBuy addChild:ownedTag];
}

-(void)doScrRigh:(CCButton *)menuItem
{
    NSLog(@"doScrRigh");
    itemCount++;
    if (itemCount < [itemsToShow count]) {
        [bandBuy removeChild:storeSprite cleanup:YES];
        
        storeSprite = [[CCSprite alloc] init];
        [storeSprite runAction:[self loadSpriteAnimation:[[itemsToShow objectAtIndex:itemCount] storeItemFrmName] numberOfFrames:1]];
    
        ownedTag.visible = [[itemsToShow objectAtIndex:itemCount] ownedBandItem];
        
        [buyMenu setVisible:![[itemsToShow objectAtIndex:itemCount] ownedBandItem]];
        [selectMenu setVisible:[[itemsToShow objectAtIndex:itemCount] ownedBandItem]];
        
        [storeSprite setPosition:storeSpritePosition];
        [storeSprite setScale:1.5];
        [bandBuy addChild:storeSprite];
        
        [self updateText:[itemsToShow objectAtIndex:itemCount]];
        
    }else{
        itemCount = [itemsToShow count] - 1;
    }
    
    NSLog(@"doScrRigh %d",itemCount);
}

-(void)doScrLeft:(CCButton *)menuItem
{
    NSLog(@"doScrLeft");
    itemCount--;
    if (itemCount < [itemsToShow count]) {
        [bandBuy removeChild:storeSprite cleanup:YES];
        
        storeSprite = [[CCSprite alloc] init];
        
        [storeSprite runAction:[self loadSpriteAnimation:[[itemsToShow objectAtIndex:itemCount] storeItemFrmName] numberOfFrames:1]];
        
        ownedTag.visible = [[itemsToShow objectAtIndex:itemCount] ownedBandItem];
        
        [buyMenu setVisible:![[itemsToShow objectAtIndex:itemCount] ownedBandItem]];
        [selectMenu setVisible:[[itemsToShow objectAtIndex:itemCount] ownedBandItem]];
        [storeSprite setPosition:storeSpritePosition];
        [storeSprite setScale:1.5];
        [bandBuy addChild:storeSprite];
        [self updateText:[itemsToShow objectAtIndex:itemCount]];
        
    }else{
        itemCount = 0;
    }
    NSLog(@"doScrLeft %d", itemCount);
    
}

-(void)doShowGuitarrist
{
    [bandBuy removeChild:storeSprite cleanup:YES];
    
    itemCount = 0;
    
    NSLog(@"Do show guitarrist");
    
    BandStoreItemsCtrl *itemsCtrl = [BandStoreItemsCtrl sharedInstance];
    
    itemsToShow = [itemsCtrl guitarrists];
    storeSprite = [[CCSprite alloc] init];
    [storeSprite runAction:[self loadSpriteAnimation:[[itemsToShow objectAtIndex:0] storeItemFrmName] numberOfFrames:1]];
    
    ownedTag.visible = [[itemsToShow objectAtIndex:0] ownedBandItem];
    
    [buyMenu setVisible:![[itemsToShow objectAtIndex:0] ownedBandItem]];
    [selectMenu setVisible:[[itemsToShow objectAtIndex:0] ownedBandItem]];
    
    [storeSprite setPosition:storeSpritePosition];
    [storeSprite setScale:1.5];
    
    [bandBuy addChild:storeSprite];
    [self updateText:[itemsToShow objectAtIndex:0]];
}

-(void)doShowVocalist:(CCButton *)menuItem
{
    [bandBuy removeChild:storeSprite cleanup:YES];
    
    itemCount = 0;
    
    NSLog(@"Do show vocalist");
    
    BandStoreItemsCtrl *itemsCtrl = [BandStoreItemsCtrl sharedInstance];
    itemsToShow = [itemsCtrl vocals];
    
    storeSprite = [[CCSprite alloc] init];
    
    [self loadSpriteAnimation:[[itemsToShow objectAtIndex:0] storeItemFrmName] numberOfFrames:0];
    
    [storeSprite runAction:[self loadSpriteAnimation:[[itemsToShow objectAtIndex:0] storeItemFrmName] numberOfFrames:1]];
    
    ownedTag.visible = [[itemsToShow objectAtIndex:0] ownedBandItem];
    
    [buyMenu setVisible:![[itemsToShow objectAtIndex:0] ownedBandItem]];
    [selectMenu setVisible:[[itemsToShow objectAtIndex:0] ownedBandItem]];
    
    [storeSprite setPosition:storeSpritePosition];
    [storeSprite setScale:1.5];
    
    [bandBuy addChild:storeSprite];
    [self updateText:[itemsToShow objectAtIndex:0]];
}

-(void)doShowDrummer:(CCButton *)menuItem
{
    [bandBuy removeChild:storeSprite cleanup:YES];
    
    itemCount = 0;
    
    NSLog(@"Do show drummer");
    
    BandStoreItemsCtrl *itemsCtrl = [BandStoreItemsCtrl sharedInstance];
    itemsToShow = [itemsCtrl drummers];
    
    storeSprite = [[CCSprite alloc] init];
    
    [storeSprite runAction:[self loadSpriteAnimation:[[itemsToShow objectAtIndex:0] storeItemFrmName] numberOfFrames:1]];
    
    ownedTag.visible = [[itemsToShow objectAtIndex:0] ownedBandItem];
    
    [buyMenu setVisible:![[itemsToShow objectAtIndex:0] ownedBandItem]];
    [selectMenu setVisible:[[itemsToShow objectAtIndex:0] ownedBandItem]];
    
    [storeSprite setPosition:storeSpritePosition];
    //[storeSprite setScale:1.5];
    
    [bandBuy addChild:storeSprite];
    
    [self updateText:[itemsToShow objectAtIndex:0]];

}

-(void)doShowBass:(CCButton *)menuItem;
{

    [bandBuy removeChild:storeSprite cleanup:YES];
    
    itemCount = 0;
    
    NSLog(@"Do show BASS");
    
    BandStoreItemsCtrl *itemsCtrl = [BandStoreItemsCtrl sharedInstance];
    itemsToShow = [itemsCtrl basses];
    
    storeSprite = [[CCSprite alloc] init];
    
    [self loadSpriteAnimation:[[itemsToShow objectAtIndex:0] storeItemFrmName] numberOfFrames:0];
    
    [storeSprite runAction:[self loadSpriteAnimation:[[itemsToShow objectAtIndex:0] storeItemFrmName] numberOfFrames:1]];
    
    ownedTag.visible = [[itemsToShow objectAtIndex:0] ownedBandItem];
    
    [buyMenu setVisible:![[itemsToShow objectAtIndex:0] ownedBandItem]];
    [selectMenu setVisible:[[itemsToShow objectAtIndex:0] ownedBandItem]];
    
    [storeSprite setPosition:storeSpritePosition];
    [storeSprite setScale:1.5];
    
    [bandBuy addChild:storeSprite];
    [self updateText:[itemsToShow objectAtIndex:0]];
    
}

-(CCAction *)loadSpriteAnimation:(NSString *)frameName numberOfFrames:(int)frames
{
    NSString *itemFrame = [frameName stringByAppendingString:@"%d.png"];
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 1; i <= frames; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:itemFrame,i]];
        [animFrames addObject:frame];
    }
    CCAnimation *animation = [CCAnimation animationWithSpriteFrames:animFrames delay:0.2f];
    CCAction *itemAction = [CCActionRepeatForever actionWithAction:
                            [CCActionAnimate actionWithAnimation:animation]];
    return itemAction;
}

-(void)updateText:(BandStoreItemsCtrl *)itemsCtrl
{
    [bandBuy removeChild:itemLabel cleanup:YES];
    [bandBuy removeChild:itemPrice cleanup:YES];
    [bandBuy removeChild:itemArmor cleanup:YES];
    [bandBuy removeChild:itemDamage cleanup:YES];
    
    
    // band component max name chars is 20
    itemLabel = [CCLabelTTF labelWithString:[[itemsToShow objectAtIndex:itemCount] itemName] fontName:@"28DaysLater" fontSize:50 dimensions:CGSizeMake(470, 390)];
    
    itemArmor = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Armor %@",[[[NSNumber alloc] initWithInt:[[itemsToShow objectAtIndex:itemCount] armor]] stringValue]] fontName:@"28DaysLater" fontSize:43 dimensions:CGSizeMake(470, 200)];
    
    itemDamage = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Damage %@",[[[NSNumber alloc] initWithInt:[[itemsToShow objectAtIndex:itemCount] shootPower]] stringValue]] fontName:@"28DaysLater" fontSize:43 dimensions:CGSizeMake(470, 200)];
    
    itemPrice = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Cost %@",[[[NSNumber alloc] initWithInt:[[itemsToShow objectAtIndex:itemCount] credits]] stringValue]] fontName:@"28DaysLater" fontSize:43  dimensions:CGSizeMake(470, 200)];
    
    [itemLabel setPosition:ccp(240,350)];
    [itemArmor setPosition:ccp(140,340)];
    [itemPrice setPosition:ccp(140,240)];
    [itemDamage setPosition:ccp(140,290)];
    
    [bandBuy addChild:itemLabel];
    [bandBuy addChild:itemPrice];
    [bandBuy addChild:itemArmor];
    [bandBuy addChild:itemDamage];
}


@end
