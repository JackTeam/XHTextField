//
//  ViewController.h
//  XHTextField
//
//  Created by 曾 宪华 on 13-12-17.
//  Copyright (c) 2013年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomUITextField.h"
#import "XHTextFieldScrollView.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet XHTextFieldScrollView *scrollView;
@property (weak, nonatomic) IBOutlet CustomUITextField *avatarTextField;
@property (weak, nonatomic) IBOutlet CustomUITextField *emailTextField;
@property (weak, nonatomic) IBOutlet CustomUITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet CustomUITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet CustomUITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet CustomUITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet CustomUITextField *ageTextField;
@property (weak, nonatomic) IBOutlet CustomUITextField *constellationTextField;
@property (weak, nonatomic) IBOutlet CustomUITextField *zipTextField;
@property (weak, nonatomic) IBOutlet CustomUITextField *genderTextField;
- (IBAction)createAccount:(UIButton *)sender;

@end
