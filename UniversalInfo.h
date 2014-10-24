//
//  UniversalInfo.h
//  EightbitShooter
//
//  Created by Rafael Munhoz on 31/03/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum {
    IPHONE_5,
    IPHONE_4,
    IPAD,
    IPAD_RETINA
} DeviceType;

typedef enum {
    MENU,
    NEXT_LEVEL,
    STORE,
    REPLAY,
} nextScence;

/*
 
 int const guita1_weaponLeftx = 202; //fixed
 int const guita1_weaponRightx = 196; // fixed
 int const guita1_weaponyRight = 220; // fixed
 int const guita1_weaponyLeft = 220; // fixed
 
 int const guita2_weaponLeftx = 102; //fixed
 int const guita2_weaponRightx = 98; // fixed
 int const guita2_weaponyRight = 301; // fixed
 int const guita2_weaponyLeft = 301; // fixed
 
 int const vocal_weaponLeftx = 145; //fixed
 int const vocal_weaponRightx = 155; // fixed
 int const vocal_weaponyRight = 228; // fixed
 int const vocal_weaponyLeft = 228; // fixed
 
 */

@interface UniversalInfo : NSObject

+(UniversalInfo *)sharedInstance;
-(BOOL) isDeviceIpad;
-(CGPoint) screenCenter;

-(int)guita1WeaponLeftx;
-(int)guita1WeaponRightx;
-(int)guita1WeaponyRight;
-(int)guita1WeaponyLeft;

-(int)guita2WeaponLeftx;
-(int)guita2WeaponRightx;
-(int)guita2WeaponyRight;
-(int)guita2WeaponyLeft;

-(int)vocalWeaponLeftx;
-(int)vocalWeaponRightx;
-(int)vocalWeaponyRight;
-(int)vocalWeaponyLeft;

-(int)bassWeaponLeftx;
-(int)bassWeaponRightx;
-(int)bassWeaponyRight;
-(int)bassWeaponyLeft;

-(CGPoint)enemyPosition1;
-(CGPoint)enemyPosition2;
-(CGPoint)enemyPosition3;
-(CGPoint)enemyPosition4;
-(CGPoint)enemyPosition5;
-(CGPoint)enemyPosition6;
-(CGPoint)enemyPosition7;
-(CGPoint)enemyPosition8;

/*
-(CGPoint)enemyEnd1;
-(CGPoint)enemyEnd2;
-(CGPoint)enemyEnd3;
-(CGPoint)enemyEnd4;
-(CGPoint)enemyEnd5;
-(CGPoint)enemyEnd6;
-(CGPoint)enemyEnd7;
-(CGPoint)enemyEnd8;
*/
 
-(CGPoint)guitarrist1Position;
-(CGPoint)guitarrist2Position;
-(CGPoint)vocalPosition;
-(CGPoint)drummerPosition;
-(CGPoint)bassPosition;

-(CGPoint)calculateAnchorPoint:(CGPoint)anchorPos width:(int)w height:(int)h;
-(DeviceType)getDeviceType;
-(NSString *)addZeroesToNumber:(NSString*)number;
-(CCSprite *)getSpriteWithCoinAnimation;

@end
