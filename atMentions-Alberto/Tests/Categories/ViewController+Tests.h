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
@property (weak, nonatomic) IBOutlet UILabel *charLimitLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewSpace;
@property (strong, nonatomic) NSMutableArray  *contacts;
@property (strong, nonatomic) NSMutableArray  *filteredArray;
@property (strong, nonatomic) ATMContact      *selectedContact;
@property (strong, nonatomic) NSString        *mention;

- (void)keyboardWillShow:(id)sender;
- (NSMutableArray *)findMentions:(NSString *)text;
- (void)loadContacts;
@end
