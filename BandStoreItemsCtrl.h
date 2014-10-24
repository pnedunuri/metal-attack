//
//  ███╗   ███╗███████╗████████╗ █████╗ ██╗          █████╗ ████████╗████████╗ █████╗  ██████╗██╗  ██╗
//  ████╗ ████║██╔════╝╚══██╔══╝██╔══██╗██║         ██╔══██╗╚══██╔══╝╚══██╔══╝██╔══██╗██╔════╝██║ ██╔╝
//  ██╔████╔██║█████╗     ██║   ███████║██║         ███████║   ██║      ██║   ███████║██║     █████╔╝
//  ██║╚██╔╝██║██╔══╝     ██║   ██╔══██║██║         ██╔══██║   ██║      ██║   ██╔══██║██║     ██╔═██╗
//  ██║ ╚═╝ ██║███████╗   ██║   ██║  ██║███████╗    ██║  ██║   ██║      ██║   ██║  ██║╚██████╗██║  ██╗
//  ╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝    ╚═╝  ╚═╝   ╚═╝      ╚═╝   ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
//
//
//  BandStoreItemsCtrl.h
//  EightbitShooter
//
//  Created by Rafael Munhoz on 03/04/13.
//
//

#import <Foundation/Foundation.h>
#import "BandStoreItem.h"
#import "JSON.h"

@interface BandStoreItemsCtrl : NSObject

{
    NSDictionary *itemsDict;
    NSMutableArray *drummers;
    NSMutableArray *guitarrists;
    // include another array to store the guitarrists2
    NSMutableArray *vocals;
    NSMutableArray *basses;
    NSMutableArray *coinpacks;
    NSMutableArray *generalItems;
    int bandCoins;
}

@property (nonatomic, retain) NSDictionary *itemsDict;
@property (nonatomic, retain) NSMutableArray *drummers;
@property (nonatomic, retain) NSMutableArray *guitarrists;
@property (nonatomic, retain) NSMutableArray *vocals;
@property (nonatomic, retain) NSMutableArray *basses;
@property (nonatomic, retain) NSMutableArray *coinpacks;
@property (nonatomic, retain) NSMutableArray *generalItems;
@property (nonatomic) int bandCoins;

+(id)sharedInstance;
-(void)loadBandItemsFromJson;
-(void)consumeItem:(BandStoreItem *)item;
-(void)storeItem:(BandStoreItem *)item;
-(void)selectItem:(BandStoreItem *)item;

@end
