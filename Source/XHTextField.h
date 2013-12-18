//
//  XHTextField.h
//  XHTextField
//
//  Created by 曾 宪华 on 13-12-17.
//  Copyright (c) 2013年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import <UIKit/UIKit.h>

#define XH_BUNDLE_IMAGE(_file) [[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"XHTextField.bundle"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@.png", _file, ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2) ? @"@2x" : @""]]

@class XHTextField;

@protocol XHTextFieldDelegate <NSObject>

@required
@end

typedef NS_ENUM(NSInteger, XHFieldType) {
    kXHOtherField = 0,
    kXHAvatarField,
    kXHEmailField,
    kXHPasswordField,
    kXHUserNameField,
    kXHDateField,
    kXHGenderField,
    kXHConstellation
};

@interface XHTextField : UITextField

@property (nonatomic) BOOL required;
@property (nonatomic, strong) UIToolbar *inputToolbar;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) XHFieldType fieldType;
@property (nonatomic, assign) id <XHTextFieldDelegate> textFieldDelegate;

@property (nonatomic, assign) CGPoint rectInsetPoint;
- (void)_resetAllTextFields;

- (BOOL)validate;

- (XHTextField *)textFieldAtIndex:(int)index;
- (int)numberOfTextFields;

+ (NSString *)getConstellation:(NSDate *)date;

@end
