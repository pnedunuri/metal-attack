//
//  BandLevelScene.h
//  MetalAttack
//
//  Created by Rafael Munhoz on 30/10/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MockSprite.h"


@interface BandLevelScene : CCNode {
    
    CCSprite *leadGuitar;
    CCSprite *powerGirl;
    MockSprite *evilChild;

}

@property(nonatomic,retain) CCSprite *leadGuitar;
@property(nonatomic,retain) CCSprite *powerGirl;
@property(nonatomic,retain) MockSprite *evilChild;

@end
