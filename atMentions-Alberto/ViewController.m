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
@property (strong, nonatomic) NSMutableArray  *filteredArray;
@property (strong, nonatomic) ATMContact      *selectedContact;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (strong, nonatomic) NSString        *mention;

- (void)keyboardWillShow:(id)sender;
- (NSMutableArray *)findMentions:(NSString *)text;
- (void)loadContacts;
- (void)uselessButtonDidPress:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.textView becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    self.filteredArray        = [NSMutableArray array];
    
    [self.addButton addTarget:self action:@selector(uselessButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem.rightBarButtonItem setTarget:self];
    [self.navigationItem.rightBarButtonItem setAction:@selector(uselessButtonDidPress:)];
    [self.navigationItem.leftBarButtonItem setTarget:self];
    [self.navigationItem.leftBarButtonItem setAction:@selector(uselessButtonDidPress:)];
    
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
        self.mention = mentions[0];
        [self searchNameForMention:mentions[0]];
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
    
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:@"(@[a-zA-Z0-9_\\s]+)"
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
    NSLog(@"%s: Useless button pressed!", __func__);
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedContact = self.filteredArray[indexPath.row];
    
    NSString *replacedText = [self.textView.text stringByReplacingOccurrencesOfString:self.mention withString:self.selectedContact.name];
    
    self.textView.text = replacedText;
    self.selectedContact = nil;
    self.mention         = nil;
    
    self.tableView.hidden = YES;
    
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.filteredArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *ATMContactCell = @"ATMContactCell";
    
    ATMContact *contact = self.filteredArray[indexPath.row];
    cell = [self.tableView dequeueReusableCellWithIdentifier:ATMContactCell forIndexPath:indexPath];
    cell.textLabel.text = contact.name;
    cell.imageView.image = contact.image;
    
    return cell;
}

- (void)loadContacts
{
    self.contacts = [NSMutableArray arrayWithArray:@[[ATMContact contactFor:@"Shannon Leigh" andImage:[UIImage imageNamed:@"1"]],
                                                     [ATMContact contactFor:@"Meredith Overmyer" andImage:[UIImage imageNamed:@"2"]],
                                                     [ATMContact contactFor:@"Amber Colvard" andImage:[UIImage imageNamed:@"3"]],
                                                     [ATMContact contactFor:@"Allie Siarto" andImage:[UIImage imageNamed:@"4"]],
                                                     [ATMContact contactFor:@"Kim Rothwell" andImage:[UIImage imageNamed:@"5"]],
                                                     [ATMContact contactFor:@"Ashlee Finley" andImage:[UIImage imageNamed:@"6"]],
                                                     [ATMContact contactFor:@"John Doe" andImage:[UIImage imageNamed:@"7"]],
                                                     [ATMContact contactFor:@"Janne Doe" andImage:[UIImage imageNamed:@"8"]],
                                                     [ATMContact contactFor:@"Rick Maddon" andImage:[UIImage imageNamed:@"9"]],
                                                     [ATMContact contactFor:@"July Safford" andImage:[UIImage imageNamed:@"10"]]
                                                     ]];
    
}

- (void)searchNameForMention:(NSString *)mention {
    NSString *name = [mention substringFromIndex:1];
    [self.filteredArray removeAllObjects];
    
    NSPredicate *pFilter = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS[cd] %@", name];
    
    self.filteredArray   = [NSMutableArray arrayWithArray:[self.contacts filteredArrayUsingPredicate:pFilter]];
    
    [self.tableView reloadData];
}
@end
