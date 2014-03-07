//
//  XHTextFieldScrollView.h
//  XHTextField
//
//  Created by 曾 宪华 on 13-12-18.
//  Copyright (c) 2013年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidDisMissCompledBlock)(void);

@class XHTextField;

@protocol XHTextFieldScrollViewDelegate <NSObject>

@required
- (void)keyboardDidShow;
- (void)keyboardDidScrollToPoint:(CGPoint)point;
- (void)keyboardWillBeDismissed;
- (void)keyboardWillSnapBackToPoint:(CGPoint)point;

@end

@interface XHTextFieldScrollView : UIScrollView

@property (nonatomic, assign) id <XHTextFieldScrollViewDelegate> textFieldScrollViewDelegate;
@property (nonatomic, strong) UIPanGestureRecognizer *dismissivePanGestureRecognizer;
@property (nonatomic, copy) DidDisMissCompledBlock didDisMissCompledBlock;

@end
