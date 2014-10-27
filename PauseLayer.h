//
//  PauseLayer.h
//  EightbitShooter
//
//  Created by Rafael Munhoz on 18/09/14.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BandGamePlay.h"

@interface PauseLayer : CCNodeColor
{
    BandGamePlay *gameplayController;
}

@property (nonatomic, retain) BandGamePlay *gameplayController;

//-(id)init;
-(id)initWithGamePlay:(BandGamePlay *)gamePlayScene;

@end
