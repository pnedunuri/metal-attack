//
//  MotherScene.m
//  EightbitShooter
//
//  Created by Rafael Munhoz on 21/09/14.
//
//

#import "MotherScene.h"

@implementation MotherScene

@synthesize userinfo;

CCSprite *doorUp;
CCSprite *doorDown;

+(CCScene *)scene
{
    // 'scene' is an autorelease object.
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object.
    MotherScene *layer = [MotherScene node];
    
    // add layer as a child to scene
    [scene addChild: layer];
    
    // return the scene
    return scene;
}

-(id)init
{
    // first resolution for iphone 5 and ipad, this is only for iphone 5
    
    if( (self=[super initWithColor:[[CCColor alloc] initWithCcColor4b:ccc4(236, 56, 57, 0)]])) {
        NSLog(@"Init scrolling BG");
        
        doorUp = [[CCSprite alloc] initWithImageNamed:@"doorUp.png"];
        doorDown = [[CCSprite alloc] initWithImageNamed:@"doorDown.png"];
        
        [doorUp setScale:0.5];
        [doorDown setScale:0.5];
        
        [doorUp setAnchorPoint:ccp(0,0)];
        [doorDown setAnchorPoint:ccp(0,0)];
        
        //defining door close position
        
        [doorUp setPosition:ccp(0,240)];
        [doorDown setPosition:ccp(0,0)];
        

        [self addChild:doorDown z:101];
        [self addChild:doorUp z:101];
        
        //check the device type
        
    
    }
    
    return self;
}

-(void)openDoor
{
    // call this method when entering the scene
    
    id moveUpDoor = [CCActionMoveTo actionWithDuration:1.5 position:ccp(0,570)];
    id endMoveUpDoor = [CCActionCallFunc actionWithTarget:self selector:@selector(doEndMoveUpDoor)];
    id moveUpDoorElastic = [CCActionEaseBounceOut actionWithAction:moveUpDoor];
    
    id moveUpDoorSequence = [CCActionSequence actions:moveUpDoorElastic, endMoveUpDoor, nil];
    [doorUp runAction:moveUpDoorSequence];

    id moveDownDoor = [CCActionMoveTo actionWithDuration:1.5 position:ccp(0,-320)];
    id moveDownDoorElastic = [CCActionEaseBounceOut actionWithAction:moveDownDoor];
    [doorDown runAction:moveDownDoorElastic];
}


-(void)closeDoor
{
    // call this method when leaving the scene
    
    id moveUpDoor = [CCActionMoveTo actionWithDuration:0.5 position:ccp(0,240)];
    id endMoveUpDoor = [CCActionCallFunc actionWithTarget:self selector:@selector(doEndMoveDownDoor)];
    
    id moveUpDoorElastic = [CCActionEaseBounceOut actionWithAction:moveUpDoor];
    id moveUpDoorSequence = [CCActionSequence actions:moveUpDoorElastic, endMoveUpDoor, nil];
    [doorUp runAction:moveUpDoorSequence];
    
    id moveDownDoor = [CCActionMoveTo actionWithDuration:0.5 position:ccp(0,0)];
    id moveDownDoorElastic = [CCActionEaseBounceOut actionWithAction:moveDownDoor];
    [doorDown runAction:moveDownDoorElastic];
    
}

-(void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    NSLog(@"onEnterTransitionDidFinish");
    //[self openDoor];
}

-(void)onEnter
{
    [super onEnter];
    NSLog(@"onEnterScene");
    [self openDoor];
}

-(void)onExit
{
    [super onExit];
    NSLog(@"onExit");
    //[self closeDoor];
}

-(void)doEndMoveDownDoor
{
    NSLog(@"doEndMoveDownDoor");
}

-(void)doEndMoveUpDoor
{
    NSLog(@"doEndMoveUpDoor");
}


@end
