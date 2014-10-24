//
//  BandVault.m
//  EightbitShooter
//
//  Created by Rafael Munhoz on 12/03/13.
//
//

#import "BandVault.h"

@implementation BandVault

@synthesize drummerId;
@synthesize guitar1Id;
@synthesize guitar2Id;
@synthesize bassId;
@synthesize vocalId;
@synthesize bandCoins;
@synthesize highScore;
@synthesize drummerIndex;
@synthesize guitar1Index;
@synthesize guitar2Index;
@synthesize bassIndex;
@synthesize vocalIndex;
@synthesize genericItems;
@synthesize firstRun;


+(id)sharedInstance
{
	//Singleton Implementation
    //We can initialize the selected band guys at this point, setting the index position of each one
    static id master = nil;
	
	@synchronized(self)
	{
		if (master == nil){
            master = [self new];
            [master setDrummerIndex:0];
            [master setGuitar1Index:0];
            [master setGuitar2Index:1];
            [master setVocalIndex:0];
            [master setBassIndex:0];
        }
	}
    return master;
}

//include a method here to return all owned items

-(void)consumeItem:(NSString *)itemid
{
    // I will do the band first
    /*
    NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
    NSData *loadEncodedObject = [userdef objectForKey:itemid];
    BandVaultItem *vaultItem = [NSKeyedUnarchiver unarchiveObjectWithData:loadEncodedObject];
     */
}

-(void)storeItem:(NSString *)itemid
{
    NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
    NSData *loadEncodedObject = [userdef objectForKey:itemid];
    BandVaultItem *vaultItem = [NSKeyedUnarchiver unarchiveObjectWithData:loadEncodedObject];
    
    if (vaultItem) {
        int value =  [vaultItem.qtd intValue];
        value = value + 1;
        vaultItem.qtd = [[NSNumber alloc] initWithInt:value];
    }else{
        vaultItem = [[BandVaultItem alloc] init];
        vaultItem.appId = itemid;
        vaultItem.owned = [[NSNumber alloc] initWithBool:YES];
        vaultItem.selected = [[NSNumber alloc] initWithBool:NO];
        vaultItem.qtd = [[NSNumber alloc] initWithInt:1];
    }
    
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:vaultItem];
    [userdef setObject:encodedObject forKey:itemid];
}

-(void)selectBandGuy:(NSString *)itemid bandGuyType:(int)bandType oldSelectedGuy:(NSString *)itemId;
{
    // this method will be called when the player selects a new band guy
    // the other selected band guy needs to be unselected
    // maybe it will be good to include a new parameter on the method regarding
    // to the id of the other selected item
    NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
    NSData *loadEncodedObject = [userdef objectForKey:itemid];
    BandVaultItem *vaultItem = [NSKeyedUnarchiver unarchiveObjectWithData:loadEncodedObject];

    vaultItem.selected = [[NSNumber alloc] initWithBool:YES];
    
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:vaultItem];
    [userdef setObject:encodedObject forKey:itemid];
    
    switch (bandType) {
        case 0:
            //guitarrist1 check if it works
            [self setGuitar1Index:vaultItem.indexPosition];
            break;
        case 1:
            //guitarrist2 check if it works
            [self setGuitar2Index:vaultItem.indexPosition];
            
            // and so on, I will do for this two first and change it again
            
        default:
            break;
    }
    
}

-(void)storeBandGuy:(NSString *)itemid indexPosition:(int)pos
{
    //this method will be called when the player buys a new band guy
    //or on the first time to store the default band guys
    
    NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
   
    BandVaultItem *vaultItem = [[BandVaultItem alloc] init];
    vaultItem = [[BandVaultItem alloc] init];
    vaultItem.appId = itemid;
    vaultItem.owned = [[NSNumber alloc] initWithBool:YES];
    vaultItem.selected = [[NSNumber alloc] initWithBool:NO];
    
    vaultItem.qtd = [[NSNumber alloc] initWithInt:1];
    vaultItem.indexPosition = [[NSNumber alloc] initWithInt:pos];
    
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:vaultItem];
    [userdef setObject:encodedObject forKey:itemid];
    

}

-(void)updateBandCoins:(int)coins
{
    // this method will update the band coins
    // to subtract a quantity pass the value with signal -
    NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
    self.bandCoins = self.bandCoins + coins;
    [userdef setInteger:self.bandCoins forKey:@"coins"];
}

-(void)loadAllOwnedBandGuys
{
    //????
}

-(BandVaultItem *)getBandVaultByItemId:(NSString *)itemid
{
    // this method will return the bandvault item by itemid
    NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
    //NSData *loadEncodedObject = [userdef dataForKey:itemid];
    NSData *loadEncodedObject = [userdef objectForKey:itemid];
    
    
    if (loadEncodedObject != nil) {
        BandVaultItem *vaultItem = [NSKeyedUnarchiver unarchiveObjectWithData:loadEncodedObject];
        return vaultItem;
    }else{
        return nil;
    }
}


@end
