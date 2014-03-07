//
//  XHTextFieldScrollView.m
//  XHTextField
//
//  Created by 曾 宪华 on 13-12-18.
//  Copyright (c) 2013年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import "XHTextFieldScrollView.h"

@interface XHTextFieldScrollView ()

@property (weak, nonatomic) UIView *keyboardView;
@property (assign, nonatomic) CGFloat previousKeyboardY;

@end

@implementation XHTextFieldScrollView

- (UIView *)findKeyboard
{
    UIView *keyboardView = nil;
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in [windows reverseObjectEnumerator])//逆序效率更高，因为键盘总在上方
    {
        keyboardView = [self findKeyboardInView:window];
        if (keyboardView)
        {
            return keyboardView;
        }
    }
    return nil;
}
- (UIView *)findKeyboardInView:(UIView *)view
{
    for (UIView *subView in [view subviews])
    {
        if (strstr(object_getClassName(subView), "UIKeyboard"))
        {
            return subView;
        }
        else
        {
            UIView *tempView = [self findKeyboardInView:subView];
            if (tempView)
            {
                return tempView;
            }
        }
    }
    return nil;
}

- (void)handleKeyboardWillShowHideNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:UIKeyboardWillShowNotification]) {
        self.keyboardView.hidden = NO;
    }
    else if([notification.name isEqualToString:UIKeyboardDidShowNotification]) {
        self.keyboardView = [self findKeyboard].superview;
        self.keyboardView.hidden = NO;
        
        if(self.textFieldScrollViewDelegate && [self.textFieldScrollViewDelegate respondsToSelector:@selector(keyboardDidShow)])
            [self.textFieldScrollViewDelegate keyboardDidShow];
    }
    else if([notification.name isEqualToString:UIKeyboardDidHideNotification]) {
        self.keyboardView.hidden = NO;
        [self resignFirstResponder];
    }
}

- (void)_addObserver {
    // 键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleKeyboardWillShowHideNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleKeyboardWillShowHideNotification:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleKeyboardWillShowHideNotification:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

- (void)_removeObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)_setup {
    [self _addObserver];
}

- (void)awakeFromNib {
    [self _setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _setup];
    }
    return self;
}

- (void)dealloc {
    self.textFieldScrollViewDelegate = nil;
    [_dismissivePanGestureRecognizer removeTarget:self action:@selector(handlePanGesture:)];
    _dismissivePanGestureRecognizer = nil;
    self.keyboardView = nil;
    [self _removeObserver];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - Setters

- (void)setDismissivePanGestureRecognizer:(UIPanGestureRecognizer *)pan
{
    _dismissivePanGestureRecognizer = pan;
    [_dismissivePanGestureRecognizer addTarget:self action:@selector(handlePanGesture:)];
}

#pragma mark - Gestures

- (void)handlePanGesture:(UIPanGestureRecognizer *)pan
{
    if(!self.keyboardView || self.keyboardView.hidden)
        return;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    
    UIWindow *panWindow = [[UIApplication sharedApplication] keyWindow];
    CGPoint location = [pan locationInView:panWindow];
    CGPoint velocity = [pan velocityInView:panWindow];
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            self.previousKeyboardY = self.keyboardView.frame.origin.y;
            break;
        case UIGestureRecognizerStateEnded:
            if(velocity.y > 0 && self.keyboardView.frame.origin.y > self.previousKeyboardY) {
                
                [UIView animateWithDuration:0.3
                                      delay:0
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     self.keyboardView.frame = CGRectMake(0.0f,
                                                                          screenHeight,
                                                                          self.keyboardView.frame.size.width,
                                                                          self.keyboardView.frame.size.height);
                                     
                                     if(self.textFieldScrollViewDelegate && [self.textFieldScrollViewDelegate respondsToSelector:@selector(keyboardWillBeDismissed)])
                                         [self.textFieldScrollViewDelegate keyboardWillBeDismissed];
                                 }
                                 completion:^(BOOL finished) {
                                     self.keyboardView.hidden = YES;
                                     self.keyboardView.frame = CGRectMake(0.0f,
                                                                          self.previousKeyboardY,
                                                                          self.keyboardView.frame.size.width,
                                                                          self.keyboardView.frame.size.height);
                                     [self resignFirstResponder];
                                     if (self.didDisMissCompledBlock) {
                                         self.didDisMissCompledBlock();
                                     }
                                 }];
            }
            else { // gesture ended with no flick or a flick upwards, snap keyboard back to original position
                [UIView animateWithDuration:0.2
                                      delay:0
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     if(self.textFieldScrollViewDelegate && [self.textFieldScrollViewDelegate respondsToSelector:@selector(keyboardWillSnapBackToPoint:)]) {
                                         [self.textFieldScrollViewDelegate keyboardWillSnapBackToPoint:CGPointMake(0.0f, self.previousKeyboardY)];
                                     }
                                     
                                     self.keyboardView.frame = CGRectMake(0.0f,
                                                                          self.previousKeyboardY,
                                                                          self.keyboardView.frame.size.width,
                                                                          self.keyboardView.frame.size.height);
                                 }
                                 completion:^(BOOL finished){
                                     if (self.didDisMissCompledBlock) {
                                         self.didDisMissCompledBlock();
                                     }
                                 }];
            }
            break;
            
            // gesture is currently panning, match keyboard y to touch y
        default:
            if(location.y > self.keyboardView.frame.origin.y || self.keyboardView.frame.origin.y != self.previousKeyboardY) {
                
                CGFloat newKeyboardY = self.previousKeyboardY + (location.y - self.previousKeyboardY);
                newKeyboardY = newKeyboardY < self.previousKeyboardY ? self.previousKeyboardY : newKeyboardY;
                newKeyboardY = newKeyboardY > screenHeight ? screenHeight : newKeyboardY;
                
                self.keyboardView.frame = CGRectMake(0.0f,
                                                     newKeyboardY,
                                                     self.keyboardView.frame.size.width,
                                                     self.keyboardView.frame.size.height);
                
                if(self.textFieldScrollViewDelegate && [self.textFieldScrollViewDelegate respondsToSelector:@selector(keyboardDidScrollToPoint:)])
                    [self.textFieldScrollViewDelegate keyboardDidScrollToPoint:CGPointMake(0.0f, newKeyboardY)];
            }
            break;
    }
}

@end
