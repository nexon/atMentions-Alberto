//
//  ViewController.m
//  atMentions-Alberto
//
//  Created by Alberto Lagos on 16-03-15.
//  Copyright (c) 2015 Alberto Lagos. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *containerView;



- (void)keyboardWillShow:(id)sender;
- (void)keyboardWillDisappear:(id)sender;
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


#pragma mark - NSNotification Keyboard methods.

- (void)keyboardWillShow:(id)sender
{
    
}

- (void)keyboardWillDisappear:(id)sender
{
    
}

- (IBAction)uselessButtonDidPress:(id)sender {
}
@end
