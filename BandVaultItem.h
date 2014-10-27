//
//  BandVaultItem.h
//  EightbitShooter
//
//  Created by Rafael Munhoz on 15/10/14.
//
//

#import <Foundation/Foundation.h>

@interface BandVaultItem : NSObject
{
    NSString *appId;
    NSNumber *ownedVaultItem;
    NSNumber *selectedVaultItem;
    NSNumber *qtd;
    NSNumber *indexPosition;
}

@property (nonatomic,retain) NSString *appId;
@property (nonatomic,retain) NSNumber *ownedVaultItem;
@property (nonatomic,retain) NSNumber *selectedVaultItem;
@property (nonatomic,retain) NSNumber *qtd;
@property (nonatomic,retain) NSNumber *indexPosition;

@end
