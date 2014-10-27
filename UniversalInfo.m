//
//  UniversalInfo.m
//  EightbitShooter
//
//  Created by Rafael Munhoz on 31/03/13.
//
//  This class will be responsible to map all the game coordinates
//  for ipad/inphone universal version. I dont't know if the best
//  way to do this is checking every time for the device or check just
//  once. This class will hadle some game utility

#import "UniversalInfo.h"
#import "CCAnimation.h"

@implementation UniversalInfo

+ (UniversalInfo *)sharedInstance
{
    //Singleton implementation
    // the instance of this class is stored here
    static UniversalInfo *myInstance = nil;
    // check to see if an instance already exists
    if (nil == myInstance) {
        myInstance  = [[[self class] alloc] init];
        // initialize variables here
    }
    // return the instance of this class
    return myInstance;
}

-(BOOL) isDeviceIpad
{
    NSLog(@"isDeviceIpad");
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return YES;
    }else{
        return NO;
    }
}

-(CGPoint) screenCenter
{
    //NSLog(@"screenCenter");
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return CGPointMake(384, 512);
    }else{
        if ([self getDeviceType] == IPHONE_5) {
            return  CGPointMake(160, 284);
        }else{
            return CGPointMake(160, 240);
        }
    }
}

//***** Band members body position *****//

-(CGPoint)guitarrist1Position
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return CGPointMake(444, 472);
    }else{
        if ([self getDeviceType] == IPHONE_5) {
            return CGPointMake(190, 245);
        }else{
            return CGPointMake(220, 200);
        }
    }
}


-(CGPoint)guitarrist2Position
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return CGPointMake(255, 512); // +40x -40y
    }else{
        return CGPointMake(100, 280);
    }
}

-(CGPoint)bassPosition
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return CGPointMake(535, 522); // -30x -50y
    }else{
        return CGPointMake(250, 300); //
    }
}

-(CGPoint)vocalPosition
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return CGPointMake(360, 420); //+40x -30y
    }else{
        return CGPointMake(150, 210);
    }
}

-(CGPoint)drummerPosition
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return CGPointMake(394, 552);
    }else{
        return CGPointMake(170, 280);
    }
}


/****** Guitar 1 Definitnions ********/

-(int)guita1WeaponLeftx
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        //return 426;
        return self.guitarrist1Position.x + 2;
    }else{
        if ([self getDeviceType] == IPHONE_5) {
            return self.guitarrist1Position.x + 2;
        }else{
            //return 202; // maybe it is not necessary as the
            //position is already defined
            return self.guitarrist1Position.x + 2;
            
        }
    }
}

-(int)guita1WeaponRightx;
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        //return 420;
        return self.guitarrist1Position.x - 4;
    }else{
        if ([self getDeviceType] == IPHONE_5) {
            //return 196;
            return self.guitarrist1Position.x - 4;
        }else{
            //return 196;
            return self.guitarrist1Position.x - 4;
        }
    }
}

-(int)guita1WeaponyRight;
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        //return 512;
        return self.guitarrist1Position.y + 40;
    }else{
        if ([self getDeviceType] == IPHONE_5) {
            //return 220;
            return self.guitarrist1Position.y - 130;
        }else{
            //return 220;
            return self.guitarrist1Position.y + 20;
        }
    }
}

-(int)guita1WeaponyLeft
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        //return 512;
        return self.guitarrist1Position.y + 40;
    }else{
        if ([self getDeviceType] == IPHONE_5) {
            //return 220;
            return self.guitarrist1Position.y - 130;
        }else{
            //return 220;
            return self.guitarrist1Position.y + 20;
        }
    }
}

/****** Guitar 2 Definitnions ********/

-(int)guita2WeaponLeftx
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        //return 219;
        return self.guitarrist2Position.x + 4;
    }else{
        //return 102;
        return self.guitarrist2Position.x + 2;
    }
}

-(int)guita2WeaponRightx;
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        //return 213;
        return self.guitarrist2Position.x - 2;
    }else{
        //return 98;
        return self.guitarrist2Position.x - 2;
        
    }
}

-(int)guita2WeaponyRight;
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        //return 592;
        return self.guitarrist2Position.y + 40;
    }else{
        //return 301;
        return self.guitarrist2Position.y + 101;
    }
}

-(int)guita2WeaponyLeft
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        //return 592;
        return self.guitarrist2Position.y + 40;
    }else{
        //return 301;
        return self.guitarrist2Position.y + 101;
    }
}

/****** Volcalist Definitnions ********/

-(int)vocalWeaponLeftx
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        //return 309; //-50
        return self.vocalPosition.x - 9;
    }else{
        //return 145;
        return self.vocalPosition.x - 5;
    }
}

-(int)vocalWeaponRightx;
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        //return 330; //-50
        return self.vocalPosition.x + 15;
    }else{
        //return 155;
        return self.vocalPosition.x + 5;
    }
}

-(int)vocalWeaponyRight;
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        //return 500;
        return self.vocalPosition.y + 30;
    }else{
        //return 233;
        return self.vocalPosition.y + 23;
    }
}

-(int)vocalWeaponyLeft
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        //return 500;
        return self.vocalPosition.y + 30;
    }else{
        //return 233;
        return self.vocalPosition.y + 23;
    }
}

/****** Bass Definitnions ********/

-(int)bassWeaponLeftx
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        //return 569; // + 400 - 50
        return self.bassPosition.x + 4;
    }else{
        //return 252; // + 200
        return self.bassPosition.x + 2;
    }
}

-(int)bassWeaponRightx;
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        //return 563;
        return self.bassPosition.x - 2;
    }else{
        //return 248;
        return self.bassPosition.x - 2;
    }
}

-(int)bassWeaponyRight;
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        //return 622;
        return self.bassPosition.y + 50;
    }else{
        //return 321; //+10
        return self.bassPosition.y + 21;
    }
}

-(int)bassWeaponyLeft
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        //return 622;
        return self.bassPosition.y + 50;
    }else{
        //return 321; //+10
        return self.bassPosition.y + 21;
    }
}


/*** Enemy creation positions ****/

-(CGPoint)enemyPosition1
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return CGPointMake(-15, -15);
    }else{
        return CGPointMake(-15, -15);
    }
}

-(CGPoint)enemyPosition2
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return CGPointMake(-15, 512);
    }else{
        return CGPointMake(-15, 240);
    }
}

-(CGPoint)enemyPosition3
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return CGPointMake(-15, 1039);
    }else{
        return CGPointMake(-15, 495);
    }
}

-(CGPoint)enemyPosition4
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return CGPointMake(384, 1039);
    }else{
        return CGPointMake(160, 495);
    }
    
}

-(CGPoint)enemyPosition5
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return CGPointMake(768, 1039);
    }else{
        return CGPointMake(335, -15);
    }
}

-(CGPoint)enemyPosition6
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return CGPointMake(768, 512);
    }else{
        return CGPointMake(320, 240);
    }
}

-(CGPoint)enemyPosition7
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return CGPointMake(783, -15);
    }else{
        return CGPointMake(335, -15);
    }
}

-(CGPoint)enemyPosition8
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return CGPointMake(384, -15);
    }else{
        return CGPointMake(160, -15);
    }
}

-(CGPoint)calculateAnchorPoint:(CGPoint)anchorPos width:(int)w height:(int)h
{
    return CGPointMake((1 - anchorPos.x/w), (1 - anchorPos.y/h));
}

-(DeviceType)getDeviceType
{
    float x = [[UIScreen mainScreen] bounds].size.height;
    if (x == 568) {
        // IPHONE 5
        return IPHONE_5;
    }else if (x == 480){
        // IPHONE 4 only retina
        return IPHONE_4;
    }else if (x == 1024){
        return IPAD;
    }else{
        return IPAD_RETINA;
    }
}

-(NSString *)addZeroesToNumber:(NSString*)number
{
    
    
    // max 6 digits
    int zeroesTofill = 4 - [number length];
    NSString *zeroesStr = @"";
    NSString *completeStr = number;
    

    
    for (int i = 0; i <= zeroesTofill; i++) {
        zeroesStr = [zeroesStr stringByAppendingString:@"0"];
    }
    
    completeStr = [zeroesStr stringByAppendingString:number];
    
    return completeStr;
}

-(CCSprite *)getSpriteWithCoinAnimation
{
    NSString *coinFrameName = @"coinflip0";
    id coinAnimFrames = [[NSMutableArray alloc] init];
    
    for(int i = 1; i <= 6; i++) {
        NSString *frameName = [coinFrameName stringByAppendingString:@"%d.png"];
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:frameName,i]];
        [coinAnimFrames addObject:frame];
    }
    
    CCAnimation *animation = [CCAnimation animationWithSpriteFrames:coinAnimFrames delay:0.09f];
    
    id coinAnimation = [CCActionRepeatForever actionWithAction:
                         [CCActionAnimate actionWithAnimation:animation]];
    
    
    CCSprite *coinSprite = [[CCSprite alloc] init];
    [coinSprite runAction:coinAnimation];
    
    return coinSprite;
    
    
}


//***** Store assets definitions and positions ******//
// don't now if this is the best place to put this definitions //


@end
