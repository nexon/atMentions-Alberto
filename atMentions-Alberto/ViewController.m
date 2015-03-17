//
//  ViewController.m
//  atMentions-Alberto
//
//  Created by Alberto Lagos on 16-03-15.
//  Copyright (c) 2015 Alberto Lagos. All rights reserved.
//

#import "ViewController.h"
#define CHAR_LIMIT 500


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyboardHeight;
@property (weak, nonatomic) IBOutlet UILabel *charLimitLabel;

- (void)keyboardWillShow:(id)sender;
- (NSMutableArray *)findMentions:(NSString *)text;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.textView becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
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
@end
