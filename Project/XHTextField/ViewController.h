//
//  ViewController.h
//  XHTextField
//
//  Created by 曾 宪华 on 13-12-17.
//  Copyright (c) 2013年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
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
