//
//  ViewController+Tests.h
//  atMentions-Alberto
//
//  Created by Alberto Lagos on 16-03-15.
//  Copyright (c) 2015 Alberto Lagos. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (Tests)
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyboardHeight;

- (void)keyboardWillShow:(id)sender;
- (NSMutableArray *)findMentions:(NSString *)text;
@end
