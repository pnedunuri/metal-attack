//
//  BandVaultItem.m
//  EightbitShooter
//
//  Created by Rafael Munhoz on 15/10/14.
//
//

#import "BandVaultItem.h"

@implementation BandVaultItem

@synthesize qtd;
@synthesize ownedVaultItem;
@synthesize selectedVaultItem;
@synthesize appId;
@synthesize indexPosition;

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        self.appId = [decoder decodeObjectForKey:@"appId"];
        self.qtd = [decoder decodeObjectForKey:@"qtd"];
        self.ownedVaultItem = [decoder decodeObjectForKey:@"ownedVaultItem"];
        self.selectedVaultItem = [decoder decodeObjectForKey:@"selectedVaultItem"];
        self.indexPosition = [decoder decodeObjectForKey:@"indexPosition"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.appId forKey:@"appId"];
    [encoder encodeObject:self.qtd forKey:@"qtd"];
    [encoder encodeObject:self.ownedVaultItem forKey:@"ownedVaultItem"];
    [encoder encodeObject:self.selectedVaultItem forKey:@"selectedVaultItem"];
    [encoder encodeObject:self.indexPosition forKey:@"indexPosition"];
}

@end
