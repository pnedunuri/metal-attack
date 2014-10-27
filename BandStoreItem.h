//
//  ███╗   ███╗███████╗████████╗ █████╗ ██╗          █████╗ ████████╗████████╗ █████╗  ██████╗██╗  ██╗
//  ████╗ ████║██╔════╝╚══██╔══╝██╔══██╗██║         ██╔══██╗╚══██╔══╝╚══██╔══╝██╔══██╗██╔════╝██║ ██╔╝
//  ██╔████╔██║█████╗     ██║   ███████║██║         ███████║   ██║      ██║   ███████║██║     █████╔╝
//  ██║╚██╔╝██║██╔══╝     ██║   ██╔══██║██║         ██╔══██║   ██║      ██║   ██╔══██║██║     ██╔═██╗
//  ██║ ╚═╝ ██║███████╗   ██║   ██║  ██║███████╗    ██║  ██║   ██║      ██║   ██║  ██║╚██████╗██║  ██╗
//  ╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝    ╚═╝  ╚═╝   ╚═╝      ╚═╝   ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
//
//
//  BandStoreItem.h
//  EightbitShooter
//
//  Created by Rafael Munhoz on 03/04/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum {
    DRUMMER,
    GUITARRIST_1,
    GUITARRIST_2,
    VOCALIST,
    BASSGUY,
    BAND_COIN_PACK,
    BAND_SKIN,
    GENERIC_ITEM
} BandItemType;

@interface BandStoreItem : NSObject

{
    // it will be used inside the game as key for the item.
    NSString *appStoreId;
    // Name of the item to be showed on at the game store
    NSString *itemName;
    // Price of the item in game credits
    int credits;
    // points of the item that will affect the game play, lets say for a weapon power up
    // how many shoot points it will add the same for armor.
    int value;
    // how many levels the item will be avaliable.
    int duration;
    // the type of the item, it can be ARMMOR, GUN, COIN_PACK or SKIN
    BandItemType itemType;
    // fantasy description of the item.
    NSString *description;
    // Name of the file that represents the item. Each item will have a 2 frames
    // animation. The name of the asset shall fowllow the patter:
    // body1_frm, where body1 indentify the type of the item and
    // frm is the frame
    NSString *assetName;
    // flag to show if the item is owned or not
    bool ownedBandItem;
    // flag that indicates if the item is selected
    bool selectedBandItem;
    // this attribute represents how much of the item the user has
    int qtd;
    // sprite that represents the item
    CCSprite *itemSprt;
    // frame name
    NSString *itemFrmName;
    // name of the frames to be used on the store
    NSString *storeItemFrmName;
    // name of the frames of the moving arm, bass, guitar, vocal upper
    NSString *itemArmFrmName;
    // number of animation frames
    int itemframes;
    // position on x-axis of the weapon whe the caracter is fliped left
    int weaponleftx;
    // position on x-axis of the weapon whe the caracter is fliped right
    int weaponrightx;
    // position on y-axis of the weapon whe the caracter is fliped right
    int weaponrighty;
    // position on y-axis of the weapon whe the caracter is fliped left
    int weaponlefty;
    // position on x-axis of the weapon whe the caracter is fliped left ipad
    int weaponleftxipad;
    // position on x-axis of the weapon whe the caracter is fliped right ipad    
    int weaponrightxipad;
    // position on y-axis of the weapon whe the caracter is fliped right ipad
    int weaponrightyipad;
    // position on y-axis of the weapon whe the caracter is fliped left ipad
    int weaponleftyipad;
    // rotation anchor point when caracter if fliped right for x-axis
    float anchorrightx;
    // rotation anchor point when caracter is fliped right for y-axis
    float anchorrighty;
    // rotation anchor point when caracter is fliped left for x-axis
    float anchorleftx;
    // rotation anchor point when caracter is fliped left for y-axis
    float anchorlefty;
    // arm size
    CGPoint armsize;
    // armor of the item valid only for the band guys
    float armor;
    // shoot power valid for all guys from the band exluding the drummer
    float shootPower;
    
}

@property (nonatomic,retain) NSString *appStoreId;
@property (nonatomic,retain) NSString *itemName;
@property (nonatomic) int credits;
@property (nonatomic) int value;
@property (nonatomic) BandItemType itemType;
@property (nonatomic, retain) NSString *description;
@property (nonatomic) int duration;
@property (nonatomic, retain) NSString *assetName;
@property (nonatomic) bool ownedBandItem;
@property (nonatomic) bool selectedBandItem;
@property (nonatomic) int qtd;
@property (nonatomic,retain) CCSprite *itemSprt;
@property (nonatomic,retain) NSString *itemFrmName;
@property (nonatomic) int itemframes;
@property (nonatomic,retain) NSString *storeItemFrmName;
@property (nonatomic,retain) NSString *itemArmFrmName;

@property (nonatomic) int weaponleftx;
@property (nonatomic) int weaponrightx;
@property (nonatomic) int weaponrighty;
@property (nonatomic) int weaponlefty;

@property (nonatomic) int weaponleftxipad;
@property (nonatomic) int weaponrightxipad;
@property (nonatomic) int weaponrightyipad;
@property (nonatomic) int weaponleftyipad;

@property (nonatomic) float anchorrightx;
@property (nonatomic) float anchorrighty;
@property (nonatomic) float anchorleftx;
@property (nonatomic) float anchorlefty;

@property (nonatomic) CGPoint armsize;

@property (nonatomic) float armor;
@property (nonatomic) float shootPower;

@end
