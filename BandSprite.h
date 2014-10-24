//
//  BandSprite.h
//  EightbitShooter
//
//  Created by Rafael Munhoz on 12/03/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BandVault.h"
#import "BandStoreItemsCtrl.h"

typedef enum {
    GUITARRIST1_TYPE,
    GUITARRIST2_TYPE,
    BASS_TYPE,
    VOCALS_TYPE,
    DRUMMER_TYPE
} BandComponents;

@interface BandSprite : CCSprite
{
    //All shoots from the band will be inside this array to be
    //analysed for colision
    NSMutableArray *activeShoots;
    
    // how many points left from the armor, this will be provided by the drummer type
    float drummerArmor;
    float guitar1Armor;
    float guitar2Armor;
    float vocalArmor;
    float bassArmor;
    
    float totalDrummerArmor;
    float totalGuitar1Armor;
    float totalGuitar2Armor;
    float totalVocalArmor;
    float totalBassArmor;
    
    // Time of weapon cooldown this can be varied for the band members,
    // lets 3 variables one for the guitar1, guitar2 and bass, this
    // configuration will came from the store.
    BOOL guita1ReleaseFire;
    BOOL guita2ReleaseFire;
    BOOL bassReleaseFire;
    BOOL vocalReleaseFire;
    
    BOOL isGuita1Death;
    BOOL isGuita2Death;
    BOOL isBassDeath;
    BOOL isDrummerDeath;
    BOOL isVocalDeath;
    
    //I will keep this as an example but in the future it will be replaced
    CCParticleSystem *bandParticle;
    CCParticleSystem *bandParticleBlaster;
    
    //I will create one for each damage band component, all of this will be retreived
    //from the vault
    float guitar1ShootPower;
    float guitar2ShootPower;
    float bassShootPower;
    float vocalsShootPower;
    float shootPower;
    
    int bandBlast;
    
    id delegate;
    
    //Animations and Sprites of the band, it is not necessary to have all the integrants
    //of the band. The necessary are the Drummer, The vocal and at least one guitar.
    
    //Drummer
    CCAction *drummerAnim;
    CCSprite *drummerSprite;
    
    //Guitarrist 1 body and guitar anim/sprite
    CCAction *gtBody1Anim;
    CCSprite *gtBody1Sprite;
    CCAction *guitar1Anim;
    CCSprite *guitar1Sprite;
    CCAction *guitar1ShootAnim;
    
    //Guitarrist 1 position attributes
    int guita1_weaponLeftx;
    int guita1_weaponRightx;
    int guita1_weaponyRight;
    int guita1_weaponyLeft;
    float guita1_anchorRightX;
    float guita1_anchorRightY;
    float guita1_anchorLeftX;
    float guita1_anchorLeftY;
    
    //Guitarrist 2 body and guitar anim/sprite
    CCAction *gtBody2Anim;
    CCSprite *gtBody2Sprite;
    CCAction *guitar2Anim;
    CCSprite *guitar2Sprite;
    CCAction *guitar2ShootAnim;
    
    //Guitarrist 2 position attributes
    int guita2_weaponLeftx;
    int guita2_weaponRightx;
    int guita2_weaponyRight;
    int guita2_weaponyLeft;
    float guita2_anchorRightX;
    float guita2_anchorRightY;
    float guita2_anchorLeftX;
    float guita2_anchorLeftY;

    //Bassman and Bass anim/sprite
    CCAction *bassBodyAnim;
    CCSprite *bassBodySprite;
    CCAction *bassAnim;
    CCSprite *bassSprite;
    CCAction *bassShootAnim;
    
    //Bassman 2 position attributes
    int bass_weaponLeftx;
    int bass_weaponRightx;
    int bass_weaponyRight;
    int bass_weaponyLeft;
    float bass_anchorRightX;
    float bass_anchorRightY;
    float bass_anchorLeftX;
    float bass_anchorLeftY;
    
    //Vocalist upper and lower body anim/sprite
    CCAction *vocalUpBodyAnim;
    CCSprite *vocalUpBodySprite;
    CCAction *vocalLwBodyAnim;
    CCSprite *vocalLwBodySprite;
    CCAction *vocalShootAnim;
    
    //Vocal position attributes
    int vocal_weaponLeftx;
    int vocal_weaponRightx;
    int vocal_weaponyRight;
    int vocal_weaponyLeft;
    float vocal_anchorRightX;
    float vocal_anchorRightY;
    float vocal_anchorLeftX;
    float vocal_anchorLeftY;

    int bandCoins;
    
}

@property (nonatomic,retain) NSMutableArray *activeShoots;
@property (nonatomic) BOOL guita1ReleaseFire;
@property (nonatomic) BOOL guita2ReleaseFire;
@property (nonatomic) BOOL bassReleaseFire;
@property (nonatomic) BOOL vocalReleaseFire;

@property (nonatomic) float drummerArmor;
@property (nonatomic) float guitar1Armor;
@property (nonatomic) float guitar2Armor;
@property (nonatomic) float vocalArmor;
@property (nonatomic) float bassArmor;

@property (nonatomic, retain) CCParticleSystem *bandParticle;
@property (nonatomic, retain) CCParticleSystem *bandParticleBlaster;

@property (nonatomic, retain) id delegate;

@property (nonatomic) float guitar1ShootPower;
@property (nonatomic) float guitar2ShootPower;
@property (nonatomic) float bassShootPower;
@property (nonatomic) float vocalsShootPower;
@property (nonatomic) float shootPower; // Total shoot power, it will be replaced

@property (nonatomic) int bandBlast;

@property (nonatomic) BOOL isGuita1Death;
@property (nonatomic) BOOL isGuita2Death;
@property (nonatomic) BOOL isBassDeath;
@property (nonatomic) BOOL isDrummerDeath;
@property (nonatomic) BOOL isVocalDeath;

@property (nonatomic,retain) CCAction *drummerAnim;
@property (nonatomic,retain) CCAction *drummerHitAnim;
@property (nonatomic,retain) CCAction *drummerDeathAnim;
@property (nonatomic,retain) CCSprite *drummerSprite;

@property (nonatomic,retain) CCAction *gtBody1Anim;
@property (nonatomic,retain) CCAction *gt1HitAnim;
@property (nonatomic,retain) CCAction *gt1DeathAnim;
@property (nonatomic,retain) CCSprite *gtBody1Sprite;
@property (nonatomic,retain) CCAction *guitar1Anim;
@property (nonatomic,retain) CCSprite *guitar1Sprite;
@property (nonatomic,retain) CCAction *guitar1ShootAnim;
@property (nonatomic) int guita1_weaponLeftx;
@property (nonatomic) int guita1_weaponRightx;
@property (nonatomic) int guita1_weaponyRight;
@property (nonatomic) int guita1_weaponyLeft;
@property (nonatomic) float guita1_anchorRightX;
@property (nonatomic) float guita1_anchorRightY;
@property (nonatomic) float guita1_anchorLeftX;
@property (nonatomic) float guita1_anchorLeftY;

@property (nonatomic,retain) CCAction *gtBody2Anim;
@property (nonatomic,retain) CCAction *gt2HitAnim;
@property (nonatomic,retain) CCAction *gt2DeathAnim;
@property (nonatomic,retain) CCSprite *gtBody2Sprite;
@property (nonatomic,retain) CCAction *guitar2Anim;
@property (nonatomic,retain) CCSprite *guitar2Sprite;
@property (nonatomic,retain) CCAction *guitar2ShootAnim;
@property (nonatomic) int guita2_weaponLeftx;
@property (nonatomic) int guita2_weaponRightx;
@property (nonatomic) int guita2_weaponyRight;
@property (nonatomic) int guita2_weaponyLeft;
@property (nonatomic) float guita2_anchorRightX;
@property (nonatomic) float guita2_anchorRightY;
@property (nonatomic) float guita2_anchorLeftX;
@property (nonatomic) float guita2_anchorLeftY;

@property (nonatomic,retain) CCAction *bassBodyAnim;
@property (nonatomic,retain) CCAction *bassHitAnim;
@property (nonatomic,retain) CCAction *bassDeathAnim;
@property (nonatomic,retain) CCSprite *bassBodySprite;
@property (nonatomic,retain) CCAction *bassAnim;
@property (nonatomic,retain) CCSprite *bassSprite;
@property (nonatomic,retain) CCAction *bassShootAnim;
@property (nonatomic) int bass_weaponLeftx;
@property (nonatomic) int bass_weaponRightx;
@property (nonatomic) int bass_weaponyRight;
@property (nonatomic) int bass_weaponyLeft;
@property (nonatomic) float bass_anchorRightX;
@property (nonatomic) float bass_anchorRightY;
@property (nonatomic) float bass_anchorLeftX;
@property (nonatomic) float bass_anchorLeftY;

@property (nonatomic,retain) CCAction *vocalUpBodyAnim;
@property (nonatomic,retain) CCAction *vocalHitAnim;
@property (nonatomic,retain) CCAction *vocalDeathAnim;
@property (nonatomic,retain) CCSprite *vocalUpBodySprite;
@property (nonatomic,retain) CCAction *vocalLwBodyAnim;
@property (nonatomic,retain) CCSprite *vocalLwBodySprite;
@property (nonatomic,retain) CCAction *vocalShootAnim;
@property (nonatomic) int vocal_weaponLeftx;
@property (nonatomic) int vocal_weaponRightx;
@property (nonatomic) int vocal_weaponyRight;
@property (nonatomic) int vocal_weaponyLeft;
@property (nonatomic) float vocal_anchorRightX;
@property (nonatomic) float vocal_anchorRightY;
@property (nonatomic) float vocal_anchorLeftX;
@property (nonatomic) float vocal_anchorLeftY;

@property (nonatomic) int bandCoins;

@property (nonatomic) float totalDrummerArmor;
@property (nonatomic) float totalGuitar1Armor;
@property (nonatomic) float totalGuitar2Armor;
@property (nonatomic) float totalVocalArmor;
@property (nonatomic) float totalBassArmor;

-(id)initBand;
-(void)performBandDeath;
-(void)hitByEnemy:(float)damagePoints;
-(float)hitByEnemy:(float)damagePoints component:(BandComponents)type rect:(CGRect )collrect;
-(void)performBandBlast;
-(void)receiveHealthPowerUp:(float)value;
-(void)runShootAnimation;
-(float)getTotalArmor;

@end


