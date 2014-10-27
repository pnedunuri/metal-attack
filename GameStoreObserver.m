//
//  GameStoreObserver.m
//  EightbitShooter
//
//  Created by Rafael Munhoz on 06/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameStoreObserver.h"

@implementation GameStoreObserver

@synthesize uiDelegate;

+(id)sharedInstance
{
	//Singleton Implementation
    static id master = nil;
	
	@synchronized(self)
	{
		if (master == nil){
            master = [self new];
        }
	}
    return master;
}

-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{ 
    NSLog(@"Payment Queue %d",[transactions count]);
    
    
    
    SKPaymentTransaction *storeTransaction = [transactions objectAtIndex:0];
    
    switch (storeTransaction.transactionState) {
        case SKPaymentTransactionStatePurchased:{
            NSLog(@"Item Purchased !");
            [[SKPaymentQueue defaultQueue] finishTransaction:storeTransaction];            
            NSLog(@"Transaction product id %@",[[storeTransaction payment] productIdentifier]);
            
            
            BandStoreItemsCtrl *itemsCtrl = [BandStoreItemsCtrl sharedInstance];
            BandStoreItem *coinPack = [[itemsCtrl itemsDict] valueForKey:[[storeTransaction payment] productIdentifier]];
            
            BandVault *vault = [BandVault sharedInstance];
            
            vault.bandCoins = vault.bandCoins + [coinPack value];
            
            NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
            
            [userdef setInteger:vault.bandCoins forKey:@"coins"];
            
            NSNumber *numberOfCoins = [[NSNumber alloc] initWithInt:[vault bandCoins]];
            
            [[(BandStore *)[self uiDelegate] labelCredits] setString:[numberOfCoins stringValue]];
        }
            break;
        case SKPaymentTransactionStateFailed:{
            NSLog(@"Item Purchase Failed !");
            [[SKPaymentQueue defaultQueue] finishTransaction:storeTransaction];
        }
            break;
        case SKPaymentTransactionStatePurchasing:{
            NSLog(@"Purchasing");
        }
            break;
        case SKPaymentTransactionStateRestored:{
            NSLog(@"Restored");
        }
            break;
        default:
            break;
    }
    
    /*
    SKPaymentQueue *paymentQueue = [SKPaymentQueue defaultQueue];
    [paymentQueue finishTransaction:storeTransaction];
    [paymentQueue removeTransactionObserver:self];
    */
     
}

@end
