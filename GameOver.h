//
//  GameOver.h
//  EightbitShooter
//
//  Created by Rafael Munhoz on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MainMenu.h"

@interface GameOver : CCLayer

+(CCScene *)sceneWithNextLevel:(int)number;

@end
