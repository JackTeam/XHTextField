//
//  CustomUITextField.m
//  XHTextField
//
//  Created by 曾 宪华 on 13-12-17.
//  Copyright (c) 2013年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import "CustomUITextField.h"

@implementation CustomUITextField

- (void)_setup {
    [self setBorderStyle:UITextBorderStyleNone];
    
    [self setFont: [UIFont systemFontOfSize:17]];
    if ([self respondsToSelector:@selector(setTintColor:)])
        [self setTintColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
    [self setBackgroundColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        if (self.isCustom)
            [self _setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    if (self.isCustom)
        [self _setup];
}

- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];
    if (!self.isCustom)
        return;
    
    [layer setBorderWidth: 0.8];
    [layer setBorderColor: [UIColor colorWithWhite:0.1 alpha:0.2].CGColor];
    layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    [layer setCornerRadius:3.0];
    [layer setShadowOpacity:1.0];
    [layer setShadowColor:[UIColor redColor].CGColor];
    [layer setShadowOffset:CGSizeMake(1.0, 1.0)];
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_0
- (void) drawPlaceholderInRect:(CGRect)rect {
    if (!self.isCustom)
        return;
    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor colorWithRed:182/255. green:182/255. blue:183/255. alpha:1.0]};
    [self.placeholder drawInRect:CGRectInset(rect, 5, 5) withAttributes:attributes];
}
#endif
@end
