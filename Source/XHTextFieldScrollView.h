//
//  XHTextFieldScrollView.h
//  XHTextField
//
//  Created by 曾 宪华 on 13-12-18.
//  Copyright (c) 2013年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
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
