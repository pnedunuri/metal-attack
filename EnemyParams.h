//
//  EnemyParams.h
//  EightbitShooter
//
//  Created by Rafael Munhoz on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    GUNPOWER_1,
    GUNPOWER_2,
    HEALTHPOWER,
    RADIOPOWER,
    COIN,
    NOPOWERUP
} PowerUp;

typedef enum {
    MEELEE,
    AUTODESTRUCTION,
    WALK_SHOOT,
} AtackType;

typedef enum {
    SINGLE,
    ROTATION,
    JUMP,
} ShootStyle;

@interface EnemyParams : NSObject

{
    NSString *enemyName;
    float armor;
    float weaponDamage;
    float scorePoints;
    int numberOfFrames;
    double timeToReach;
    PowerUp typeOfPowerUp;
    AtackType atackType;
    CGPoint shootStartPosition;
    ShootStyle shootStyle;
}

@property (nonatomic,retain) NSString *enemyName;
@property (nonatomic) float armor;
@property (nonatomic) float weaponDamage;
@property (nonatomic) float scorePoints;
@property (nonatomic) int numberOfFrames;
@property (nonatomic) double timeToReach;
@property (nonatomic) PowerUp typeOfPowerUp;
@property (nonatomic) AtackType atackType;
@property (nonatomic) CGPoint shootStartPosition;
@property (nonatomic) ShootStyle shootStyle;

@end
