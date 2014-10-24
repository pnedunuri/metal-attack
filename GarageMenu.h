//
//  ███╗   ███╗███████╗████████╗ █████╗ ██╗          █████╗ ████████╗████████╗ █████╗  ██████╗██╗  ██╗
//  ████╗ ████║██╔════╝╚══██╔══╝██╔══██╗██║         ██╔══██╗╚══██╔══╝╚══██╔══╝██╔══██╗██╔════╝██║ ██╔╝
//  ██╔████╔██║█████╗     ██║   ███████║██║         ███████║   ██║      ██║   ███████║██║     █████╔╝
//  ██║╚██╔╝██║██╔══╝     ██║   ██╔══██║██║         ██╔══██║   ██║      ██║   ██╔══██║██║     ██╔═██╗
//  ██║ ╚═╝ ██║███████╗   ██║   ██║  ██║███████╗    ██║  ██║   ██║      ██║   ██║  ██║╚██████╗██║  ██╗
//  ╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝    ╚═╝  ╚═╝   ╚═╝      ╚═╝   ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
//
//
//  GarageMenu.h
//  EightbitShooter
//
//  Created by Rafael Munhoz on 22/10/14.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BandGamePlay.h"
#import "Credits.h"
#import "BandStore.h"
#import "BandVault.h"

@interface GarageMenu : CCLayer
{
    CCSpriteBatchNode *_batchNode;
    
    CCParallaxNode *_backgroundNode;
    CCSprite *_spacedust1;
    CCSprite *_spacedust2;
    CCSprite *_spacedust3;
    CCSprite *_spacedust4;
    CCSprite *_planetsunrise;
    CCSprite *_galaxy;
    CCSprite *_spacialanomaly;
    CCSprite *_spacialanomaly2;
    float _shipPointsPerSecY;
    CCArray *_asteroids;
    int _nextAsteroid;
    double _nextAsteroidSpawn;
    CCLabelTTF *distanceX;
    CCLabelTTF *distanceY;
    CCLabelTTF *energyUnitsLabel;
    
    CGPoint beginTouch;
    CGPoint endTouch;
    
    BOOL moved;
}

@property (nonatomic,retain) CCAction *chestAnim;
@property (nonatomic,retain) CCAction *girlEyeAnim;
@property (nonatomic,retain) CCAction *guyEyeAnim;
@property (nonatomic,retain) CCAction *tuningAnim;
@property (nonatomic,retain) CCAction *playAnim;
@property (nonatomic,retain) CCAction *flamesAnim;
@property (nonatomic,retain) CCAction *batAnim;


+(CCScene *) scene;


@end
