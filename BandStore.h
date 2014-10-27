//
//  BandStore.h
//  EightbitShooter
//
//  Created by Rafael Munhoz on 08/04/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MainMenu.h"
#import "GameStoreObserver.h"
#import <StoreKit/StoreKit.h>

@interface BandStore : CCNode <SKProductsRequestDelegate>

{
    CCLabelTTF *labelCredits;
}

@property (retain, nonatomic) CCLabelTTF *labelCredits;

+(CCScene *) scene;

@end
