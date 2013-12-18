//
//  UIView+XHFindViewController.m
//  XHTextField
//
//  Created by 曾 宪华 on 13-12-17.
//  Copyright (c) 2013年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import "UIView+XHFindViewController.h"

@implementation UIView (XHFindViewController)

- (UIViewController *)viewController {
    // Traverse responder chain. Return first found view controller, which will be the view's view controller.
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass:[UIViewController class]])
            return (UIViewController *)responder;
    
    // If the view controller isn't found, return nil.
    return nil;
}

@end
