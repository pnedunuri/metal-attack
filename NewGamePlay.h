//
//  NewGamePlay.h
//  MetalAttack
//
//  Created by Rafael Munhoz on 29/10/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BandSprite.h"
#import "MotherScene.h"

@interface NewGamePlay : MotherScene {
    
}

@property (nonatomic,retain) BandSprite *bandSprite;
@property (nonatomic) CGPoint beginTouch;
@property (nonatomic) CGPoint endTouch;
@property (nonatomic) float rotationAngle;
@property (nonatomic,retain) NSMutableArray *activeEnemies;
@property (nonatomic) BOOL moved;
@property (nonatomic,retain) CCParticleSystem *heroParticle;
@property (nonatomic) int waveEnemiesLeft;
//@property (nonatomic) GameState state;
//@property (nonatomic,retain) GameHud *hudLayer;
@property (nonatomic) int scoreCount;
@property (nonatomic) int levelNumber;
@property (nonatomic) int waveNumber;
@property (nonatomic) int levelEnemiesLeft;
@property (nonatomic) bool touchEnded;
@property (nonatomic,retain) UITouch *playerTouch;
@property (nonatomic, retain) NSMutableArray *coinAnimFrames;
@property (nonatomic, retain) CCAction *coinAnimation;


@end
