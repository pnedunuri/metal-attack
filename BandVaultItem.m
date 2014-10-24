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
@synthesize owned;
@synthesize selected;
@synthesize appId;
@synthesize indexPosition;

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        self.appId = [decoder decodeObjectForKey:@"appId"];
        self.qtd = [decoder decodeObjectForKey:@"qtd"];
        self.owned = [decoder decodeObjectForKey:@"owned"];
        self.selected = [decoder decodeObjectForKey:@"selected"];
        self.indexPosition = [decoder decodeObjectForKey:@"indexPosition"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.appId forKey:@"appId"];
    [encoder encodeObject:self.qtd forKey:@"qtd"];
    [encoder encodeObject:self.owned forKey:@"owned"];
    [encoder encodeObject:self.selected forKey:@"selected"];
    [encoder encodeObject:self.indexPosition forKey:@"indexPosition"];
}

@end
