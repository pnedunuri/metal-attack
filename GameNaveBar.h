//
//  GameNaveBar.h
//  EightbitShooter
//
//  Created by Rafael Munhoz on 24/09/14.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameNaveBar : CCNodeColor

-(id)initWithDelegagte:(id)delegate;

@end

@protocol navBarProtocol <NSObject>

-(void)doBackMenu;
-(void)doRestart;
-(void)doStore;
-(void)doNext;

@end