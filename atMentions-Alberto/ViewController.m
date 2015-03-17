//
//  ViewController.m
//  atMentions-Alberto
//
//  Created by Alberto Lagos on 16-03-15.
//  Copyright (c) 2015 Alberto Lagos. All rights reserved.
//

#import "ViewController.h"
#define CHAR_LIMIT 500
#define NUM_CONTACTS 10

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyboardHeight;
@property (weak, nonatomic) IBOutlet UILabel *charLimitLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewSpace;
@property (strong, nonatomic) NSMutableArray  *contacts;

- (void)keyboardWillShow:(id)sender;
- (NSMutableArray *)findMentions:(NSString *)text;
- (void)loadContacts;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.textView becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    
    [self loadContacts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITextViewDelegate 

- (void)textViewDidChange:(UITextView *)textView
{
    NSString *text = textView.text;
    
    self.charLimitLabel.text = [NSString stringWithFormat:@"%li", CHAR_LIMIT - text.length];
    
    NSArray *mentions = [self findMentions:text];
    
    if(mentions.count > 0) {
        self.tableView.hidden = NO;
    } else {
        self.tableView.hidden = YES;
    }
    
    NSLog(@"%s: %@", __func__, [self findMentions:text]);
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *enteredText = textView.text;
    
    if(enteredText.length >= 500) return NO;
    
    return YES;
}



#pragma mark - Find mentions

- (NSMutableArray *)findMentions:(NSString *)text
{
    
    NSError *error = nil;
    
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:@"(@[a-zA-Z0-9_]+)"
                                                                      options:NSRegularExpressionCaseInsensitive
                                                                        error:&error];
    
    NSMutableArray *mentions = [NSMutableArray array];
    
    NSArray *matches = [regex matchesInString:text options:0 range:NSMakeRange(0, [text length])];
    
    for (NSTextCheckingResult *result in matches) {
        
        [mentions addObject:[text substringWithRange:result.range]];
        
    }
    
    return mentions;
    
}

#pragma mark - NSNotification Keyboard methods.

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = [kbFrame CGRectValue];
    
    CGFloat height = keyboardFrame.size.height;
    self.keyboardHeight.constant = height + 8.0f;
}

- (void)uselessButtonDidPress:(id)sender {
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contacts.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *ATMContactCell = @"ATMContactCell";
    
    ATMContact *contact = self.contacts[indexPath.row];
    cell = [self.tableView dequeueReusableCellWithIdentifier:ATMContactCell forIndexPath:indexPath];
    cell.textLabel.text = contact.name;
    
    return cell;
}

- (void)loadContacts
{
    self.contacts = [NSMutableArray arrayWithArray:@[[ATMContact contactFor:@"Shannon Leigh" andImage:nil],
                                                     [ATMContact contactFor:@"Meredith Overmyer" andImage:nil],
                                                     [ATMContact contactFor:@"Amber Colvard" andImage:nil],
                                                     [ATMContact contactFor:@"Allie Siarto" andImage:nil],
                                                     [ATMContact contactFor:@"Kim Rothwell" andImage:nil],
                                                     [ATMContact contactFor:@"Ashlee Finley" andImage:nil],
                                                     [ATMContact contactFor:@"John Doe" andImage:nil],
                                                     [ATMContact contactFor:@"Janne Doe" andImage:nil],
                                                     [ATMContact contactFor:@"Rick Maddon" andImage:nil],
                                                     [ATMContact contactFor:@"July Safford" andImage:nil]
                                                     ]];
    
}
@end
