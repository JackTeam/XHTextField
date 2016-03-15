//
//  XHTextField.h
//  XHTextField
//
//  Created by 曾 宪华 on 13-12-17.
//  Copyright (c) 2013年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
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

@property (nonatomic) BOOL required; // default is NO
@property (nonatomic, assign) XHFieldType fieldType;
@property (nonatomic, assign) id <XHTextFieldDelegate> textFieldDelegate;

@property (nonatomic, assign) NSInteger maxTextLength; // default is  140

@property (nonatomic, assign) CGPoint rectInsetPoint; // default is (10, 5)
/**
 *  set textFields for nil
 */
- (void)_resetAllTextFields;

/**
 *  check self requred condition
 *
 *  @return pass requred for YES
 */
- (BOOL)validate;

- (XHTextField *)textFieldAtIndex:(int)index;
- (int)numberOfTextFields;

/**
 *  get Constellation with date
 *
 *  @param date Tranform Constellation form date
 *
 *  @return Constellation string
 */
+ (NSString *)getConstellation:(NSDate *)date;

@end
