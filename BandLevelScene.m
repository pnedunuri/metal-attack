//
//  BandLevelScene.m
//  MetalAttack
//
//  Created by Rafael Munhoz on 30/10/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "BandLevelScene.h"


@implementation BandLevelScene

@synthesize leadGuitar;
@synthesize powerGirl;
@synthesize evilChild;

-(id)init{
    if (self=[super init]) {
        NSLog(@"Init method");
    
        
        if (self.leadGuitar){
            NSLog(@"Lead guitar not nil");
        }
        
        if (self.powerGirl){
            NSLog(@"Power Girl not nil");
        }
    }

    return self;
}

-(void)didLoadFromCCB
{
    //called just after the load of CCB file
    
    NSLog(@"didLoadFromCCB");
    if (self.leadGuitar){
        NSLog(@"Lead guitar not nil");
        NSLog(@"Position of lead gitar %f, %f",self.leadGuitar.position.x, self.leadGuitar.position.y);
    }
    
    if (self.powerGirl){
        NSLog(@"Power Girl not nil");
        NSLog(@"Position of lead gitar %f, %f",self.powerGirl.position.x, self.powerGirl.position.y);
    }
    
    self.userInteractionEnabled = TRUE;
}

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"Touch began !!!");
    //[[[self evilChild] animationManager] runAnimationsForSequenceNamed:@"DieAnimation"];
    
    //CCSprite *guitar = [[self evilChild] getChildByName:@"Guitar" recursively:YES];
    
    //[guitar setRotation:20];
    
    
    NSArray *children = [[self evilChild] children];
    

    
    //[[children firstObject] setRotation:[[children firstObject] rotation] + 10];
    
    //NSLog(@"Number of children %d",[children count]);
}

-(void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"Touch ended");
   [[[self evilChild] animationManager] runAnimationsForSequenceNamed:@"DieAnimation"];
}

-(void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"Touch moved");
}


-(void)onEnter
{
    [super onEnter];
    //[self powerGirl] get
    //[self addChild:self.powerGirl];
    CCAnimationManager *animManager = powerGirl.animationManager;

    
    [animManager runAnimationsForSequenceNamed:@"GuitarAnim"];
    //[animManager runAnimationsForSequenceNamed:@"BodyAnimation"];
    
    [[[self evilChild] animationManager] runAnimationsForSequenceNamed:@"BodyAnimation"];
    //[[[self evilChild] animationManager] runAnimationsForSequenceNamed:@"GuitarAnimation"];
}

@end
