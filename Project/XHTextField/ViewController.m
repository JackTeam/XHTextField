//
//  ViewController.m
//  XHTextField
//
//  Created by 曾 宪华 on 13-12-17.
//  Copyright (c) 2013年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.scrollView setContentSize:CGSizeMake(0, CGRectGetHeight(self.scrollView.frame) + 80)];
    
    [_avatarTextField setFieldType:kXHAvatarField];
    
    [_emailTextField setRequired:YES];
    [_emailTextField setFieldType:kXHEmailField];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    [_scrollView setDismissivePanGestureRecognizer:pan];
    [self.view addGestureRecognizer:pan];
    
    [_passwordTextField setRequired:YES];
    [_passwordTextField setFieldType:kXHPasswordField];
    
    [_firstNameTextField setFieldType:kXHUserNameField];
    
    [_lastNameTextField setFieldType:kXHUserNameField];
    
    [_genderTextField setFieldType:kXHGenderField];
    
    [_ageTextField setFieldType:kXHDateField];
    
    [_constellationTextField setEnabled:NO];
    [_constellationTextField setFieldType:kXHConstellation];
    
    _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    _zipTextField.keyboardType = UIKeyboardTypePhonePad;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.scrollView = nil;
    [self.avatarTextField _resetAllTextFields];
    [self.emailTextField _resetAllTextFields];
    [self.passwordTextField _resetAllTextFields];
    [self.firstNameTextField _resetAllTextFields];
    [self.lastNameTextField _resetAllTextFields];
    [self.phoneTextField _resetAllTextFields];
    [self.ageTextField _resetAllTextFields];
    [self.constellationTextField _resetAllTextFields];
    [self.zipTextField _resetAllTextFields];
    [self.genderTextField _resetAllTextFields];
}

#pragma mark - handler

- (CustomUITextField *)validateInputInView:(UIView*)view
{
    CustomUITextField *customUITextField = nil;
    for(UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[UIScrollView class]])
            return [self validateInputInView:subView];
        
        if ([subView isKindOfClass:[CustomUITextField class]]) {
            if (![(CustomUITextField*)subView validate]) {
                customUITextField = (CustomUITextField*)subView;
                return customUITextField;
            }
        }
    }
    
    return customUITextField;
}

- (IBAction)createAccount:(UIButton *)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Do something interesting!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    
    CustomUITextField *customUITextField = [self validateInputInView:self.view];
    if (customUITextField) {
        
        [alertView setMessage:[NSString stringWithFormat:@"Invalid information please review and try again! %d",  customUITextField.fieldType]];
        [alertView setTitle:@"Login Failed"];
        [customUITextField becomeFirstResponder];
    }
    
    [alertView show];
}
@end
