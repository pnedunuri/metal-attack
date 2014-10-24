//
//  ScrollingBG.m
//  EightbitShooter
//
//  Created by Rafael Munhoz on 18/09/14.
//
//

#import "ScrollingBG.h"

@implementation ScrollingBG

CCSprite *visibleBG;
CCSprite *rightBG;
CCSprite *leftBG;
CCSprite *upperBG;
CCSprite *lowerBG;
CCSprite *upperRightBG;
CCSprite *lowerLeftBG;


+(CCScene *)scene
{
    // 'scene' is an autorelease object.
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object.
    ScrollingBG *layer = [ScrollingBG node];
    
    // add layer as a child to scene
    [scene addChild: layer];
    
    // return the scene
    return scene;
}

-(void)onEnterTransitionDidFinish
{
    NSLog(@"onEnterTransitionDidFinish scrolling");
    [super onEnterTransitionDidFinish];
    [self createScrolling];
}

-(void)createScrolling
{
    NSLog(@"Init scrolling BG");
    
    CCSprite *fixBg = [[CCSprite alloc] initWithImageNamed:@"fixbg.jpg"];
    [fixBg setAnchorPoint:ccp(0,0)];
    //[self addChild:fixBg z:-1];
    
    visibleBG = [[CCSprite alloc] initWithFile:@"doodlefinal_iphone5.jpg"];
    //background1 = [[CCSprite alloc] initWithFile:@"doodlefinal_iphone5_paint.png"];
    [visibleBG setAnchorPoint:ccp(0,0)];
    [visibleBG setPosition:ccp(0,0)]; // this solves the first flicker problem
    [self addChild:visibleBG z:-1];
    
    rightBG = [[CCSprite alloc] initWithFile:@"doodlefinalmark_iphone5.jpg"];
    //background2 = [[CCSprite alloc] initWithFile:@"doodlefinal_iphone5_paint.png"];
    [rightBG setAnchorPoint:ccp(0,0)];
    [rightBG setPosition:ccp(320,0)];
    [self addChild:rightBG z:-1];
    
    leftBG = [[CCSprite alloc] initWithFile:@"doodlefinal_iphone5_blue.jpg"];
    //background2 = [[CCSprite alloc] initWithFile:@"doodlefinal_iphone5_paint.png"];
    [leftBG setAnchorPoint:ccp(0,0)];
    [leftBG setPosition:ccp(-320,0)];
    [self addChild:leftBG z:-1];
    
    upperBG = [[CCSprite alloc] initWithFile:@"doodlefinalmark_iphone5.jpg"];
    //background2 = [[CCSprite alloc] initWithFile:@"doodlefinal_iphone5_paint.png"];
    [upperBG setAnchorPoint:ccp(0,0)];
    [upperBG setPosition:ccp(0,568)];
    [self addChild:upperBG z:-1];
    
    lowerBG = [[CCSprite alloc] initWithFile:@"doodlefinal_iphone5_yellow.jpg"];
    //background2 = [[CCSprite alloc] initWithFile:@"doodlefinal_iphone5_paint.png"];
    [lowerBG setAnchorPoint:ccp(0,0)];
    [lowerBG setPosition:ccp(0,-568)];
    [self addChild:lowerBG z:-1];
    
    lowerLeftBG = [[CCSprite alloc] initWithFile:@"doodlefinal_iphone5_green.jpg"];
    //background2 = [[CCSprite alloc] initWithFile:@"doodlefinal_iphone5_paint.png"];
    [lowerLeftBG setAnchorPoint:ccp(0,0)];
    [lowerLeftBG setPosition:ccp(-320,-568)];
    [self addChild:lowerLeftBG z:-1];
    
    [self scheduleUpdate];

}

-(void)moveBgToUpperRight
{
    if (((int) visibleBG.position.x >= 320) && ((int) visibleBG.position.y >= 568)) {
        
        id bgaux = visibleBG;
        visibleBG = lowerLeftBG;
        lowerLeftBG = bgaux;
        [visibleBG setPosition:ccp(-0.5, -0.871)];
        [lowerLeftBG setPosition:ccp(-320,-568)];
        [leftBG setPosition:ccp(-320, 0)];
        [lowerBG setPosition:ccp(0,-568)];

    }
    
    /*
    if (( leftBG.position.x >= 0) && (leftBG.position.y >= 568)){
        
     
        id bgaux = leftBG;
        leftBG = upperBG;
        upperBG = bgaux;
        //[leftBG setPosition:ccp(0,568)];
        [upperBG setPosition:ccp(-320,0)];
        
        [leftBG setPosition:ccp(-320 + leftBG.position.x , -1 * (leftBG.position.y - 568))]; // correction
    
        //ajust = true;
    }*/
    
    /*
    if (visibleBG.position.x <= -319) {
        // it is completly out of the screen now it is required to redraw
        //NSLog(@"Change bg !");
        id bgaux = visibleBG;
        visibleBG = rightBG;
        rightBG = bgaux;
        [rightBG setPosition:ccp(318, 0)];
    }*/
    
    // x and y speed proportion 1136/640 = 1.775 result in 1.5 * 1.775 =
    //if (!ajust){
    //[visibleBG setPosition:ccpAdd(visibleBG.position, ccp(1.5, 2.6625))];
    //[lowerLeftBG setPosition:ccpAdd(lowerLeftBG.position, ccp(1.5, 2.6625))];
    //[leftBG setPosition:ccpAdd(leftBG.position, ccp(1.5, 2.6625))];
    //[lowerBG setPosition:ccpAdd(lowerBG.position, ccp(1.5, 2.6625))];
        //[upperBG setPosition:ccpAdd(upperBG.position, ccp(1.5, 2.6625))];
    //}
    
    //5.325
    
    [visibleBG setPosition:ccpAdd(visibleBG.position, ccp(3, 5.325))];
    [lowerLeftBG setPosition:ccpAdd(lowerLeftBG.position, ccp(3, 5.325))];
    [leftBG setPosition:ccpAdd(leftBG.position, ccp(3, 5.325))];
    [lowerBG setPosition:ccpAdd(lowerBG.position, ccp(3, 5.325))];
    
    
    
}

-(void)moveBgRightToLeft
{
    [visibleBG setPosition:ccpAdd(visibleBG.position, ccp(-1.5, 0))];
    [rightBG setPosition:ccpAdd(rightBG.position, ccp(-1.5, 0))];
    if (visibleBG.position.x <= -319) {
        // it is completly out of the screen now it is required to redraw
        //NSLog(@"Change bg !");
        id bgaux = visibleBG;
        visibleBG = rightBG;
        rightBG = bgaux;
        [rightBG setPosition:ccp(318, 0)];
    }
}

- (void)update:(ccTime)dt
{
    //NSLog(@"Update Scrolling BG") Right movement;
    
    // I found a difference, keeping the same values for the parameters
    // but change the picture genrated by paint instead of gimp
    // the fliccker disapear but using a gimp genreated image the flicker
    // appears again with the same parameters.
    //[self moveBgRightToLeft];
    [self moveBgToUpperRight];
    
    
}

@end
