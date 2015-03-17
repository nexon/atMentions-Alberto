//
//  ATMContact.h
//  atMentions-Alberto
//
//  Created by Alberto Lagos on 17-03-15.
//  Copyright (c) 2015 Alberto Lagos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATMContact : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) UIImage  *image;

- (instancetype)initWithName:(NSString *)aName andImage:(UIImage *)aImage;
+ (instancetype)contactFor:(NSString *)aName andImage:(UIImage *)aImage;
@end
