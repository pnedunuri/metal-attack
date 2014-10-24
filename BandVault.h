//
//  BandVault.h
//  EightbitShooter
//
//  Created by Rafael Munhoz on 12/03/13.
//
//

#import <Foundation/Foundation.h>
#import "BandVaultItem.h"

@interface BandVault : NSObject

{
    // Indicates the id of the drummer that is selected to be on the band
    NSString *drummerId;
    int drummerIndex;
    // indicates the id of the first guitar that is selected to be on the band
    NSString *guitar1Id;
    int guitar1Index;
    // indicates the id of the second guitar that is selected to be on the band
    NSString *guitar2Id;
    int guitar2Index;
    // indicates the id of the bass that is selected to be on the band
    NSString *bassId;
    int bassIndex;
    // indicates the id of the vocal that is selected to be on the band
    NSString *vocalId;
    int vocalIndex;
    // store the number of coins that the player have
    int bandCoins;
    // store the highscore of the player
    int highScore;
    // Generic Items list
    NSMutableArray *genericItems;
    // indicates if it the first time the game is running it will be used to set the
    // default properties
    bool firstRun;
    
}

@property (nonatomic,retain) NSString *drummerId;
@property (nonatomic) int drummerIndex;
@property (nonatomic,retain) NSString *guitar1Id;
@property (nonatomic) int guitar1Index;
@property (nonatomic,retain) NSString *guitar2Id;
@property (nonatomic) int guitar2Index;
@property (nonatomic,retain) NSString *bassId;
@property (nonatomic) int bassIndex;
@property (nonatomic,retain) NSString *vocalId;
@property (nonatomic) int vocalIndex;
@property (nonatomic,retain) NSMutableArray *genericItems;
@property (nonatomic) int bandCoins;
@property (nonatomic) int highScore;
@property (nonatomic) bool firstRun;

+(id)sharedInstance;

-(void)consumeItem:(NSString *)itemid;
-(void)storeItem:(NSString *)itemid;
-(void)selectBandGuy:(NSString *)itemid bandGuyType:(int)bandType oldSelectedGuy:(NSString *)itemId;
-(void)storeBandGuy:(NSString *)itemid indexPosition:(int)pos;
-(BandVaultItem *)getBandVaultByItemId:(NSString *)itemid;
-(void)loadAllOwnedBandGuys;
-(void)updateBandCoins:(int)coins;

@end
