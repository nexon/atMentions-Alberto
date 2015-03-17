//
//  ATMContact.m
//  atMentions-Alberto
//
//  Created by Alberto Lagos on 17-03-15.
//  Copyright (c) 2015 Alberto Lagos. All rights reserved.
//

#import "ATMContact.h"

@implementation ATMContact

- (instancetype)initWithName:(NSString *)aName andImage:(UIImage *)aImage
{
    self = [super init];
    if(self) {
        _name  = aName;
        _image = aImage;
    }
    
    return self;
}
+ (instancetype)contactFor:(NSString *)aName andImage:(UIImage *)aImage
{
    ATMContact *newContact = [[[self class] alloc] initWithName:aName andImage:aImage];
    return newContact;
}
@end
