//
//  GameHud.h
//  EightbitShooter
//
//  Created by Rafael Munhoz on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BandSprite.h"

@interface GameHud : CCNodeColor

{
    id delegate;
    
    CCSprite* hud1;
    CCSprite* hud2;
    CCSprite* coin;
    
    CCSprite* inAppArmor;
    CCSprite* inAppAmmo;
    CCSprite* inAppGenereal;
    
    CCLabelTTF *labelCoinValue;
    CCLabelTTF *labelWave;
    CCLabelTTF *labelLevel;
    CCLabelTTF *labelWaveValue;
    CCLabelTTF *labelWaveTotal;
    CCLabelTTF *labelArmor;
    CCLabelTTF *labelArmorPercent;
    CCLabelTTF *labelWaveCleared;
    CCButton * menuItem1;
    CCNode * myMenu;
    CCButton * menuItem2;
    CCNode * myMenu2;
    CCLabelTTF *labelScore;
    CCProgressNode *coolDownBar;
    
    CCProgressNode *guita1Life;
    CCProgressNode *guita2Life;
    CCProgressNode *vocalLife;
    CCProgressNode *drummerLife;
    CCProgressNode *bassLife;
    
    CCSprite *guita1LifeIcon;
    CCSprite *guita2LifeIcon;
    CCSprite *vocalLifeIcon;
    CCSprite *drummerLifeIcon;
    CCSprite *bassLifeIcon;
    CCSprite *bgLifeIcon;
    
    CCSprite *comboBG;
    CCSprite *comboValue;
    CCSprite *equipBG;
    
    bool isBandShooting;
    
    CCLabelTTF *comboLabelValue;
    CCLabelTTF *blastValue;
    
    CCSprite *snakeHead;
    
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) CCSprite *hud1;
@property (nonatomic, retain) CCSprite *hud2;
@property (nonatomic, retain) CCLabelTTF *labelWave;
@property (nonatomic, retain) CCLabelTTF *labelWaveValue;
@property (nonatomic, retain) CCLabelTTF *labelWaveTotal;
@property (nonatomic, retain) CCLabelTTF *labelArmor;
@property (nonatomic, retain) CCLabelTTF *labelArmorPercent;
@property (nonatomic, retain) CCButton * menuItem1;
@property (nonatomic, retain) CCNode * myMenu;
@property (nonatomic, retain) CCButton * menuItem2;
@property (nonatomic, retain) CCNode * myMenu2;
@property (nonatomic, retain) CCLabelTTF *labelScore;
@property (nonatomic, retain) CCLabelTTF *labelWaveCleared;
@property (nonatomic, retain) CCLabelTTF *labelLevel;
@property (nonatomic, retain) CCLabelTTF *labelCoinValue;
@property (nonatomic, retain) CCSprite *coin;
@property (nonatomic, retain) CCSprite *inAppArmor;
@property (nonatomic, retain) CCSprite *inAppAmmo;
@property (nonatomic, retain) CCSprite *inAppGenereal;
@property (nonatomic, retain) CCProgressNode *coolDownBar;
@property (nonatomic) bool isBandShooting;
@property (nonatomic, retain) CCProgressNode *guita1Life;
@property (nonatomic, retain) CCProgressNode *guita2Life;
@property (nonatomic, retain) CCProgressNode *vocalLife;
@property (nonatomic, retain) CCProgressNode *drummerLife;
@property (nonatomic, retain) CCProgressNode *bassLife;

@property (nonatomic, retain) CCSprite *guita1LifeIcon;
@property (nonatomic, retain) CCSprite *guita2LifeIcon;
@property (nonatomic, retain) CCSprite *vocalLifeIcon;
@property (nonatomic, retain) CCSprite *drummerLifeIcon;
@property (nonatomic, retain) CCSprite *bassLifeIcon;

@property (nonatomic, retain) CCSprite *comboBG;
@property (nonatomic, retain) CCSprite *comboValue;
@property (nonatomic, retain) CCSprite *bgLifeIcon;

@property (nonatomic, retain) CCActionSequence *comboBGSequence;
@property (nonatomic, retain) CCActionMoveBy *moveComboToScreen;
@property (nonatomic, retain) id endMoveCombo;
@property (nonatomic, retain) id moveComboOffScreen;

@property (nonatomic, retain) CCSprite *snakeBG;
@property (nonatomic, retain) CCProgressNode *snakeBar;
@property (nonatomic, retain) CCSprite *equipBG;

@property (nonatomic, retain) CCLabelTTF *comboLabelValue;
@property (nonatomic, retain) CCLabelTTF *blastValue;
@property (nonatomic, retain) CCSprite *snakeHead;



-(void)doWaveClearedAnimation;
-(void)doLevelPresentation:(int)levelNumber;
-(void)doEndComboBgAnim:(id)node;
-(void)updateBandLifeBar:(BandSprite *)bandSprite;
-(void)reverseComboPresentation;

@end

@protocol hudProtocol <NSObject>
-(void)triggerRadioExplosion;
-(void)pauseGame;
@end