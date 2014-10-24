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
    NSNumber *owned;
    NSNumber *selected;
    NSNumber *qtd;
    NSNumber *indexPosition;
}

@property (nonatomic,retain) NSString *appId;
@property (nonatomic,retain) NSNumber *owned;
@property (nonatomic,retain) NSNumber *selected;
@property (nonatomic,retain) NSNumber *qtd;
@property (nonatomic,retain) NSNumber *indexPosition;

@end
