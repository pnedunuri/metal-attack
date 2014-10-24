//
//  GameStoreObserver.h
//  EightbitShooter
//
//  Created by Rafael Munhoz on 06/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import "BandStoreItemsCtrl.h"
#import "BandStoreItem.h"
#import "BandVault.h"
#import "BandStore.h"


@interface GameStoreObserver : NSObject <SKPaymentTransactionObserver>

{
    id uiDelegate;
}

@property (retain, nonatomic) id uiDelegate;

+(id)sharedInstance;

@end
