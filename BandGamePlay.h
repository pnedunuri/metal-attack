//
//  BandGamePlay.h
//  EightbitShooter
//
//  Created by Rafael Munhoz on 13/03/13.
//
//

#import "cocos2d.h"
#import "BandSprite.h"
#import "LevelController.h"
#import "GameOver.h"
#import "Victory.h"
#import "HeroShoot.h"
#import "GameHud.h"
#import "EndGame.h"
#import "SimpleAudioEngine.h"
#import "MotherScene.h"
#import <GameKit/GameKit.h>
#import <Foundation/Foundation.h>

typedef enum {
    GAME_STARTED,
    WAVE_CLEARED,
    LEVEL_CLEARED,
    GAME_OVER,
    GAME_PAUSED
} GameState;

@interface BandGamePlay : MotherScene <spriteManager, hudProtocol>
{
    CGPoint beginTouch;
    CGPoint endTouch;
    BandSprite *bandSprite;
    NSMutableArray *activeEnemies;
    float rotationAngle;
    BOOL moved;
    CCParticleSystem *heroParticle;
    int waveEnemiesLeft;
    int levelEnemiesLeft;
    GameState state;
    GameHud *hudLayer;
    int levelNumber;
    int waveNumber;
    int scoreCount;
    UITouch *playerTouch;
    
    NSMutableArray *coinAnimFrames;
}

@property (nonatomic,retain) BandSprite *bandSprite;
@property (nonatomic) CGPoint beginTouch;
@property (nonatomic) CGPoint endTouch;
@property (nonatomic) float rotationAngle;
@property (nonatomic,retain) NSMutableArray *activeEnemies;
@property (nonatomic) BOOL moved;
@property (nonatomic,retain) CCParticleSystem *heroParticle;
@property (nonatomic) int waveEnemiesLeft;
@property (nonatomic) GameState state;
@property (nonatomic,retain) GameHud *hudLayer;
@property (nonatomic) int scoreCount;
@property (nonatomic) int levelNumber;
@property (nonatomic) int waveNumber;
@property (nonatomic) int levelEnemiesLeft;
@property (nonatomic) bool touchEnded;
@property (nonatomic,retain) UITouch *playerTouch;
@property (nonatomic, retain) NSMutableArray *coinAnimFrames;
@property (nonatomic, retain) CCAction *coinAnimation;

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *)sceneWithLevel:(int)levelNumber wave:(int)waveNumber;
-(id)initWithHudAndLevel:(GameHud *)hud level:(int)startLevel wave:(int)startWave;
-(void)triggerRadioExplosion;
-(void)clearEnemyFire;
-(void)raiseCooldownBar:(ccTime)dt;

@end
