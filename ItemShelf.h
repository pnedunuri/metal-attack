//
//  ItemShelf.h
//  EightbitShooter
//
//  Created by Rafael Munhoz on 03/10/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "cocos2d.h"

@interface ItemShelf : CCNodeColor <SKProductsRequestDelegate>
{
    NSArray *shelfItems;
}

@property (nonatomic,retain) NSArray *shelfItems;

    
-(id)initWithItems:(NSArray *)allItems coinsLabel:(CCLabelTTF*)coinsLabel range:(NSRange)itemsRange;

@end
