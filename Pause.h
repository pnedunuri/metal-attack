//
//  Pause.h
//  EightbitShooter
//
//  Created by Rafael Munhoz on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BandGamePlay.h"


@interface Pause : CCNodeColor
{
    BandGamePlay *gameplayController;
}

//+(CCScene *) scene;
+(CCNodeColor *) pauseWithGamePlay:(BandGamePlay *) gamePlayScene;
-(id)initWithGamePlay:(BandGamePlay *)gamePlayScene;

@property (nonatomic, retain) BandGamePlay *gameplayController;

@end
