//
//  ███╗   ███╗███████╗████████╗ █████╗ ██╗          █████╗ ████████╗████████╗ █████╗  ██████╗██╗  ██╗
//  ████╗ ████║██╔════╝╚══██╔══╝██╔══██╗██║         ██╔══██╗╚══██╔══╝╚══██╔══╝██╔══██╗██╔════╝██║ ██╔╝
//  ██╔████╔██║█████╗     ██║   ███████║██║         ███████║   ██║      ██║   ███████║██║     █████╔╝
//  ██║╚██╔╝██║██╔══╝     ██║   ██╔══██║██║         ██╔══██║   ██║      ██║   ██╔══██║██║     ██╔═██╗
//  ██║ ╚═╝ ██║███████╗   ██║   ██║  ██║███████╗    ██║  ██║   ██║      ██║   ██║  ██║╚██████╗██║  ██╗
//  ╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝    ╚═╝  ╚═╝   ╚═╝      ╚═╝   ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
//
//  ItemShelfCtrl.m
//  EightbitShooter
//
//  Created by Rafael Munhoz on 03/10/14.
//  This class will control the an array of item shelfs
//

#import "ItemShelfCtrl.h"
#import "cocos2d.h"
#import "ItemShelf.h"
#import "BandStoreItemsCtrl.h"

@implementation ItemShelfCtrl

NSMutableArray *allItems;
NSMutableArray *itemShelfs;
NSSortDescriptor *sort;
ItemShelf *shelf;
int currentShelf;

-(void)showNextItemShelf
{
    NSLog(@"Draw next item Shelf");
}

-(void)doNext:(CCMenuItem *)menuitem
{
    NSLog(@"Current shelf %d",currentShelf);
    // show multiples of 5 items
    
    [self removeChild:[itemShelfs objectAtIndex:currentShelf] cleanup:YES];
    // Run animation sequence  !!!
    if (currentShelf + 1 == [itemShelfs count]) {
        currentShelf = 0;
    }else{
        currentShelf++;
    }
    
    [self addChild:[itemShelfs objectAtIndex:currentShelf]];
}

-(id)initwithCoinLabel:(CCLabelTTF*)coinLabel;
{
    if( (self=[super initWithColor:ccc4(0, 0, 0, 0)])) {
        // create the itemshelf that represents the first 5
        // items and add it to this layer
        currentShelf = 0;
        sort = [NSSortDescriptor sortDescriptorWithKey:@"appStoreId" ascending:YES];
        itemShelfs = [[NSMutableArray alloc] init];
        allItems = [NSMutableArray arrayWithArray:[[BandStoreItemsCtrl sharedInstance] generalItems]];
        [allItems addObjectsFromArray:[[BandStoreItemsCtrl sharedInstance] coinpacks]];
        allItems = [[NSMutableArray alloc] initWithArray:[allItems sortedArrayUsingDescriptors:@[sort]]];
        
        CCSprite *shelfs = [[CCSprite alloc] initWithFile:@"shelfs.png"];
        [shelfs setPosition:ccp(480, 250)];
        [shelfs setScale:0.5];
        
        for (int i = 0 ; i < [allItems count] /5; i++) {
            shelf = [[ItemShelf alloc] initWithItems:allItems coinsLabel:coinLabel range:NSMakeRange(5*i, 5)];
            [shelf setTag:i];
            [itemShelfs addObject:shelf];
        }
    
        CCMenuItemImage *nextButton = [CCMenuItemImage itemFromNormalImage:@"moreItemsClosed.png"
                                                             selectedImage: @"moreItensOPENED.png"
                                                                    target:self
                                                                  selector:@selector(doNext:)];
        
        [nextButton setScale:0.5];
        CCMenu *nextMenu = [CCMenu menuWithItems:nextButton, nil];
        [nextMenu setPosition:ccp(600,500)];
        [self addChild:shelfs];
        [self addChild:nextMenu];
        [self addChild:[itemShelfs firstObject]];
    }
    return self;
}

@end
