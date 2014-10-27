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
    CCButton *buyMenu;
    CCButton *selectMenu;
    CCSprite *bandBuy;
    id delegate;
}

@property (nonatomic, retain) NSMutableArray *itemsToShow;
@property (nonatomic, retain) CCButton *buyMenu;
@property (nonatomic, retain) CCButton *selectMenu;
@property (nonatomic, retain) CCSprite *bandBuy;
@property (nonatomic, retain) id delegate;

-(void)doScrRigh:(CCButton *)menuItem;
-(void)doScrLeft:(CCButton *)menuItem;
-(void)doShowGuitarrist;
-(void)doShowVocalist:(CCButton *)menuItem;
-(void)doShowDrummer:(CCButton *)menuItem;
-(void)doShowBass:(CCButton *)menuItem;


@end
