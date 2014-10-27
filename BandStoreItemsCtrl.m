//
//  ███╗   ███╗███████╗████████╗ █████╗ ██╗          █████╗ ████████╗████████╗ █████╗  ██████╗██╗  ██╗
//  ████╗ ████║██╔════╝╚══██╔══╝██╔══██╗██║         ██╔══██╗╚══██╔══╝╚══██╔══╝██╔══██╗██╔════╝██║ ██╔╝
//  ██╔████╔██║█████╗     ██║   ███████║██║         ███████║   ██║      ██║   ███████║██║     █████╔╝
//  ██║╚██╔╝██║██╔══╝     ██║   ██╔══██║██║         ██╔══██║   ██║      ██║   ██╔══██║██║     ██╔═██╗
//  ██║ ╚═╝ ██║███████╗   ██║   ██║  ██║███████╗    ██║  ██║   ██║      ██║   ██║  ██║╚██████╗██║  ██╗
//  ╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝    ╚═╝  ╚═╝   ╚═╝      ╚═╝   ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
//
//
//
//  BandStoreItemsCtrl.m
//  EightbitShooter
//
//  Created by Rafael Munhoz on 03/04/13.
//
//

#import "BandStoreItemsCtrl.h"
#import "BandVaultItem.h" // remove it just for test
#import "BandVault.h"

@implementation BandStoreItemsCtrl

@synthesize itemsDict;
@synthesize drummers;
@synthesize vocals;
@synthesize guitarrists;
@synthesize basses;
@synthesize coinpacks;
@synthesize generalItems;
@synthesize bandCoins;

NSDictionary *bandItemsDict;
NSSortDescriptor *sort;

+(id)sharedInstance
{
    static id master = nil;
	@synchronized(self)
	{
		if (master == nil){
            master = [self new];
        }
	}
    return master;
}

-(void)loadOwnedItems
{
    // set here the selected band guys
    
    BandVault *bandVault = [BandVault sharedInstance];
    BandVaultItem *vaultItem;
    
    for (int i = 0; i < [[self drummers] count]; i++) {
        vaultItem = [bandVault getBandVaultByItemId:[[[self drummers] objectAtIndex:i] appStoreId]];
        [[drummers objectAtIndex:i] setOwnedBandItem:vaultItem.ownedVaultItem];
        [[drummers objectAtIndex:i] setSelectedBandItem:vaultItem.selectedVaultItem];
        if (vaultItem.selectedVaultItem) {
            [bandVault setDrummerIndex:i];
        }
    }
    
    for (int i = 0; i < [[self vocals] count]; i++) {
        vaultItem = [bandVault getBandVaultByItemId:[[[self vocals] objectAtIndex:i] appStoreId]];
        [[vocals objectAtIndex:i] setOwnedBandItem:vaultItem.ownedVaultItem];
        [[vocals objectAtIndex:i] setSelectedBandItem:vaultItem.selectedVaultItem];
        if (vaultItem.selectedVaultItem) {
            [bandVault setVocalIndex:i];
        }
    }
    
    for (int i = 0; i < [[self guitarrists] count]; i++) {
        vaultItem = [bandVault getBandVaultByItemId:[[[self guitarrists] objectAtIndex:i] appStoreId]];
        [[guitarrists objectAtIndex:i] setOwnedBandItem:vaultItem.ownedVaultItem];
        [[guitarrists objectAtIndex:i] setSelectedBandItem:vaultItem.selectedVaultItem];
        if (vaultItem.selectedVaultItem) {
            [bandVault setGuitar1Index:i];
        }
    }
    
    for (int i = 0; i < [[self basses] count]; i++) {
        vaultItem = [bandVault getBandVaultByItemId:[[[self basses] objectAtIndex:i] appStoreId]];
        [[basses objectAtIndex:i] setOwnedBandItem:vaultItem.ownedVaultItem];
        [[basses objectAtIndex:i] setSelectedBandItem:vaultItem.selectedVaultItem];
        if (vaultItem.selectedVaultItem) {
            [bandVault setBassIndex:i];
        }
    }

}


-(void)savePurchaseditem:(NSString *)itemid
{
    NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
    [userdef setValue:@"YES" forKey:itemid];
}

-(void)populateDrummerData
{
    self.drummers = [[NSMutableArray alloc] init];
    NSDictionary *drummersDict = [bandItemsDict valueForKey:@"DRUMMERS"];
    NSString *drummer;
    BandStoreItem *item;
    
    for (drummer in drummersDict){
        
        NSDictionary *drummerInfo = [drummersDict valueForKey:drummer];
    
        // drummer info is null create it from JSON and store
        item = [[BandStoreItem alloc] init];
        item.appStoreId = [drummerInfo valueForKey:@"appStoreId"];
        item.itemName = [drummerInfo valueForKey:@"name"];
        item.description = [drummerInfo valueForKey:@"description"];
        item.credits = [[drummerInfo valueForKey:@"credits"] intValue];
        item.value = [[drummerInfo valueForKey:@"value"] intValue];
        item.duration = [[drummerInfo valueForKey:@"duration"] intValue];
        item.itemFrmName = [drummerInfo valueForKey:@"itemfrmname"];
        item.itemframes = [[drummerInfo valueForKey:@"frames"] intValue];
        item.storeItemFrmName = [drummerInfo valueForKey:@"storeItemFrmName"];
        item.armor = [[drummerInfo valueForKey:@"armor"] intValue];
        item.ownedBandItem = [[drummerInfo valueForKey:@"owner"] boolValue];
        item.itemType = DRUMMER;
        
        [drummers addObject:item];
    }
    
    self.drummers = [[NSMutableArray alloc] initWithArray:[drummers sortedArrayUsingDescriptors:@[sort]]];
    
    BandVault *bandVault = [BandVault sharedInstance];
    BandVaultItem *vaultItem = [bandVault getBandVaultByItemId:[[drummers firstObject] appStoreId]];
    
    //default values
    if (!vaultItem) {
        [bandVault storeBandGuy:[[drummers firstObject] appStoreId] indexPosition:0];
        [bandVault selectBandGuy:[[drummers firstObject] appStoreId] bandGuyType:DRUMMER oldSelectedGuy:nil];
    }
    
    NSLog(@"Drummer data size %lu",(unsigned long)[drummers count]);
}

-(void)populateVocalData
{
    self.vocals = [[NSMutableArray alloc] init];
    NSDictionary *vocalsDict = [bandItemsDict valueForKey:@"VOCALS"];
    NSString *vocal;
    for (vocal in vocalsDict){
        BandStoreItem *item = [[BandStoreItem alloc] init];
        NSDictionary *vocalInfo = [vocalsDict valueForKey:vocal];
        item.appStoreId = [vocalInfo valueForKey:@"appStoreId"];
        item.itemName = [vocalInfo valueForKey:@"name"];
        item.description = [vocalInfo valueForKey:@"description"];
        item.credits = [[vocalInfo valueForKey:@"credits"] intValue];
        item.value = [[vocalInfo valueForKey:@"value"] intValue];
        item.duration = [[vocalInfo valueForKey:@"duration"] intValue];
        item.itemFrmName = [vocalInfo valueForKey:@"itemfrmname"];
        item.itemArmFrmName = [vocalInfo valueForKey:@"itemArmFrmName"];
        item.storeItemFrmName = [vocalInfo valueForKey:@"storeItemFrmName"];
        item.itemframes = [[vocalInfo valueForKey:@"frames"] intValue];
        item.weaponleftx = [[vocalInfo valueForKey:@"weaponleftx"] intValue];
        item.weaponrightx = [[vocalInfo valueForKey:@"weaponrightx"] intValue];
        item.weaponrighty = [[vocalInfo valueForKey:@"weaponrighty"] intValue];
        item.weaponlefty = [[vocalInfo valueForKey:@"weaponlefty"] intValue];
        item.weaponleftxipad = [[vocalInfo valueForKey:@"weaponleftxipad"] intValue];
        item.weaponrightxipad = [[vocalInfo valueForKey:@"weaponrightxipad"] intValue];
        item.weaponrightyipad = [[vocalInfo valueForKey:@"weaponrightyipad"] intValue];
        item.weaponleftyipad = [[vocalInfo valueForKey:@"weaponleftyipad"] intValue];
        item.anchorrightx = [[vocalInfo valueForKey:@"anchorrightx"] floatValue];
        item.anchorrighty = [[vocalInfo valueForKey:@"anchorrighty"] floatValue];
        item.anchorleftx = [[vocalInfo valueForKey:@"anchorleftx"] floatValue];
        item.anchorlefty = [[vocalInfo valueForKey:@"anchorlefty"] floatValue];
        item.armsize = ccp([[vocalInfo valueForKey:@"armwidth"] intValue], [[vocalInfo valueForKey:@"armheight"] intValue]);
        item.armor = [[vocalInfo valueForKey:@"armor"] floatValue];
        item.shootPower = [[vocalInfo valueForKey:@"shootPower"] floatValue];
        item.ownedBandItem = [[vocalInfo valueForKey:@"owner"] boolValue];
        item.itemType = VOCALIST;

        [vocals addObject:item];
    }
    self.vocals = [[NSMutableArray alloc] initWithArray:[vocals sortedArrayUsingDescriptors:@[sort]]];
    
    BandVault *bandVault = [BandVault sharedInstance];
    BandVaultItem *vaultItem = [bandVault getBandVaultByItemId:[[vocals firstObject] appStoreId]];
    
    //default values
    if (!vaultItem) {
        [bandVault storeBandGuy:[[vocals firstObject] appStoreId] indexPosition:0];
        [bandVault selectBandGuy:[[vocals firstObject] appStoreId] bandGuyType:VOCALIST oldSelectedGuy:nil];
    }

}


-(void)populateGuitarData
{
    self.guitarrists = [[NSMutableArray alloc] init];
    NSDictionary *guitarristsDict = [bandItemsDict valueForKey:@"GUITARRISTS"];
    NSString *guitarrist;
    for (guitarrist in guitarristsDict){
        BandStoreItem *item = [[BandStoreItem alloc] init];
        NSDictionary *guitarristInfo = [guitarristsDict valueForKey:guitarrist];
        item.appStoreId = [guitarristInfo valueForKey:@"appStoreId"];
        item.itemName = [guitarristInfo valueForKey:@"name"];
        item.description = [guitarristInfo valueForKey:@"description"];
        item.credits = [[guitarristInfo valueForKey:@"credits"] intValue];
        item.value = [[guitarristInfo valueForKey:@"value"] intValue];
        item.duration = [[guitarristInfo valueForKey:@"duration"] intValue];
        item.itemFrmName = [guitarristInfo valueForKey:@"itemfrmname"];
        item.itemframes = [[guitarristInfo valueForKey:@"frames"] intValue];
        item.itemArmFrmName = [guitarristInfo valueForKey:@"itemArmFrmName"];
        item.storeItemFrmName = [guitarristInfo valueForKey:@"storeItemFrmName"];
        item.weaponleftx = [[guitarristInfo valueForKey:@"weaponleftx"] intValue];
        item.weaponrightx = [[guitarristInfo valueForKey:@"weaponrightx"] intValue];
        item.weaponrighty = [[guitarristInfo valueForKey:@"weaponrighty"] intValue];
        item.weaponlefty = [[guitarristInfo valueForKey:@"weaponlefty"] intValue];
        item.weaponleftxipad = [[guitarristInfo valueForKey:@"weaponleftxipad"] intValue];
        item.weaponrightxipad = [[guitarristInfo valueForKey:@"weaponrightxipad"] intValue];
        item.weaponrightyipad = [[guitarristInfo valueForKey:@"weaponrightyipad"] intValue];
        item.weaponleftyipad = [[guitarristInfo valueForKey:@"weaponleftyipad"] intValue];
        item.anchorrightx = [[guitarristInfo valueForKey:@"anchorrightx"] floatValue];
        item.anchorrighty = [[guitarristInfo valueForKey:@"anchorrighty"] floatValue];
        item.anchorleftx = [[guitarristInfo valueForKey:@"anchorleftx"] floatValue];
        item.anchorlefty = [[guitarristInfo valueForKey:@"anchorlefty"] floatValue];
        item.armsize = ccp([[guitarristInfo valueForKey:@"armwidth"] intValue], [[guitarristInfo valueForKey:@"armheight"] intValue]);
        item.armor = [[guitarristInfo valueForKey:@"armor"] floatValue];
        item.shootPower = [[guitarristInfo valueForKey:@"shootPower"] floatValue];
        item.ownedBandItem = [[guitarristInfo valueForKey:@"owner"] boolValue];
        item.itemType = GUITARRIST_1;
        
        [guitarrists addObject:item];
    }
    
    self.guitarrists = [[NSMutableArray alloc] initWithArray:[guitarrists sortedArrayUsingDescriptors:@[sort]]];
    
    BandVault *bandVault = [BandVault sharedInstance];
    BandVaultItem *vaultItem = [bandVault getBandVaultByItemId:[[guitarrists firstObject] appStoreId]];
    
    //default values
    if (!vaultItem) {
        [bandVault storeBandGuy:[[guitarrists firstObject] appStoreId] indexPosition:0];
        [bandVault selectBandGuy:[[guitarrists firstObject] appStoreId] bandGuyType:GUITARRIST_1 oldSelectedGuy:nil];
    }

}

-(void)populateBassData
{
    self.basses = [[NSMutableArray alloc] init];
    NSDictionary *bassesDict = [bandItemsDict valueForKey:@"BASSES"];
    NSString *bass;
    for (bass in bassesDict){
        BandStoreItem *item = [[BandStoreItem alloc] init];
        NSDictionary *bassistInfo = [bassesDict valueForKey:bass];
        item.appStoreId = [bassistInfo valueForKey:@"appStoreId"];
        item.itemName = [bassistInfo valueForKey:@"name"];
        item.description = [bassistInfo valueForKey:@"description"];
        item.credits = [[bassistInfo valueForKey:@"credits"] intValue];
        item.value = [[bassistInfo valueForKey:@"value"] intValue];
        item.duration = [[bassistInfo valueForKey:@"duration"] intValue];
        item.itemFrmName = [bassistInfo valueForKey:@"itemfrmname"];
        item.itemArmFrmName = [bassistInfo valueForKey:@"itemArmFrmName"];
        item.storeItemFrmName = [bassistInfo valueForKey:@"storeItemFrmName"];
        item.itemframes = [[bassistInfo valueForKey:@"frames"] intValue];
        item.weaponleftx = [[bassistInfo valueForKey:@"weaponleftx"] intValue];
        item.weaponrightx = [[bassistInfo valueForKey:@"weaponrightx"] intValue];
        item.weaponrighty = [[bassistInfo valueForKey:@"weaponrighty"] intValue];
        item.weaponlefty = [[bassistInfo valueForKey:@"weaponlefty"] intValue];
        item.weaponleftxipad = [[bassistInfo valueForKey:@"weaponleftxipad"] intValue];
        item.weaponrightxipad = [[bassistInfo valueForKey:@"weaponrightxipad"] intValue];
        item.weaponrightyipad = [[bassistInfo valueForKey:@"weaponrightyipad"] intValue];
        item.weaponleftyipad = [[bassistInfo valueForKey:@"weaponleftyipad"] intValue];
        item.anchorrightx = [[bassistInfo valueForKey:@"anchorrightx"] floatValue];
        item.anchorrighty = [[bassistInfo valueForKey:@"anchorrighty"] floatValue];
        item.anchorleftx = [[bassistInfo valueForKey:@"anchorleftx"] floatValue];
        item.anchorlefty = [[bassistInfo valueForKey:@"anchorlefty"] floatValue];
        item.armsize = ccp([[bassistInfo valueForKey:@"armwidth"] intValue],
                           [[bassistInfo valueForKey:@"armheight"] intValue]);
        item.armor = [[bassistInfo valueForKey:@"armor"] floatValue];
        item.shootPower = [[bassistInfo valueForKey:@"shootPower"] floatValue];
        item.ownedBandItem = [[bassistInfo valueForKey:@"owner"] boolValue];
        item.itemType = BASSGUY;
     
        [basses addObject:item];
    }
    self.basses = [[NSMutableArray alloc] initWithArray:[basses sortedArrayUsingDescriptors:@[sort]]];
    
    BandVault *bandVault = [BandVault sharedInstance];
    BandVaultItem *vaultItem = [bandVault getBandVaultByItemId:[[basses firstObject] appStoreId]];
    
    //default values
    if (!vaultItem) {
        [bandVault storeBandGuy:[[basses firstObject] appStoreId] indexPosition:0];
        [bandVault selectBandGuy:[[basses firstObject] appStoreId] bandGuyType:BASSGUY oldSelectedGuy:nil];
    }
}

-(void)populateCoinPackData
{
    self.coinpacks = [[NSMutableArray alloc] init];
    NSDictionary *coinDict = [bandItemsDict valueForKey:@"COINPACK"];
    NSString *pack;
    for (pack in coinDict){
        BandStoreItem *item = [[BandStoreItem alloc] init];
        NSDictionary *coinpackInfo = [coinDict valueForKey:pack];
        item.appStoreId = [coinpackInfo valueForKey:@"appStoreId"];
        item.itemName = [coinpackInfo valueForKey:@"name"];
        item.description = [coinpackInfo valueForKey:@"description"];
        item.credits = [[coinpackInfo valueForKey:@"credits"] intValue];
        item.value = [[coinpackInfo valueForKey:@"value"] intValue];
        item.duration = [[coinpackInfo valueForKey:@"duration"] intValue];
        item.itemFrmName = [coinpackInfo valueForKey:@"itemfrmname"];
        item.itemframes = [[coinpackInfo valueForKey:@"frames"] intValue];
        item.storeItemFrmName = [coinpackInfo valueForKey:@"storeItemFrmName"];
        item.itemType = BAND_COIN_PACK;
        [coinpacks addObject:item];
    }
}

-(void)populateGenericItemData
{
    self.generalItems =[[NSMutableArray alloc] init];
    NSDictionary *genericItemDict = [bandItemsDict valueForKey:@"GENERICITEM"];
    NSString *genericItem;
    
    for (genericItem in genericItemDict) {
        BandStoreItem *item = [[BandStoreItem alloc] init];
        NSDictionary *genericItemInfo = [genericItemDict valueForKey:genericItem];
        item.appStoreId = [genericItemInfo valueForKey:@"appStoreId"];
        item.itemName = [genericItemInfo valueForKey:@"name"];
        item.description = [genericItemInfo valueForKey:@"description"];
        item.credits = [[genericItemInfo valueForKey:@"credits"] intValue];
        item.value = [[genericItemInfo valueForKey:@"value"] intValue];
        item.storeItemFrmName = [genericItemInfo valueForKey:@"storeItemFrmName"];
        item.itemframes = [[genericItemInfo valueForKey:@"frames"] intValue];
        item.ownedBandItem = [[genericItemInfo valueForKey:@"owner"] boolValue];
        item.itemType = GENERIC_ITEM;
        [self.generalItems addObject:item];
    }
}

-(void)loadBandItemsFromJson
{
    //load the band members definitions from a json file
    NSBundle *appBundle = [NSBundle bundleForClass:[self class]];
    NSString *levelDataPath = [appBundle pathForResource:@"bandItemsBasic" ofType:@"json"];
    NSString *jsonString = [NSString stringWithContentsOfFile:levelDataPath encoding:NSUTF8StringEncoding error:nil];
    bandItemsDict = [jsonString JSONValue];
    sort = [NSSortDescriptor sortDescriptorWithKey:@"appStoreId" ascending:YES];
    
    //itemsDict = [[NSDictionary alloc] initWithDictionary:bandItemsDict];
    [self populateDrummerData];
    [self populateGuitarData];
    [self populateVocalData];
    [self populateBassData];
    [self populateCoinPackData];
    [self populateGenericItemData];
    [self loadOwnedItems];
    NSLog(@"Items loaded !");
}

-(void)consumeItem:(BandStoreItem *)item
{
    //This method will consume the item by 1 quantity
}

-(void)storeItem:(BandStoreItem *)item
{
    //This method will add the item
}

-(void)selectItem:(BandStoreItem *)item
{
    //Only valid for band guys the other items will be consumed by consumeItem
}

@end
