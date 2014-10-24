//
//  MotherScene.h
//  EightbitShooter
//
//  Created by Rafael Munhoz on 21/09/14.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MotherScene : CCLayerColor
{
    float userinfo;
}

@property(nonatomic) float userinfo;

+(CCScene *)scene;
-(void)openDoor;
-(void)closeDoor;
-(id)init;

-(void)doEndMoveUpDoor:(id)node;
-(void)doEndMoveDownDoor:(id)node;
-(void)onEnterTransitionDidFinish;
-(void)onEnter;
-(void)onExit;


@end
