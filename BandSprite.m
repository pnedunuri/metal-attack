//
//  BandSprite.m
//  EightbitShooter
//
//  Created by Rafael Munhoz on 12/03/13.
//
//  All band guys position are oriented by the center of the screen

#import "BandSprite.h"
#import "UniversalInfo.h"

@implementation BandSprite

@synthesize activeShoots;
@synthesize guita1ReleaseFire;
@synthesize guita2ReleaseFire;
@synthesize bassReleaseFire;
@synthesize vocalReleaseFire;

@synthesize drummerArmor;
@synthesize guitar1Armor;
@synthesize guitar2Armor;   
@synthesize bassArmor;
@synthesize vocalArmor;

@synthesize bandParticle;
@synthesize bandParticleBlaster;

@synthesize delegate;

@synthesize guitar1ShootPower;
@synthesize guitar2ShootPower;
@synthesize bassShootPower;
@synthesize vocalsShootPower;
@synthesize shootPower;

@synthesize bandBlast;

@synthesize drummerAnim;
@synthesize drummerSprite;
@synthesize drummerHitAnim;
@synthesize drummerDeathAnim;

@synthesize gtBody1Anim;
@synthesize gt1HitAnim;
@synthesize gt1DeathAnim;
@synthesize gtBody1Sprite;
@synthesize guitar1Anim;
@synthesize guitar1Sprite;
@synthesize guitar1ShootAnim;

@synthesize gtBody2Anim;
@synthesize gt2HitAnim;
@synthesize gt2DeathAnim;
@synthesize gtBody2Sprite;
@synthesize guitar2Anim;
@synthesize guitar2Sprite;
@synthesize guitar2ShootAnim;

@synthesize bassBodyAnim;
@synthesize bassHitAnim;
@synthesize bassDeathAnim;
@synthesize bassBodySprite;
@synthesize bassAnim;
@synthesize bassSprite;
@synthesize bassShootAnim;

@synthesize vocalUpBodyAnim;
@synthesize vocalHitAnim;
@synthesize vocalDeathAnim;
@synthesize vocalUpBodySprite;
@synthesize vocalLwBodyAnim;
@synthesize vocalLwBodySprite;
@synthesize vocalShootAnim;

@synthesize isBassDeath;
@synthesize isGuita1Death;
@synthesize isGuita2Death;
@synthesize isVocalDeath;
@synthesize isDrummerDeath;

@synthesize guita1_weaponLeftx;
@synthesize guita1_weaponRightx;
@synthesize guita1_weaponyLeft;
@synthesize guita1_weaponyRight;
@synthesize guita1_anchorLeftY;
@synthesize guita1_anchorLeftX;
@synthesize guita1_anchorRightY;
@synthesize guita1_anchorRightX;

@synthesize guita2_weaponLeftx;
@synthesize guita2_weaponRightx;
@synthesize guita2_weaponyLeft;
@synthesize guita2_weaponyRight;
@synthesize guita2_anchorLeftY;
@synthesize guita2_anchorLeftX;
@synthesize guita2_anchorRightY;
@synthesize guita2_anchorRightX;

@synthesize bass_weaponLeftx;
@synthesize bass_weaponRightx;
@synthesize bass_weaponyLeft;
@synthesize bass_weaponyRight;
@synthesize bass_anchorLeftY;
@synthesize bass_anchorLeftX;
@synthesize bass_anchorRightY;
@synthesize bass_anchorRightX;

@synthesize vocal_weaponLeftx;
@synthesize vocal_weaponRightx;
@synthesize vocal_weaponyLeft;
@synthesize vocal_weaponyRight;
@synthesize vocal_anchorLeftY;
@synthesize vocal_anchorLeftX;
@synthesize vocal_anchorRightY;
@synthesize vocal_anchorRightX;

@synthesize bandCoins;
@synthesize totalDrummerArmor;
@synthesize totalBassArmor;
@synthesize totalGuitar1Armor;
@synthesize totalGuitar2Armor;
@synthesize totalVocalArmor;

const float SPRITE_SCALE_FACTOR = 0.55;

/**
 * Pivot calculation method
 * ========================
 *
 * Guitar/Bass
 * Assuming that the hand of the instrument points to right ( this is default )
 * 
 * Right Pivot:
 * Use Gimp or other editor and flip the image on horizontal axis (x), after that
 * fetch the pivot point x and y.
 *
 * Left Pivot:
 * Use Gimp or other editor and flip the image on vertical axis (y), and on 
 * horizontal axis (x) after that fetch the pivot point x and y.
 *
 **/


-(CGPoint)calculateAnchorPoint:(CGPoint)anchorPos sizeSprite:(CGPoint)size
{
    return CGPointMake((1 - anchorPos.x/size.x), (1 - anchorPos.y/size.y));
}

//Band guys creation methods

-(void)createDrummer;
{
    self.drummerSprite = [[[CCSprite alloc] init] autorelease];
    NSMutableArray *animFrames = [NSMutableArray array];
    NSMutableArray *hitFrames = [NSMutableArray array];
    NSMutableArray *deathFrames = [NSMutableArray array];
    BandStoreItem *itemDrummer;
    //Store connection keep it commented until the store is ready
    
    BandStoreItemsCtrl *storeCtrl = [BandStoreItemsCtrl sharedInstance];
    BandVault *vault = [BandVault sharedInstance];
    
    NSString *itemFrame;
    NSString *hitFrmName;
    
    if (vault.drummerIndex > 0 ) {
        NSLog(@"Drummer not found ! %@",vault.drummerId);
        itemDrummer = [[storeCtrl drummers] objectAtIndex:0];
        itemFrame = [itemDrummer.itemFrmName stringByAppendingString:@"%d.png"];
        hitFrmName = [itemDrummer.itemFrmName stringByAppendingString:@"_hit%d.png"];
    }else{
        itemDrummer = [[storeCtrl drummers] objectAtIndex:vault.drummerIndex];
        itemFrame = [itemDrummer.itemFrmName stringByAppendingString:@"%d.png"];
        hitFrmName = [itemDrummer.itemFrmName stringByAppendingString:@"_hit%d.png"];
    }

    // normal state animation
    for(int i = 1; i <= itemDrummer.itemframes; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                spriteFrameByName:[NSString stringWithFormat:itemFrame,i]];
        [animFrames addObject:frame];
    }
    CCAnimation *animation = [CCAnimation animationWithFrames:animFrames delay:0.05f];
    self.drummerAnim = [[CCRepeatForever actionWithAction:
                         [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO]] retain];
    // hit animation
    for(int i = 1; i <= 2; i++) {
        CCSpriteFrame *hitframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:hitFrmName,i]];
        [hitFrames addObject:hitframe];
    }
    CCAnimation *hitanimation = [[CCAnimation animationWithFrames:hitFrames delay:0.15f] retain];
    id hit1anim = [CCAnimate actionWithAnimation: hitanimation];
    id hitcallback = [CCCallFuncN actionWithTarget:self selector: @selector(doEndDrummerHitAnim:)];
    self.drummerHitAnim = [CCSequence actions: hit1anim, hitcallback, nil];
    
    //death animation
    for(int i = 2; i <= 3; i++) {
        CCSpriteFrame *deathframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:hitFrmName,i]];
        [deathFrames addObject:deathframe];
    }
    
    CCAnimation *deathanimation = [[CCAnimation animationWithFrames:deathFrames delay:0.15f] retain];
    
    self.drummerDeathAnim = [[CCRepeat actionWithAction:
                              [CCAnimate actionWithAnimation:deathanimation restoreOriginalFrame:NO] times:1] retain];
    
    
    [[self drummerSprite] runAction:[self drummerAnim]];
    
    self.drummerSprite.scaleX = SPRITE_SCALE_FACTOR;
    self.drummerSprite.scaleY = SPRITE_SCALE_FACTOR;
    
    self.drummerSprite.position = [[UniversalInfo sharedInstance] drummerPosition];
    self.drummerArmor = itemDrummer.armor;
    self.totalDrummerArmor = itemDrummer.armor;
}

-(void)createGtBody1
{
    self.gtBody1Sprite = [[[CCSprite alloc] init] autorelease];
    NSMutableArray *animFrames = [NSMutableArray array];
    NSMutableArray *hitFrames = [NSMutableArray array];
    NSMutableArray *deathFrames = [NSMutableArray array];
    
    BandStoreItemsCtrl *storeCtrl = [BandStoreItemsCtrl sharedInstance];
    BandVault *vault = [BandVault sharedInstance];
    BandStoreItem *itemGuitar1;
    //Store connection keep it commented until the store is ready
    NSString *itemFrame;
    NSString *hitFrmName;
    
    if (vault.guitar1Index > 0) {
        NSLog(@"Guitar1 not found ! %@",vault.guitar1Id);
        itemGuitar1 = [[storeCtrl guitarrists] objectAtIndex:0];
        itemFrame = [itemGuitar1.itemFrmName stringByAppendingString:@"%d.png"];
        hitFrmName = [itemGuitar1.itemFrmName stringByAppendingString:@"_hit%d.png"];
    }else{
        itemGuitar1 = [[storeCtrl guitarrists] objectAtIndex:vault.guitar1Index];
        itemFrame = [itemGuitar1.itemFrmName stringByAppendingString:@"%d.png"];
        hitFrmName = [itemGuitar1.itemFrmName stringByAppendingString:@"_hit%d.png"];
    }
    
    // normal state animation
    for(int i = 1; i <= itemGuitar1.itemframes; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:itemFrame,i]];
        [animFrames addObject:frame];
    }
    CCAnimation *animation = [CCAnimation animationWithFrames:animFrames delay:0.10f];
    self.gtBody1Anim = [[CCRepeatForever actionWithAction:
                         [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO]] retain];
    
    // hit animation
    for(int i = 1; i <= 1; i++) {
        CCSpriteFrame *hitframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:hitFrmName,i]];
        [hitFrames addObject:hitframe];
    }
    
    CCAnimation *hitanimation = [[CCAnimation animationWithFrames:hitFrames delay:0.15f] retain];
    
    id hit1anim = [CCAnimate actionWithAnimation: hitanimation];
    id hitcallback = [CCCallFuncN actionWithTarget:self selector: @selector(doEndGuita1Anim:)];
    self.gt1HitAnim = [CCSequence actions: hit1anim, hitcallback, nil];
    
    
    // death animation
    for(int i = 1; i <= 3; i++) {
        CCSpriteFrame *deathframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:hitFrmName,i]];
        [deathFrames addObject:deathframe];
    }
    
    CCAnimation *deathanimation = [[CCAnimation animationWithFrames:deathFrames delay:0.15f] retain];
    
    self.gt1DeathAnim = [[CCRepeat actionWithAction:
                          [CCAnimate actionWithAnimation:deathanimation restoreOriginalFrame:NO] times:1] retain];
    
    [[self gtBody1Sprite] runAction:[self gtBody1Anim]];
    
    self.gtBody1Sprite.scaleX = SPRITE_SCALE_FACTOR;
    self.gtBody1Sprite.scaleY = SPRITE_SCALE_FACTOR;
    self.gtBody1Sprite.position = [[UniversalInfo sharedInstance] guitarrist1Position];
    
    if ([[UniversalInfo sharedInstance] getDeviceType] == IPHONE_5) {
        self.guita1_weaponLeftx = self.gtBody1Sprite.position.x + itemGuitar1.weaponleftx;
        self.guita1_weaponRightx = self.gtBody1Sprite.position.x + itemGuitar1.weaponrightx;
        self.guita1_weaponyLeft = self.gtBody1Sprite.position.y + itemGuitar1.weaponlefty;
        self.guita1_weaponyRight = self.gtBody1Sprite.position.y + itemGuitar1.weaponrighty;
    
    }else{
        self.guita1_weaponLeftx = self.gtBody1Sprite.position.x + itemGuitar1.weaponleftxipad;
        self.guita1_weaponRightx = self.gtBody1Sprite.position.x + itemGuitar1.weaponrightxipad;
        self.guita1_weaponyLeft = self.gtBody1Sprite.position.y + itemGuitar1.weaponleftyipad;
        self.guita1_weaponyRight = self.gtBody1Sprite.position.y + itemGuitar1.weaponrightyipad;
    }
    
    self.guitar1Armor = itemGuitar1.armor;
    self.guitar1ShootPower = itemGuitar1.shootPower;
    self.totalGuitar1Armor = itemGuitar1.armor;
}

-(void)createBassPlayerBody
{
    
    self.bassBodySprite = [[[CCSprite alloc] init] autorelease];
    NSMutableArray *animFrames = [NSMutableArray array];
    NSMutableArray *hitFrames = [NSMutableArray array];
    NSMutableArray *deathFrames = [NSMutableArray array];
    
    BandStoreItem *itemBass;
    
    BandStoreItemsCtrl *storeCtrl = [BandStoreItemsCtrl sharedInstance];
    BandVault *vault = [BandVault sharedInstance];
    
    NSString *itemFrame;
    NSString *hitFrmName;
    
    if (vault.bassIndex > 0) {
        NSLog(@"Bass guy not found %@",vault.bassId);
        itemBass = [[storeCtrl basses] objectAtIndex:0];
        itemFrame = [itemBass.itemFrmName stringByAppendingString:@"%d.png"];
        hitFrmName = [itemBass.itemFrmName stringByAppendingString:@"_hit%d.png"];
        
    }else{
        itemBass = [[storeCtrl basses] objectAtIndex:vault.bassIndex];
        itemFrame = [itemBass.itemFrmName stringByAppendingString:@"%d.png"];
        hitFrmName = [itemBass.itemFrmName stringByAppendingString:@"_hit%d.png"];
    }
    
    // Normal animation
    for(int i = 1; i <= itemBass.itemframes; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:itemFrame,i]];
        [animFrames addObject:frame];
    }
    CCAnimation *animation = [CCAnimation animationWithFrames:animFrames delay:0.04f];
    self.bassBodyAnim = [[CCRepeatForever actionWithAction:
                          [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO]] retain];
    
    // hit animation
    for(int i = 1; i <= 1; i++) {
        CCSpriteFrame *hitframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:hitFrmName,i]];
        [hitFrames addObject:hitframe];
    }
    
    CCAnimation *hitanimation = [[CCAnimation animationWithFrames:hitFrames delay:0.15f] retain];
    
    id hit2anim = [CCAnimate actionWithAnimation: hitanimation];
    id hitcallback = [CCCallFuncN actionWithTarget:self selector: @selector(doEndBassAnim:)];
    self.bassHitAnim = [CCSequence actions: hit2anim, hitcallback, nil];
    
    // death animation
    for(int i = 1; i <= 3; i++) {
        CCSpriteFrame *deathframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:hitFrmName,i]];
        [deathFrames addObject:deathframe];
    }
    
    CCAnimation *deathanimation = [[CCAnimation animationWithFrames:deathFrames delay:0.15f] retain];
    
    self.bassDeathAnim = [[CCRepeat actionWithAction:
                           [CCAnimate actionWithAnimation:deathanimation restoreOriginalFrame:NO] times:1] retain];
    
    
    [[self bassBodySprite] runAction:[self bassBodyAnim]];
    
    self.bassBodySprite.scaleX = SPRITE_SCALE_FACTOR;
    self.bassBodySprite.scaleY = SPRITE_SCALE_FACTOR;
    
    self.bassBodySprite.position = [[UniversalInfo sharedInstance] bassPosition];
    
    if ([[UniversalInfo sharedInstance] getDeviceType] == IPHONE_5) {
        self.bass_weaponLeftx = self.bassBodySprite.position.x + itemBass.weaponleftx;
        self.bass_weaponRightx = self.bassBodySprite.position.x + itemBass.weaponrightx;
        self.bass_weaponyLeft = self.bassBodySprite.position.y + itemBass.weaponlefty;
        self.bass_weaponyRight = self.bassBodySprite.position.y + itemBass.weaponrighty;
    }else{
        self.bass_weaponLeftx = self.bassBodySprite.position.x + itemBass.weaponleftxipad;
        self.bass_weaponRightx = self.bassBodySprite.position.x + itemBass.weaponrightxipad;
        self.bass_weaponyLeft = self.bassBodySprite.position.y + itemBass.weaponleftyipad;
        self.bass_weaponyRight = self.bassBodySprite.position.y + itemBass.weaponrightyipad;
    }
    
    self.bassArmor = itemBass.armor;
    self.bassShootPower = itemBass.shootPower;
    self.totalBassArmor = itemBass.armor;

}

-(void)createGtBody2
{
    self.gtBody2Sprite = [[[CCSprite alloc] init] autorelease];
    NSMutableArray *animFrames = [NSMutableArray array];
    NSMutableArray *hitFrames = [NSMutableArray array];
    NSMutableArray *deathFrames = [NSMutableArray array];
    
    
    BandStoreItemsCtrl *storeCtrl = [BandStoreItemsCtrl sharedInstance];
    BandVault *vault = [BandVault sharedInstance];
    BandStoreItem *itemGuitar2;
    
    NSString *itemFrame;
    NSString *hitFrmName;
    
    if (vault.guitar2Index > 1) {
        NSLog(@"Guitar 2 not found %@",vault.guitar2Id);
        itemGuitar2 = [[storeCtrl guitarrists] objectAtIndex:1];
        itemFrame = [itemGuitar2.itemFrmName stringByAppendingString:@"%d.png"];
        hitFrmName = [itemGuitar2.itemFrmName stringByAppendingString:@"_hit%d.png"];
        
    }else{
        itemGuitar2 = [[storeCtrl guitarrists] objectAtIndex:vault.guitar2Index];
        itemFrame = [itemGuitar2.itemFrmName stringByAppendingString:@"%d.png"];
        hitFrmName = [itemGuitar2.itemFrmName stringByAppendingString:@"_hit%d.png"];
    }
    
    // normal state animation
    for(int i = 1; i <= itemGuitar2.itemframes; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                                [NSString stringWithFormat:itemFrame,i]];
        [animFrames addObject:frame];
    }
    
    CCAnimation *animation = [CCAnimation animationWithFrames:animFrames delay:0.07f];
    self.gtBody2Anim = [[CCRepeatForever actionWithAction:
                         [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO]] retain];
    
    // hit animation
    for(int i = 1; i <= 1; i++) {
        CCSpriteFrame *hitframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:hitFrmName,i]];
        [hitFrames addObject:hitframe];
    }
    
    CCAnimation *hitanimation = [[CCAnimation animationWithFrames:hitFrames delay:0.15f] retain];
    
    id hit2anim = [CCAnimate actionWithAnimation: hitanimation];
    id hitcallback = [CCCallFuncN actionWithTarget:self selector: @selector(doEndGuita2Anim:)];
    self.gt2HitAnim = [CCSequence actions: hit2anim, hitcallback, nil];
    
    // death animation
    for(int i = 1; i <= 3; i++) {
        CCSpriteFrame *deathframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:hitFrmName,i]];
        [deathFrames addObject:deathframe];
    }
    
    CCAnimation *deathanimation = [[CCAnimation animationWithFrames:deathFrames delay:0.15f] retain];
    
    self.gt2DeathAnim = [[CCRepeat actionWithAction:
                          [CCAnimate actionWithAnimation:deathanimation restoreOriginalFrame:NO] times:1] retain];
    
    
    [[self gtBody2Sprite] runAction:[self gtBody2Anim]];
    
    self.gtBody2Sprite.scaleX = SPRITE_SCALE_FACTOR;
    self.gtBody2Sprite.scaleY = SPRITE_SCALE_FACTOR;
    self.gtBody2Sprite.position = [[UniversalInfo sharedInstance] guitarrist2Position];
    
    if ([[UniversalInfo sharedInstance] getDeviceType] == IPHONE_5) {
        self.guita2_weaponLeftx = self.gtBody2Sprite.position.x + itemGuitar2.weaponleftx;
        self.guita2_weaponRightx = self.gtBody2Sprite.position.x + itemGuitar2.weaponrightx;
        self.guita2_weaponyLeft = self.gtBody2Sprite.position.y + itemGuitar2.weaponlefty;
        self.guita2_weaponyRight = self.gtBody2Sprite.position.y + itemGuitar2.weaponrighty;

    }else{
        self.guita2_weaponLeftx = self.gtBody2Sprite.position.x + itemGuitar2.weaponleftxipad;
        self.guita2_weaponRightx = self.gtBody2Sprite.position.x + itemGuitar2.weaponrightxipad;
        self.guita2_weaponyLeft = self.gtBody2Sprite.position.y + itemGuitar2.weaponleftyipad;
        self.guita2_weaponyRight = self.gtBody2Sprite.position.y + itemGuitar2.weaponrightyipad;
    }
    
    self.guitar2Armor = itemGuitar2.armor;
    self.guitar2ShootPower = itemGuitar2.shootPower;
    self.totalGuitar2Armor = itemGuitar2.armor;
    
}


-(void)createGuitar1
{
    self.guitar1Sprite = [[[CCSprite alloc] init] autorelease];
    NSMutableArray *animFrames = [NSMutableArray array];
    
    BandStoreItem *itemGuitar1;
    
    BandStoreItemsCtrl *storeCtrl = [BandStoreItemsCtrl sharedInstance];
    BandVault *vault = [BandVault sharedInstance];
    
    NSString *itemFrame;
    
    // commented just to check the prototype
    
    if (vault.guitar1Index > 0){
        NSLog(@"Guitar 1 arm not found %@",vault.guitar1Id);
        itemGuitar1 = [[storeCtrl guitarrists] objectAtIndex:0];
        itemFrame = [itemGuitar1.itemArmFrmName stringByAppendingString:@"%d.png"];
    }else{
        itemGuitar1 = [[storeCtrl guitarrists] objectAtIndex:vault.guitar1Index];
        itemFrame = [itemGuitar1.itemArmFrmName stringByAppendingString:@"%d.png"];
    }
    
    for(int i = 1; i <= itemGuitar1.itemframes; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:itemFrame,i]];
        [animFrames addObject:frame];
    }
    CCAnimation *animation = [CCAnimation animationWithFrames:animFrames delay:0.09f];
    self.guitar1Anim = [[CCRepeatForever actionWithAction:
                         [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO]] autorelease];
    
    self.guitar1Sprite.scaleX = SPRITE_SCALE_FACTOR;
    self.guitar1Sprite.scaleY = SPRITE_SCALE_FACTOR;
    
    [[self guitar1Sprite] runAction:[self guitar1Anim]];
    
    CGPoint anchorLeft = [self calculateAnchorPoint:ccp(itemGuitar1.anchorleftx, itemGuitar1.anchorlefty)
                                         sizeSprite:itemGuitar1.armsize];
    
    CGPoint anchorRight = [self calculateAnchorPoint:ccp(itemGuitar1.anchorrightx, itemGuitar1.anchorrighty)
                                          sizeSprite:itemGuitar1.armsize];
    
    // Check the value of the anchor point, maybe the size of the sprite is diferent.
    
    
    self.guita1_anchorLeftY = anchorLeft.y;
    self.guita1_anchorLeftX = anchorLeft.x;
    self.guita1_anchorRightY = anchorRight.y;
    self.guita1_anchorRightX = anchorRight.x;
    
    
}


-(void)createGuitar2
{
    self.guitar2Sprite = [[[CCSprite alloc] init] autorelease];
    NSMutableArray *animFrames = [NSMutableArray array];
    
    BandStoreItem *itemGuitar2;
    BandStoreItemsCtrl *storeCtrl = [BandStoreItemsCtrl sharedInstance];
    BandVault *vault = [BandVault sharedInstance];
    
    NSString *itemFrame;
    
    if (vault.guitar2Index > 1) {
        NSLog(@"Guitar 2 not found %@",vault.guitar2Id);
        itemGuitar2 = [[storeCtrl guitarrists] objectAtIndex:1];
        itemFrame = [itemGuitar2.itemArmFrmName stringByAppendingString:@"%d.png"];
        
    }else{
        itemGuitar2 = [[storeCtrl guitarrists] objectAtIndex:vault.guitar2Index];
        itemFrame = [itemGuitar2.itemArmFrmName stringByAppendingString:@"%d.png"];
    }
    
    for(int i = 1; i <= itemGuitar2.itemframes; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:itemFrame,i]];
        [animFrames addObject:frame];
    }
    CCAnimation *animation = [CCAnimation animationWithFrames:animFrames delay:0.1f];
    self.guitar2Anim = [[CCRepeatForever actionWithAction:
                         [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO]] autorelease];
    
    self.guitar2Sprite.scaleX = SPRITE_SCALE_FACTOR;
    self.guitar2Sprite.scaleY = SPRITE_SCALE_FACTOR;
    [[self guitar2Sprite] runAction:[self guitar2Anim]];
    
    CGPoint anchorLeft = [self calculateAnchorPoint:ccp(itemGuitar2.anchorleftx, itemGuitar2.anchorlefty)
                                         sizeSprite:itemGuitar2.armsize];
    
    CGPoint anchorRight = [self calculateAnchorPoint:ccp(itemGuitar2.anchorrightx, itemGuitar2.anchorrighty)
                                          sizeSprite:itemGuitar2.armsize];
    
    self.guita2_anchorLeftY = anchorLeft.y;
    self.guita2_anchorLeftX = anchorLeft.x;
    self.guita2_anchorRightY = anchorRight.y;
    self.guita2_anchorRightX = anchorRight.x;
}



-(void)createBass
{
    
    self.bassSprite = [[[CCSprite alloc] init] autorelease];
    NSMutableArray *animFrames = [NSMutableArray array];
    
    BandStoreItem *itemBass;
    
    BandStoreItemsCtrl *storeCtrl = [BandStoreItemsCtrl sharedInstance];
    BandVault *vault = [BandVault sharedInstance];
    
    NSString *itemFrame;
    
    if (vault.bassIndex > 0) {
        NSLog(@"Bass ARM not found %@",vault.bassId);
        itemBass = [[storeCtrl basses] objectAtIndex:0];
        itemFrame = [itemBass.itemArmFrmName stringByAppendingString:@"%d.png"];
        
    }else{
        itemBass = [[storeCtrl basses] objectAtIndex:vault.bassIndex];
        itemFrame = [itemBass.itemArmFrmName stringByAppendingString:@"%d.png"];
    }
  
    for(int i = 1; i <= itemBass.itemframes; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:itemFrame,i]];
        [animFrames addObject:frame];
    }
    CCAnimation *animation = [CCAnimation animationWithFrames:animFrames delay:0.08f];
    
    self.bassAnim = [[CCRepeatForever actionWithAction:
                      [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO]] retain];
    
    self.bassSprite.scaleX = SPRITE_SCALE_FACTOR;
    self.bassSprite.scaleY = SPRITE_SCALE_FACTOR;
    [[self bassSprite] runAction:[self bassAnim]];
    
    CGPoint anchorLeft = [self calculateAnchorPoint:ccp(itemBass.anchorleftx, itemBass.anchorlefty)
                                         sizeSprite:itemBass.armsize];
    
    CGPoint anchorRight = [self calculateAnchorPoint:ccp(itemBass.anchorrightx, itemBass.anchorrighty)
                                          sizeSprite:itemBass.armsize];
    
    self.bass_anchorLeftY = anchorLeft.y;
    self.bass_anchorLeftX = anchorLeft.x;
    self.bass_anchorRightY = anchorRight.y;
    self.bass_anchorRightX = anchorRight.x;

}

-(void)createVocalUpper
{
    self.vocalUpBodySprite = [[[CCSprite alloc] init] autorelease];
    NSMutableArray *animFrames = [NSMutableArray array];
    NSMutableArray *hitFrames = [NSMutableArray array];
    NSMutableArray *deathFrames = [NSMutableArray array];
    
    
    BandStoreItem *itemVocalUp;
    
    BandStoreItemsCtrl *storeCtrl = [BandStoreItemsCtrl sharedInstance];
    BandVault *vault = [BandVault sharedInstance];
    
    NSString *itemFrame;
    NSString *hitFrmName;
    
    if (vault.vocalIndex > 0) {
        NSLog(@"Vocal Upper not found %@",vault.vocalId);
        itemVocalUp = [[storeCtrl vocals] objectAtIndex:0];
        itemFrame = [itemVocalUp.itemArmFrmName stringByAppendingString:@"%d.png"];
        hitFrmName = [itemVocalUp.itemFrmName stringByAppendingString:@"_hit%d.png"];
        
    }else{
        itemVocalUp = [[storeCtrl vocals] objectAtIndex:vault.vocalIndex];
        itemFrame = [itemVocalUp.itemArmFrmName stringByAppendingString:@"%d.png"];
        hitFrmName = [itemVocalUp.itemFrmName stringByAppendingString:@"_hit%d.png"];
    }

    // normal animation
    for(int i = 1; i <= itemVocalUp.itemframes; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:itemFrame,i]];
        [animFrames addObject:frame];
    }
    CCAnimation *animation = [CCAnimation animationWithFrames:animFrames delay:0.05f];
    self.vocalUpBodyAnim = [[CCRepeatForever actionWithAction:
                             [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO]] retain];
    // hit animation
    for(int i = 1; i <= 1; i++) {
        CCSpriteFrame *hitframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:hitFrmName,i]];
        [hitFrames addObject:hitframe];
    }
    
    CCAnimation *hitanimation = [[CCAnimation animationWithFrames:hitFrames delay:0.15f] retain];
    
    id hitanim = [CCAnimate actionWithAnimation: hitanimation];
    id hitcallback = [CCCallFuncN actionWithTarget:self selector: @selector(doEndVocalAnim:)];
    self.vocalHitAnim = [CCSequence actions: hitanim, hitcallback, nil];
    

    
    // death animation
    for(int i = 3; i <= 3; i++) {
        CCSpriteFrame *deathframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:hitFrmName,i]];
        [deathFrames addObject:deathframe];
    }
    
    CCAnimation *deathanimation = [[CCAnimation animationWithFrames:deathFrames delay:0.15f] retain];
    
    id deathanim = [[CCRepeat actionWithAction:
                            [CCAnimate actionWithAnimation:deathanimation restoreOriginalFrame:NO] times:1] retain];
    
    id deathcallback = [CCCallFuncN actionWithTarget:self selector: @selector(doEndDeathVocalAnim:)];
   
    self.vocalDeathAnim = [CCSequence actions: deathanim, deathcallback, nil];
    
    self.vocalUpBodySprite.scaleX = SPRITE_SCALE_FACTOR;
    self.vocalUpBodySprite.scaleY = SPRITE_SCALE_FACTOR;
    [[self vocalUpBodySprite] runAction:[self vocalUpBodyAnim]];
        
    CGPoint anchorLeft = [self calculateAnchorPoint:ccp(itemVocalUp.anchorleftx, itemVocalUp.anchorlefty)
                                         sizeSprite:itemVocalUp.armsize];
    
    CGPoint anchorRight = [self calculateAnchorPoint:ccp(itemVocalUp.anchorrightx, itemVocalUp.anchorrighty)
                                         sizeSprite:itemVocalUp.armsize];
    
    
    self.vocal_anchorLeftY = anchorLeft.y;
    self.vocal_anchorLeftX = anchorLeft.x;
    self.vocal_anchorRightY = anchorRight.y;
    self.vocal_anchorRightX = anchorRight.x;
}

-(void)createVocalLower
{
    
    self.vocalLwBodySprite = [[[CCSprite alloc] init] autorelease];
    NSMutableArray *animFrames = [NSMutableArray array];
    
    BandStoreItem *itemVocalLower;
    
    BandStoreItemsCtrl *storeCtrl = [BandStoreItemsCtrl sharedInstance];
    BandVault *vault = [BandVault sharedInstance];
    
    NSString *itemFrame;
    
    if (vault.vocalIndex > 0) {
        NSLog(@"Vocal lower not found %@",vault.vocalId);
        itemVocalLower = [[storeCtrl vocals] objectAtIndex:0];
        itemFrame = [itemVocalLower.itemFrmName stringByAppendingString:@"%d.png"];
        
    }else{
        itemVocalLower = [[storeCtrl vocals] objectAtIndex:vault.vocalIndex];
        itemFrame = [itemVocalLower.itemFrmName stringByAppendingString:@"%d.png"];
    }
    
    for(int i = 1; i <= itemVocalLower.itemframes; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:itemFrame,i]];
        [animFrames addObject:frame];
    }
    CCAnimation *animation = [CCAnimation animationWithFrames:animFrames delay:0.07f];
    self.vocalLwBodyAnim = [[CCRepeatForever actionWithAction:
                             [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO]] autorelease];
    [[self vocalLwBodySprite] runAction:[self vocalLwBodyAnim]];
    
    
    self.vocalLwBodySprite.scaleX = 0.40;
    self.vocalLwBodySprite.scaleY = 0.40;
    
    self.vocalLwBodySprite.position = [[UniversalInfo sharedInstance] vocalPosition];
    
    if ([[UniversalInfo sharedInstance] getDeviceType] == IPHONE_5) {
        self.vocal_weaponLeftx = self.vocalLwBodySprite.position.x + itemVocalLower.weaponleftx;
        self.vocal_weaponRightx = self.vocalLwBodySprite.position.x + itemVocalLower.weaponrightx;
        self.vocal_weaponyLeft = self.vocalLwBodySprite.position.y + itemVocalLower.weaponlefty;
        self.vocal_weaponyRight = self.vocalLwBodySprite.position.y + itemVocalLower.weaponrighty;
    }else{
        self.vocal_weaponLeftx = self.vocalLwBodySprite.position.x + itemVocalLower.weaponleftxipad;
        self.vocal_weaponRightx = self.vocalLwBodySprite.position.x + itemVocalLower.weaponrightxipad;
        self.vocal_weaponyLeft = self.vocalLwBodySprite.position.y + itemVocalLower.weaponleftyipad;
        self.vocal_weaponyRight = self.vocalLwBodySprite.position.y + itemVocalLower.weaponrightyipad;
    }
    
    
}

-(id)initBand
{
    self = [super init];
    if(self) {
        NSLog(@"initBand");
        self.activeShoots = [[NSMutableArray alloc] init];
        
        [self createDrummer];
        [self createGtBody1];
        [self createGuitar1];
        [self createGtBody2];
        [self createGuitar2];
        [self createBassPlayerBody];
        [self createBass];
        [self createVocalLower];
        [self createVocalUpper];
        
    }
    
    self.guita1ReleaseFire = YES;
    self.guita2ReleaseFire = YES;
    self.bassReleaseFire = YES;
    self.vocalReleaseFire = YES;
    
    // just for now until we have the naked hero.
    [self setVisible:YES];
    
    // the time interval is resposable for the weapon cool down if it is larger the larger
    // will be the cool down if it is minor the less is the cool down it will be nice
    // to parametrize it by guitarrrist/bass/vocal type.
    
    [NSTimer scheduledTimerWithTimeInterval:0.02
                                     target:self
                                   selector:@selector(doRelVocalFire:)
                                   userInfo:self
                                    repeats:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:0.02
                                     target:self
                                   selector:@selector(doRelGuita1Fire:)
                                   userInfo:self
                                    repeats:YES];
    
    
    [NSTimer scheduledTimerWithTimeInterval:0.02
                                     target:self
                                   selector:@selector(doRelGuita2Fire:)
                                   userInfo:self
                                    repeats:YES];
    
    
    [NSTimer scheduledTimerWithTimeInterval:0.02
                                     target:self
                                   selector:@selector(doRelBassFire:)
                                   userInfo:self
                                    repeats:YES];
    
    self.shootPower = self.guitar1ShootPower + self.guitar2ShootPower + self.bassShootPower + self.vocalsShootPower;
    
    [self setIsGuita1Death:NO];
    [self setIsGuita2Death:NO];
    [self setIsBassDeath:NO];
    [self setIsVocalDeath:NO];
    [self setIsDrummerDeath:NO];
    
    self.scaleY = SPRITE_SCALE_FACTOR;
    self.scaleX = SPRITE_SCALE_FACTOR;
    
    return self;
}

-(void)doRelVocalFire:(id)node
{
    if (self.vocalReleaseFire == YES){
        self.vocalReleaseFire = NO;
    }else{
        self.vocalReleaseFire = YES;
    }
}

-(float)getTotalArmor
{
    return self.drummerArmor + self.guitar1Armor + self.guitar2Armor +
    self.bassArmor + self.vocalArmor;
}

-(void)doRelGuita1Fire:(id)node
{
    if (self.guita1ReleaseFire == YES){
        self.guita1ReleaseFire = NO;
    }else{
        self.guita1ReleaseFire = YES;
    }
}

-(void)doRelGuita2Fire:(id)node
{
    if (self.guita2ReleaseFire == YES){
        self.guita2ReleaseFire = NO;
    }else{
        self.guita2ReleaseFire = YES;
    }
}

-(void)doRelBassFire:(id)node
{
    if (self.bassReleaseFire == YES){
        self.bassReleaseFire = NO;
    }else{
        self.bassReleaseFire = YES;
    }
}

-(void)performBandDeath
{
    NSLog(@"The Band has been destroyed launch game over");
}

-(void)doEndDrummerHitAnim:(id)node
{
    //NSLog(@"Drummer hit edded");
    [[self drummerSprite ] stopAllActions];
    [[self drummerSprite] runAction:[self drummerAnim]];
}

-(void)doEndGenHitAnim:(id)node
{
    [[self delegate] removeChild:node cleanup:YES];
}

-(void)doEndGuita1Anim:(id)node
{
    //NSLog(@"Guitar 1 hit edded");
    [[self gtBody1Sprite] stopAllActions];
    [[self gtBody1Sprite] runAction:[self gtBody1Anim]];
}

-(void)doEndGuita2Anim:(id)node
{
    //NSLog(@"Guitar 2 hit edded");
    [[self gtBody2Sprite] stopAllActions];
    [[self gtBody2Sprite] runAction:[self gtBody2Anim]];
}

-(void)doEndBassAnim:(id)node
{
    //NSLog(@"Bass hit edded");
    [[self bassSprite] stopAllActions];
    [[self bassSprite] runAction:[self bassAnim]];

}

-(void)doEndVocalAnim:(id)node
{
    //NSLog(@"Vocal hit ended");
    [[self vocalUpBodySprite] stopAllActions];
    [[self vocalUpBodySprite] runAction:[self vocalUpBodyAnim]];
}

-(void)doEndDeathVocalAnim:(id)node
{
    //NSLog(@"Vocal dead ended");
    [[self vocalLwBodySprite] stopAllActions];
    self.vocalLwBodySprite.visible = NO;
    self.vocalUpBodySprite.rotation = 0;
    self.vocalUpBodySprite.position = ccpAdd(self.vocalLwBodySprite.position, ccp(10,-20));
}

-(void)performGeneralHitAnimation:(CGPoint) hitPoint
{
    CCSprite *hitSprite = [[[CCSprite alloc] init] autorelease];
    hitSprite.position = hitPoint;
    [[self delegate] addChild:hitSprite z:50];
    
    NSMutableArray *blastAnimFrames = [[[NSMutableArray alloc] init] autorelease];
    for(int i = 1; i <= 7; ++i) {
        [blastAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"band_hit%d.png", i]]];
    }
    
    CCAnimation *blastAnim = [CCAnimation
                              animationWithFrames:blastAnimFrames delay:0.03f];
    
    id animation = [CCAnimate actionWithAnimation: blastAnim];
    id callback = [CCCallFuncN actionWithTarget:self selector: @selector(doEndGenHitAnim:)];
    id sequence = [CCSequence actions: animation, callback, nil];
    
    hitSprite.scaleY = 0.5;
    hitSprite.scaleX = 0.5;
    
    [hitSprite runAction:sequence];
    
}

-(float)hitByEnemy:(float)damagePoints component:(BandComponents)type rect:(CGRect )collrect;
{
    //Beware that it is possible that the band has only the vocal and the drummer
    //so it is required to check if the order characters are present
    //before play death
    
    
    // this method will return the updated armor of the band component that was hitted.
    
    [self performGeneralHitAnimation:collrect.origin];
    
    switch (type) {
        case GUITARRIST1_TYPE:
            if (!self.isGuita1Death) {
                self.guitar1Armor = self.guitar1Armor - damagePoints;
                self.guitar1Armor = MAX(self.guitar1Armor, 0);
                if (guitar1Armor <= 0){
                    //NSLog(@"PerformGuitar1Death");
                    [[self gtBody1Sprite] stopAllActions];
                    [[self gtBody1Sprite] runAction:[self gt1DeathAnim]];
                    [self setIsGuita1Death:YES];
                    [self setGuitar1Armor:0.0];
                    [[self delegate] removeChild:[self guitar1Sprite] cleanup:YES];
                }else{
                    //NSLog(@"PerformGuitar1Hit");
                    [[self gtBody1Sprite] stopAllActions];
                    //remove the guitar1 it shall be made for all other chars.
                    [[self gtBody1Sprite] runAction:[self gt1HitAnim]];
                }
            }
            return self.guitar1Armor;
            break;
        case GUITARRIST2_TYPE:
            if (!self.isGuita2Death){
                self.guitar2Armor = self.guitar2Armor - damagePoints;
                self.guitar2Armor = MAX(self.guitar2Armor, 0);
                if (guitar2Armor <= 0){
                    //NSLog(@"PerformGuitar2Death");
                    [[self gtBody2Sprite] stopAllActions];
                    [[self gtBody2Sprite] runAction:[self gt2DeathAnim]];
                    [self setIsGuita2Death:YES];
                    [self setGuitar2Armor:0.0];
                    [[self delegate] removeChild:[self guitar2Sprite] cleanup:YES];
                }else{
                    //NSLog(@"PerformGuitar2Hit");
                    [[self gtBody2Sprite] stopAllActions];
                    [[self gtBody2Sprite] runAction:[self gt2HitAnim]];
                }
            }
            return self.guitar2Armor;
            break;
        case BASS_TYPE:
            if (!self.isBassDeath) {
                self.bassArmor = self.bassArmor - damagePoints;
                self.bassArmor = MAX(self.bassArmor, 0);
                if (bassArmor <= 0){
                    //NSLog(@"PerformBassDeath");
                    [[self bassBodySprite] stopAllActions];
                    [[self bassBodySprite] runAction:[self bassDeathAnim]];
                    [self setIsBassDeath:YES];
                    [self setBassArmor:0.0];
                    [[self delegate] removeChild:[self bassSprite] cleanup:YES];
                }else{
                    //NSLog(@"PerformBassHit");
                    [[self bassBodySprite] stopAllActions];
                    [[self bassBodySprite] runAction:[self bassHitAnim]];
                }
            }
            return self.bassArmor;
            break;
        case VOCALS_TYPE:
            if (!self.isVocalDeath) {
                self.vocalArmor = self.vocalArmor - damagePoints;
                self.vocalArmor = MAX(self.vocalArmor, 0);
                if (vocalArmor <= 0){
                    //NSLog(@"PerformVocalDeath");
                    [[self vocalUpBodySprite] stopAllActions];
                    [[self vocalUpBodySprite] runAction:[self vocalDeathAnim]];
                    [self setIsVocalDeath:YES];
                    [self setVocalArmor:0.0];
                }else{
                    //NSLog(@"PerformVocalHit");
                    [[self vocalUpBodySprite] stopAllActions];
                    [[self vocalUpBodySprite] runAction:[self vocalHitAnim]];
                }
            }
            return self.vocalArmor;
            break;
        case DRUMMER_TYPE:
            if (!isDrummerDeath) {
                self.drummerArmor = self.drummerArmor - damagePoints;
                self.drummerArmor = MAX(self.drummerArmor, 0);
                if (drummerArmor <= 0){
                    //NSLog(@"PerformDrummerDeath");
                    [[self drummerSprite] stopAllActions];
                    [[self drummerSprite] runAction:[self drummerDeathAnim]];
                    [self setIsDrummerDeath:YES];
                    [self setDrummerArmor:0.0];
                }else{
                    //NSLog(@"PerformDrummerHit");
                    [[self drummerSprite] stopAllActions];
                    [[self drummerSprite] runAction:[self drummerHitAnim]];
                }
            }
            return self.drummerArmor;
            break;
        default:
            return -1;
            break;
    }
}

-(void)hitByEnemy:(float)damagePoints
{
    self.drummerArmor = self.drummerArmor - damagePoints;
    self.drummerArmor = MAX(self.drummerArmor, 0);
    //NSLog(@"Drummer Armor left %f",[self drummerArmor]);
    if (self.drummerArmor <= 0) {
        [self performBandDeath];
    }else{
        //NSLog(@"Play shoot animation can be spark particles");
        self.bandParticle = [CCParticleSmoke node];
        self.bandParticle.texture = [[CCTextureCache sharedTextureCache] addImage: @"smoke.png"];
        self.bandParticle.position = [self position];
        self.bandParticle.startSize = 0.00001;
        self.bandParticle.endSize = 1.5;
        self.bandParticle.totalParticles = 20;
        self.bandParticle.duration = 0.1;
        [[self delegate] addChild:[self bandParticle]];
    }
}

-(void)performBandBlast
{
    //NSLog(@"Band Blast Explosion");
    self.bandParticleBlaster = [CCParticleSystemQuad particleWithFile:@"ExplodingRing.plist"];
    self.bandParticleBlaster.position = ccp(160,240);
    [[self delegate] addChild:[self bandParticleBlaster]];
}

-(void)receiveHealthPowerUp:(float)value
{
    self.drummerArmor = self.drummerArmor + value;
    self.drummerArmor = MIN(self.drummerArmor, 100);
}

-(void)runShootAnimation
{
    
}

@end
