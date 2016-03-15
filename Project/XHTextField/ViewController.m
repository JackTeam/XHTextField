//
//  ViewController.m
//  XHTextField
//
//  Created by 曾 宪华 on 13-12-17.
//  Copyright (c) 2013年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *textFields;
@end

@implementation ViewController

#pragma mark - Propertys

- (NSMutableArray *)textFields {
    if (!_textFields) {
        _textFields = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _textFields;
}

#pragma mark - Life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self.scrollView setContentSize:CGSizeMake(0, CGRectGetHeight(self.scrollView.frame) + 150)];
    __weak typeof(self) weakSelf = self;
    [self.scrollView setDidDisMissCompledBlock:^{
        [weakSelf.textFields enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj resignFirstResponder];
        }];
    }];
    [_scrollView setDismissivePanGestureRecognizer:_scrollView.panGestureRecognizer];
    
    [_avatarTextField setFieldType:kXHAvatarField];
    
    [_emailTextField setRequired:YES];
    [_emailTextField setFieldType:kXHEmailField];
    [self.textFields addObject:_emailTextField];
    
    [_passwordTextField setRequired:YES];
    [_passwordTextField setFieldType:kXHPasswordField];
    [self.textFields addObject:_passwordTextField];
    
    [_firstNameTextField setFieldType:kXHUserNameField];
    [self.textFields addObject:_firstNameTextField];
    
    [_lastNameTextField setFieldType:kXHUserNameField];
    [self.textFields addObject:_lastNameTextField];
    
    [_genderTextField setFieldType:kXHGenderField];
    [self.textFields addObject:_genderTextField];
    
    [_ageTextField setFieldType:kXHDateField];
    [self.textFields addObject:_ageTextField];
    
    [_constellationTextField setEnabled:NO];
    [_constellationTextField setFieldType:kXHConstellation];
    [self.textFields addObject:_constellationTextField];
    
    _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    [self.textFields addObject:_phoneTextField];
    
    _zipTextField.keyboardType = UIKeyboardTypePhonePad;
    [self.textFields addObject:_zipTextField];
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
