//
//  RobotBlaster.m
//  EightbitShooter
//
//  Created by Rafael Munhoz on 2/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RobotBlaster.h"
#import "UniversalInfo.h"
#import "CCAnimation.h"

/*
    Enemy variable parameters
    Enemy name
    Armor
    WeaponDamage
    Score Points
    Time to reach hero
    Number of frames

    By default all the enemies animations will have 3 frames and will be divided into 
    two groups, the normal walking animation that will be present on frames 1 to 2 and the 
    attack animation that will be on frames 2 to 3. 

    Otimization initialize all animation frames on the creation of the enemy
 
 */

@implementation RobotBlaster

/*
 * Divides the animation into walking animation and attack animation
 */
-(void)divideAnimations:(CCSpriteFrame *)frame animFrames:(NSMutableArray *)animFrames
           attackFrames:(NSMutableArray *)attackFrames frameidx:(int)i{
    
    // this method will check too if the type of enemy is autodestruction, if it is the case
    // the logic below will change with the frames of the auto destruction for attachframes.
    
    if (self.attackType == AUTODESTRUCTION){
        NSLog(@"Autodestruction");
        
        if (i <= 2){
            // moviment animation
            [animFrames addObject:frame];
        }else{
            // autodestruction animation
            [attackFrames addObject:frame];
        }
    
        
    }else{
        switch (i) {
            case 1:
                [animFrames addObject:frame];
                break;
            case 2:
                [animFrames addObject:frame];
                [attackFrames addObject:frame];
                break;
            case 3:
                [attackFrames addObject:frame];
                break;
            default:
                break;
        }
    }

}

-(id)initwithStartPosition:(CGPoint)position actionTime:(double)time delegate:(id)scnDelegate enemyParams:(EnemyParams *)params enemyPosition:(EnemyPositions)defPosition shootEndPos:(CGPoint)shootEnd;
{
    [super init];
    //self = [super init];
    //if(self) {
        self.activeShoots = [[NSMutableArray alloc] init];
        self.shootPosition = shootEnd;
        self.initialPosition = position;
        self.armor = params.armor;
        self.weaponDamage = params.weaponDamage;
        self.scorePoints = params.scorePoints;
        self.timeToReach = params.timeToReach;
        self.typeOfPowerUp = params.typeOfPowerUp;
        self.name = params.enemyName;
        self.frames = params.numberOfFrames;
        self.definedPosition = defPosition;
        self.attackType = params.atackType;
        self.isMeeleAttacking = false;
        self.isInMovement = false;
        self.shootStyle = params.shootStyle;
        self.shootStartPosition = params.shootStartPosition;
        
        id attackAnim;
        id endAnimationCallback;
                
        NSMutableArray *animFrames = [[NSMutableArray alloc] init];
        NSMutableArray *attackFrames = [[NSMutableArray alloc] init];
        
        self.enemySprite = [[CCSprite alloc] init];

        if ((defPosition == POS8) || (defPosition == POS7) || (defPosition == POS1)){
            self.shootZIndex = 49;
            for(int i = 1; i <= [self frames]; i++) {
                NSString *frameName = [[self name] stringByAppendingString:@"_back_%d.png"];
                CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:frameName,i]];
                [self divideAnimations:frame animFrames:animFrames attackFrames:attackFrames frameidx:i];
            }
            if (defPosition == POS7) {
                //self.enemySprite.flipX = YES;
            }
        }else if ((defPosition == POS3) || (defPosition == POS4) || (defPosition == POS5)) {
            self.shootZIndex = 30;
            for(int i = 1; i <= [self frames]; i++) {
                NSString *frameName = [[self name] stringByAppendingString:@"_front_%d.png"];
                CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:frameName,i]];
                
                [self divideAnimations:frame animFrames:animFrames attackFrames:attackFrames frameidx:i];
            }
            if (defPosition == POS5) {
                //self.enemySprite.flipX = YES;
            }
        }else{
            self.shootZIndex = 30;
            for(int i = 1; i <= [self frames]; i++) {
                NSString *frameName = [[self name] stringByAppendingString:@"_left_%d.png"];
                CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:frameName,i]];
                [self divideAnimations:frame animFrames:animFrames attackFrames:attackFrames frameidx:i];
            }
            self.enemySprite.flipX = YES;
            if (defPosition == POS2) {
                self.enemySprite.flipX = NO;
            }
        }
            
        enemySprite.scaleX = 0.50;
        enemySprite.scaleY = 0.50;
    
        CCAnimation *animation = [CCAnimation animationWithSpriteFrames:animFrames delay:0.09f];
        CCAnimation *attackAnimation = [CCAnimation animationWithSpriteFrames:attackFrames delay:0.09f];
    
        self.enemySprite.position = position;
        self.enemyAction = [CCActionRepeatForever actionWithAction:[CCActionAnimate actionWithAnimation:animation]];
    
        if (self.attackType == MEELEE){
            
            attackAnim = [CCActionAnimate actionWithAnimation: attackAnimation];
            endAnimationCallback = [CCActionCallFunc actionWithTarget:self selector: @selector(doEndMeeleAttackAnim)];
            self.enemyAttack = [CCActionSequence actions: attackAnim, endAnimationCallback, nil];

        }else{
        
            attackAnim = [CCActionAnimate actionWithAnimation: attackAnimation];
            endAnimationCallback = [CCActionCallFunc actionWithTarget:self selector: @selector(doEndAttackAnim:)];
            self.enemyAttack = [CCActionSequence actions: attackAnim, endAnimationCallback, nil];
        }
        
        // include here the attackAction animation with the previous selected frames
        
        [[self enemySprite] runAction:[self enemyAction]];

        self.delegate = scnDelegate;
        //[[CCScheduler sharedScheduler] scheduleSelector:@selector(startMovement:) forTarget:self interval:time paused:NO];
    
        [self schedule:@selector(startMovement) interval:time];
    
    //}
    return self;
}

-(void)restartMovement
{
    NSLog(@"Restart Movement");
    
    [[self enemySprite] runAction:[self enemyAction]];
    [[self enemySprite] runAction:[CCActionMoveTo actionWithDuration:[self timeToReach]
                                                      position:[[UniversalInfo sharedInstance] screenCenter]]];
}

-(void)startMovement
{
    if ([[self delegate] isGameOver] == NO) {
        [[self delegate] addEnemySprite:self];
        [[self enemySprite] runAction:[CCActionMoveTo actionWithDuration:[self timeToReach]
                                                          position:[[UniversalInfo sharedInstance] screenCenter]]];
        self.isInMovement = YES;
    }
    
   [self unscheduleAllSelectors];
    
    //[[CCScheduler sharedScheduler] unscheduleAllSelectorsForTarget:self];
    //check if this robot can fire according robot definition if so schedule a fire action
    if ([[self delegate] isGameOver] == NO){
        
        if (self.attackType == WALK_SHOOT){
            if ((self.definedPosition == POS6) || (self.definedPosition == POS2)) {
                // this is necessary to avoid the left and right enemies to invade the band space
                // maybe there is another better solution
                [self schedule:@selector(fireWeapon:) interval:1];
                //[[CCScheduler sharedScheduler] scheduleSelector:@selector(fireWeapon:) forTarget:self
                  //                                     interval:1 paused:NO];
            }else{
                //[[CCScheduler sharedScheduler] scheduleSelector:@selector(fireWeapon:) forTarget:self
                //                                     interval:0.5 + arc4random() % 11 * 0.1 paused:NO];
                
                [self schedule:@selector(fireWeapon) interval:0.5 + arc4random() % 11 * 0.1];
            }
         }
    }
}

-(void)doEndGenHitAnim:(id)node
{
    [[self delegate] removeChild:node];
}

-(void)performGeneralHitAnimation:(CGPoint) hitPoint
{
    CCSprite *hitSprite = [[CCSprite alloc] init];
    hitSprite.position = hitPoint;
    [[self delegate] addChild:hitSprite z:50];
    
    NSMutableArray *blastAnimFrames = [[NSMutableArray alloc] init];
    for(int i = 1; i <= 5; ++i) {
        [blastAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"enemy_hit_0%d.png", i]]];
    }
    
    CCAnimation *blastAnim = [CCAnimation
                              animationWithSpriteFrames:blastAnimFrames delay:0.05f];
    
    id animation = [CCActionAnimate actionWithAnimation: blastAnim];
    id callback = [CCActionCallFunc actionWithTarget:self selector: @selector(doEndGenHitAnim:)];
    id sequence = [CCActionSequence actions: animation, callback, nil];
    
    hitSprite.scaleX = 0.75;
    hitSprite.scaleY = 0.75;
    
    [hitSprite runAction:sequence];
    
}

-(void)meeleAttack:(BandSprite *)bandsprite bandComponent:(BandComponents)component hitrect:(CGRect)rect;
{
    if (!self.isMeeleAttacking){
        //NSLog(@"Meele Attack");
        self.bandsprite = bandsprite;
        self.hitRect = rect;
        self.hitComponent = component;
        self.isMeeleAttacking = YES;
        self.isInMovement = NO;
        [[self enemySprite] stopAllActions];
        [[self enemySprite] runAction:self.enemyAttack];
    }
}

-(void)performAutoDestruction
{
    // include doEndDeathAnimation to remove the sprite from the scene.
    //NSLog(@"Perform auto destruction");
    if ([[self delegate] isGameOver] == NO){
        [[self enemySprite] stopAllActions];
        [[self enemySprite] runAction:self.enemyAttack];
        [self unscheduleAllSelectors];
        //[[CCScheduler sharedScheduler] unscheduleAllSelectorsForTarget:self];
    }
}

-(void)performDeath
{
    [[self enemySprite] stopAllActions];
    [self unscheduleAllSelectors];
    //[[CCScheduler sharedScheduler] unscheduleAllSelectorsForTarget:self];
    NSMutableArray *blastAnimFrames = [[NSMutableArray alloc] init];
    for(int i = 1; i <= 12; ++i) {
        [blastAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"enemy_die%d.png", i]]];
    }
    
    CCAnimation *blastAnim = [CCAnimation
                             animationWithSpriteFrames:blastAnimFrames delay:0.07f];

    id animation = [CCActionAnimate actionWithAnimation: blastAnim];
    id callback = [CCActionCallFunc actionWithTarget:self selector: @selector(doEndDeathAnimation:)];
    id sequence = [CCActionSequence actions: animation, callback, nil];

    [[self enemySprite] runAction:sequence];
}

-(void)doEndMeeleAttackAnim
{
    //NSLog(@"Do end meele attack anim");
    float updatedArmor = [self.bandsprite hitByEnemy:self.weaponDamage component:self.hitComponent rect:self.hitRect];
    self.isMeeleAttacking = false;
    if (updatedArmor <= 0) {
        [self restartMovement];
    }
}

-(CGRect)meeleRect
{
    // it will be needed to check this rect for all meele enemies and all positions, it will be alot of work
    // I will keep it for the future.
    return CGRectMake(self.enemySprite.position.x + 20, self.enemySprite.position.y + 25, 20, 20);
}

-(void)doEndAttackAnim:(id)node
{
    //NSLog(@"Do end attack anim");
    if (self.attackType == MEELEE){
        //NSLog(@"Do end meele attack!");
    }else if (self.attackType == AUTODESTRUCTION){
        [[self delegate] removeEnemySprite:[self enemySprite]];
    }else{
        NSString *bulletName = [[self name] stringByAppendingString:@"_bullet.png"];
        
        CCSprite *robotShootSprite = [[CCSprite alloc] initWithImageNamed:bulletName];
        
        
        
        robotShootSprite.scaleX = 0.50;
        robotShootSprite.scaleY = 0.50;
        
        // calculate the correct shoot position to match the animation
        NSLog(@"Fire with position %f, %f", self.enemySprite.position.x, self.enemySprite.position.y);
        // for each enemy it will be required to set the origin shoot position
        ccpAdd(self.enemySprite.position, ccp(8,31)); // divorcedwoman_left (8,90) rotation
                                                      // skate_guy_left (2,30) no rotation
                                                      // The_Gardener_left (5,10) no rotation but can be pulsing
                                                      // Cheerleader_left (7,30) no rotation
                                                      // Cowbowy_left (30,35) rotation
                                                      // drunk_left (0,45) rotation
                                                      // furious_left (-20,25) rotation
                                                      // waitress_left (10,50) no rotation
                                                      // whore_left (-20, -60) rotation
                                                      // bully_left (20,30) no rotation
                                                      // CrazyTeacher rotation (20,40)
        
    
        [robotShootSprite setPosition:ccpAdd(self.enemySprite.position, self.shootStartPosition)];
        
        int positionRandX = arc4random() % 100;
        int positionRandY = arc4random() % 100;
        
        
        // The shoot end position is not the center is the opost position
        NSLog(@"Fire target position %d, %d",positionRandX,positionRandY);
        CGPoint lowAccyrancyPoint = CGPointMake(positionRandX + self.shootPosition.x, positionRandY+self.shootPosition.y);
        
        CCActionRotateBy *rot = [CCActionRepeatForever actionWithAction:[CCActionRotateBy actionWithDuration:0.1 angle: 360]];
        
        id actionRobotFire;
        
        if (self.shootStyle == JUMP){
            actionRobotFire = [CCActionJumpTo actionWithDuration:2 position:lowAccyrancyPoint height:250 jumps:3];
        }else{
            actionRobotFire = [CCActionMoveTo actionWithDuration:2 position:lowAccyrancyPoint];
        }
        
        id endFireRobotCallBack = [CCActionCallFunc actionWithTarget:self selector:@selector(doEndRobotFire:)];
        id actionSequence = [CCActionSequence actions:actionRobotFire, endFireRobotCallBack, nil];
        
        // add the shoot sprite to the array to be checked for collision
        [[self activeShoots] addObject:robotShootSprite];
        [[self delegate] addChild:robotShootSprite z:self.shootZIndex];
        
        if (self.shootStyle == ROTATION) {
            [robotShootSprite runAction:rot];
        }
    
        [robotShootSprite runAction:actionSequence];
    }
}


-(void)fireWeapon
{
    if ([[self delegate] isGameOver] == NO){
        //include a random factor maybe the robot cant reach the hero, if we dont put
        //this factor the hit will happen every time
        NSLog(@"Fire weapon in RobotBlaster fireeee");
        //NSLog(@"Game State %ld",[[self delegate] state]);
        // put a parameter here to check if the robot stops before shoot
        // to stop the movement of the enemy it is required to ensure that
        // the enemy is on the screen, I will comment this for a while
        // another problem is that stopAllActions stops the animation too
        // so it will be nice if we play another animation here
        [[self enemySprite] stopAllActions];
        [[self enemySprite] runAction:self.enemyAttack];
    }else{
        NSLog(@"Turn of all timers for fire robot laser");
        [self unscheduleAllSelectors];
        //[[CCScheduler sharedScheduler] unscheduleAllSelectorsForTarget:self];
    }
}

-(void)doEndRobotFire:(id)node
{
    NSLog(@"End robot fire with some effect can be a fade");
    [node runAction:[CCActionFadeTo actionWithDuration:1.0f opacity:0]];
    //removes the shoot as it will be disapear and will not be considered on the colision
    [[self activeShoots] removeObject:node];
}

-(void)doEndDeathAnimation:(id)node
{
    [[self delegate] removeEnemySprite:[self enemySprite]];
}

-(int)receiveHeroShoot:(float)damage killNow:(BOOL)value shootRect:(CGRect)rect;
{
    if (value == NO) {
        self.armor = self.armor - damage;
        [self performGeneralHitAnimation:rect.origin];
    }else{
        self.armor = 0;
    }
    
    if (self.armor <= 0) {
        [self performDeath];
        return [self scorePoints];
    }else{
        
        CCSprite *impact = [[CCSprite alloc] init];
        impact.position = [[self enemySprite] position];
        
        NSMutableArray *blastAnimFrames = [[NSMutableArray alloc] init];
        for(int i = 1; i <= 3; ++i) {
            [blastAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"exp%d.png", i]]];
        }
        
        CCAnimation *blastAnim = [CCAnimation 
                                  animationWithSpriteFrames:blastAnimFrames delay:0.1f];
        
        id animation = [CCActionAnimate actionWithAnimation: blastAnim];
        [impact runAction:animation];
        [[self delegate] addChild:impact];
        
        /*
        NSLog(@"Play shoot animation can be spark particles");
        self.enemyParticle = [CCParticleSmoke node];
        self.enemyParticle.texture = [[CCTextureCache sharedTextureCache] addImage: @"smoke.png"];
        self.enemyParticle.position = [[self enemySprite] position];
        self.enemyParticle.startSize = 0.00001;
        self.enemyParticle.endSize = 1.5;
        self.enemyParticle.totalParticles = 20;
        self.enemyParticle.duration = 0.1;
        [[self delegate] addChild:[self enemyParticle]];
        */
        return 0;
    }
}


-(float)autoDestruction
{
    [self setArmor:-1];
    if (self.attackType == AUTODESTRUCTION)
    {
        [self performAutoDestruction];
    }else{
        [self performDeath];
    }
    return [self weaponDamage];
}

-(void)dealloc
{
   
}

@end