//
//  BandBuyPoster.h
//  EightbitShooter
//
//  Created by Rafael Munhoz on 08/10/14.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface BandBuyPoster : NSObject
{
    NSMutableArray *itemsToShow;
    CCMenu *buyMenu;
    CCMenu *selectMenu;
    CCSprite *bandBuy;
    id delegate;
}

@property (nonatomic, retain) NSMutableArray *itemsToShow;
@property (nonatomic, retain) CCMenu *buyMenu;
@property (nonatomic, retain) CCMenu *selectMenu;
@property (nonatomic, retain) CCSprite *bandBuy;
@property (nonatomic, retain) id delegate;

-(void)doScrRigh:(CCMenuItem *)menuItem;
-(void)doScrLeft:(CCMenuItem *)menuItem;
-(void)doShowGuitarrist;
-(void)doShowVocalist:(CCMenuItem *)menuItem;
-(void)doShowDrummer:(CCMenuItem *)menuItem;
-(void)doShowBass:(CCMenuItem *)menuItem;


@end
