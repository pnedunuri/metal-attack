//
//  Enemy.h
//  EightbitShooter
//
//  Created by Rafael Munhoz on 2/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "EnemyParams.h"
#import "BandSprite.h"

typedef enum {
    POS1,
    POS2,
    POS3,
    POS4,
    POS5,
    POS6,
    POS7,
    POS8
} EnemyPositions;

@interface Enemy : CCNode


{
    // how many points left from the armor.
    float armor;
    // delay to enter in action in seconds defined by the level json file.
    float delayToAction;
    // weapon damage of the robot
    float weaponDamage;
    // time to reach hero seconds
    double timeToReach;
    // type of power up
    PowerUp powerupType;
       
    CGPoint initialPosition;
    //position to make the action of shoot cross the screen
    CGPoint shootPosition;
    
    CCSprite *enemySprite;
    CCSprite *shootSprite;
    CCAction *enemyAction;
    CCAction *enemyAttack;
    CCSpriteBatchNode *enemysprtSheet;
    
    CCParticleSystem *enemyParticle;
    
    // Controls the shoot lifecycle
    NSMutableArray *activeEnemies;
    
    BOOL removeObject;
    
    NSTimer *enemyTimer;
    
    int scorePoints;
    
    id delegate;
    
    NSString *name;
    
    int frames;
    
    EnemyPositions definedPosition;
    
    AtackType attackType;
    
    CGPoint shootStartPosition;
    
    int shootZIndex;

}

@property (nonatomic) double timeToReach;
@property (nonatomic) float armor;
@property (nonatomic) CGPoint initialPosition;
@property (nonatomic) CGPoint shootPosition;
@property (nonatomic, retain) CCSprite *enemySprite;
@property (nonatomic, retain) CCSprite *shootSprite;
@property (nonatomic, retain) CCAction *enemyAction;
@property (nonatomic, retain) CCAction *enemyAttack;
@property (nonatomic, retain) CCSpriteBatchNode *enemysprtSheet;
@property (nonatomic, retain) id delegate;
@property (nonatomic) BOOL removeObject;
@property (nonatomic, retain) CCParticleSystem *enemyParticle;
@property (nonatomic) float weaponDamage;
@property (nonatomic, retain) NSTimer *enemyTimer;
@property (nonatomic) int scorePoints;
@property (nonatomic,retain) NSString *name;
@property (nonatomic) int frames;
@property (nonatomic) PowerUp typeOfPowerUp;
@property (nonatomic,retain) NSMutableArray *activeShoots;
@property (nonatomic) EnemyPositions definedPosition;
@property (nonatomic) AtackType attackType;
@property (nonatomic) bool isMeeleAttacking;
@property (nonatomic) bool isInMovement;
@property (nonatomic, retain) BandSprite *bandsprite;
@property (nonatomic) CGRect hitRect;
@property (nonatomic) BandComponents hitComponent;
@property (nonatomic) CGPoint shootStartPosition;
@property (nonatomic) int shootZIndex;
@property (nonatomic) ShootStyle shootStyle;


-(id)initwithStartPosition:(CGPoint)position actionTime:(double)time delegate:(id)scnDelegate enemyParams:(EnemyParams *)params enemyPosition:(EnemyPositions)defPosition shootEndPos:(CGPoint)shootEnd;
-(void)startMovement;
-(void)restartMovement;
-(int)receiveHeroShoot:(float)damage killNow:(BOOL)value shootRect:(CGRect)rect;
-(void)performDeath;
-(void)performAutoDestruction;
-(void)fireWeapon;
-(float)autoDestruction;
-(void)meeleAttack:(BandSprite *)bandsprite bandComponent:(BandComponents)component hitrect:(CGRect)rect;
-(CGRect)meeleRect;

@end

@protocol spriteManager <NSObject>
-(void)removeEnemySprite:(CCSprite *)enemySprite;
-(void)addEnemySprite:(Enemy *)enemy;
-(BOOL)isGameOver;
@end

