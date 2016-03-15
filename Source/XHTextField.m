//
//  XHTextField.m
//  XHTextField
//
//  Created by 曾 宪华 on 13-12-17.
//  Copyright (c) 2013年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import "XHTextField.h"
#import "UIView+XHFindViewController.h"

#define kEmailImageName @"mail"
#define kPasswordImageName @"lock"
#define kUserNameImageName @"user"
#define kConstellationImageName @"user"

@interface XHTextField () <UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate> {
    UITextField *_textField;
    BOOL _disabled;
}

@property (nonatomic) BOOL keyboardIsShown;
@property (nonatomic) CGSize keyboardSize;
@property (nonatomic) BOOL hasScrollView;
@property (nonatomic) BOOL invalid;

@property (nonatomic, setter = setToolbarCommand:) BOOL isToolBarCommand;
@property (nonatomic, setter = setDoneCommand:) BOOL isDoneCommand;

@property (nonatomic, strong) UIToolbar *inputToolbar;
@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, strong) UIBarButtonItem *previousBarButton;
@property (nonatomic, strong) UIBarButtonItem *nextBarButton;

@property (nonatomic, strong) NSMutableArray *textFields;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UIActionSheet *avatarActionSheet;


@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIPickerView *genderPickerView;
@end

@implementation XHTextField

#pragma mark - 获取星座

+ (NSString *)getConstellation:(NSDate *)date {
    //计算星座
    
    NSString *retStr=@"";
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM"];
    int i_month = 0;
    NSString *theMonth = [dateFormat stringFromDate:date];
    if([[theMonth substringToIndex:0] isEqualToString:@"0"]) {
        i_month = [[theMonth substringFromIndex:1] intValue];
    } else {
        i_month = [theMonth intValue];
    }
    
    [dateFormat setDateFormat:@"dd"];
    int i_day = 0;
    NSString *theDay = [dateFormat stringFromDate:date];
    if([[theDay substringToIndex:0] isEqualToString:@"0"]) {
        i_day = [[theDay substringFromIndex:1] intValue];
    } else {
        i_day = [theDay intValue];
    }
    /*
     摩羯座 12月22日------1月19日
     水瓶座 1月20日-------2月18日
     双鱼座 2月19日-------3月20日
     白羊座 3月21日-------4月19日
     金牛座 4月20日-------5月20日
     双子座 5月21日-------6月21日
     巨蟹座 6月22日-------7月22日
     狮子座 7月23日-------8月22日
     处女座 8月23日-------9月22日
     天秤座 9月23日------10月23日
     天蝎座 10月24日-----11月21日
     射手座 11月22日-----12月21日
     */
    switch (i_month) {
        case 1:
            if(i_day>=20 && i_day<=31){
                retStr=@"水瓶座";
            }
            if(i_day>=1 && i_day<=19){
                retStr=@"摩羯座";
            }
            break;
        case 2:
            if(i_day>=1 && i_day<=18){
                retStr=@"水瓶座";
            }
            if(i_day>=19 && i_day<=31){
                retStr=@"双鱼座";
            }
            break;
        case 3:
            if(i_day>=1 && i_day<=20){
                retStr=@"双鱼座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=@"白羊座";
            }
            break;
        case 4:
            if(i_day>=1 && i_day<=19){
                retStr=@"白羊座";
            }
            if(i_day>=20 && i_day<=31){
                retStr=@"金牛座";
            }
            break;
        case 5:
            if(i_day>=1 && i_day<=20){
                retStr=@"金牛座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=@"双子座";
            }
            break;
        case 6:
            if(i_day>=1 && i_day<=21){
                retStr=@"双子座";
            }
            if(i_day>=22 && i_day<=31){
                retStr=@"巨蟹座";
            }
            break;
        case 7:
            if(i_day>=1 && i_day<=22){
                retStr=@"巨蟹座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=@"狮子座";
            }
            break;
        case 8:
            if(i_day>=1 && i_day<=22){
                retStr=@"狮子座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=@"处女座";
            }
            break;
        case 9:
            if(i_day>=1 && i_day<=22){
                retStr=@"处女座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=@"天秤座";
            }
            break;
        case 10:
            if(i_day>=1 && i_day<=23){
                retStr=@"天秤座";
            }
            if(i_day>=24 && i_day<=31){
                retStr=@"天蝎座";
            }
            break;
        case 11:
            if(i_day>=1 && i_day<=21){
                retStr=@"天蝎座";
            }
            if(i_day>=22 && i_day<=31){
                retStr=@"射手座";
            }
            break;
        case 12:
            if(i_day>=1 && i_day<=21){
                retStr=@"射手座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=@"摩羯座";
            }
            break;
    }
    return retStr;
}

#pragma mark - Propertys

- (void)_setupAvatarField {
    self.text = NSLocalizedString(@"头像", @"");
    [self addSubview:self.avatarImageView];
    self.delegate = self;
}

- (void)_setupFieldType:(XHFieldType)fieldType {
    UIImage *leftImage = nil;
    switch (_fieldType) {
        case kXHEmailField:
            leftImage = [UIImage imageWithContentsOfFile:XH_BUNDLE_IMAGE(kEmailImageName)];
            break;
        case kXHUserNameField:
            leftImage = [UIImage imageWithContentsOfFile:XH_BUNDLE_IMAGE(kUserNameImageName)];
            break;
        case kXHPasswordField:
            leftImage = [UIImage imageWithContentsOfFile:XH_BUNDLE_IMAGE(kPasswordImageName)];
            break;
        case kXHConstellation:
            leftImage = [UIImage imageWithContentsOfFile:XH_BUNDLE_IMAGE(kConstellationImageName)];
            break;
            case kXHAvatarField:
            [self _setupAvatarField];
            return;
        default:
            return;
    }
    self.rectInsetPoint = CGPointMake(50, 5);
    UIImageView *usernameIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    usernameIconImage.image = leftImage;
    UIView *usernameIconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    usernameIconContainer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [usernameIconContainer addSubview:usernameIconImage];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = usernameIconContainer;
}

- (void)setFieldType:(XHFieldType)fieldType {
    _fieldType = fieldType;
    [self _setupFieldType:fieldType];
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"YY/MM/dd"];
        [_dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        [_dateFormatter setDateStyle:NSDateFormatterShortStyle];
    }
    return _dateFormatter;
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        CGFloat padding = 4;
        CGFloat size = CGRectGetHeight(self.bounds);
        CGFloat avatarX = CGRectGetWidth(self.bounds) - size - padding;
        CGFloat avatarSize = size - (padding * 2);
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(avatarX, padding, avatarSize, avatarSize)];
        [_avatarImageView setImage:[UIImage imageWithContentsOfFile:XH_BUNDLE_IMAGE(@"VineLogo")]];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAvatarImage:)];
        [_avatarImageView addGestureRecognizer:tapGestureRecognizer];
    }
    return _avatarImageView;
}

- (UIActionSheet *)avatarActionSheet {
    if (!_avatarActionSheet) {
        _avatarActionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"选择你的头像", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"取消", @"") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"相机", @""), NSLocalizedString(@"在图片库选择", @""), nil];
    }
    return _avatarActionSheet;
}

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}

- (UIPickerView *)genderPickerView {
    if (!_genderPickerView) {
        _genderPickerView = [[UIPickerView alloc] init];
        _genderPickerView.delegate = self;
        _genderPickerView.dataSource = self;
    }
    return _genderPickerView;
}

#pragma mark - handler

- (void)_initalizerAlertViewWithTitle:(NSString *)title description:(NSString *)description {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:description delegate:nil cancelButtonTitle:nil otherButtonTitles: NSLocalizedString(@"确定", @""), nil];
    [alertView show];
}

- (void)_showImagePickerViewController:(NSInteger)pickerUserAvatarType {
    
    UIImagePickerControllerSourceType sourceType;
    NSString *description = nil;
    switch (pickerUserAvatarType) {
        case 0:
            sourceType = UIImagePickerControllerSourceTypeCamera;
            description = NSLocalizedString(@"该设备不支持相机", @"");
            break;
        case 1:
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            description = NSLocalizedString(@"该设备不支持图片库", @"");
            break;
    }
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
        [self _initalizerAlertViewWithTitle:NSLocalizedString(@"警告", @"") description:description];
        return;
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    imagePickerController.videoQuality = UIImagePickerControllerQualityTypeMedium;
    [[self.superview viewController] presentViewController:imagePickerController animated:YES completion:NULL];
}

- (void)showAvatarImage:(UITapGestureRecognizer *)tapGesture {
    
}

#pragma mark - lift cycle init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self){
        [self setup];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup
{
    // 默认设置
    if ([self respondsToSelector:@selector(setTintColor:)]) {
        [self setTintColor:[UIColor blackColor]];
    }
    [self setBorderStyle:UITextBorderStyleNone];
    [self setFont: [UIFont systemFontOfSize:17]];
    self.rectInsetPoint = CGPointMake(10, 5);
    self.maxTextLength = 7;
    self.inputAccessoryView = [[UIView alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:self];
    
    // 工具条
    _inputToolbar = [[UIToolbar alloc] init];
    _inputToolbar.frame = CGRectMake(0, 0, CGRectGetWidth(self.window.frame), 44);
    // set style
    [_inputToolbar setBarStyle:UIBarStyleDefault];
    
    // 工具条上的按钮
    self.previousBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Previous" style:UIBarButtonItemStyleBordered target:self action:@selector(previousButtonIsClicked:)];
    self.nextBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(nextButtonIsClicked:)];
    
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonIsClicked:)];
    
    NSArray *barButtonItems = @[self.previousBarButton, self.nextBarButton, flexBarButton, doneBarButton];
    
    _inputToolbar.items = barButtonItems;
    
    self.textFields = [[NSMutableArray alloc]init];

    // 创建并添加到数组的TextField控件在supView上
    [self markTextFieldsWithTagInView:self.superview];
}

- (void)markTextFieldsWithTagInView:(UIView*)view
{
    int index = 0;
    if ([self.textFields count] == 0){
        for(UIView *subView in view.subviews){
            if ([subView isKindOfClass:[XHTextField class]]){
                XHTextField *textField = (XHTextField *)subView;
                textField.tag = index;
                [self.textFields addObject:textField];
                index++;
            }
        }
    }
}

- (void)_resetAllTextFields {
    [self.textFields removeAllObjects];
    self.textFields = nil;
}

- (void)dealloc {
    self.inputToolbar = nil;
    self.scrollView = nil;
    
    self.previousBarButton = nil;
    self.nextBarButton = nil;
    
    self.datePicker = nil;
    self.dateFormatter = nil;
    
    self.genderPickerView.delegate = nil;
    self.genderPickerView.dataSource = nil;
    self.genderPickerView = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - TextField prevati

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, self.rectInsetPoint.x, self.rectInsetPoint.y);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, self.rectInsetPoint.x, self.rectInsetPoint.y);
}

- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];
    
    layer.shadowPath = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
    [layer setBorderWidth: 0.8];
    [layer setBorderColor: [UIColor colorWithWhite:0.1 alpha:0.2].CGColor];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    if (!enabled)
        [self setBackgroundColor:[UIColor colorWithWhite:0.400 alpha:1.000]];
}

#pragma mark - UITextField help


- (void)becomeActive:(UITextField*)textField
{
    [self setToolbarCommand:YES];
    [self resignFirstResponder];
    [textField becomeFirstResponder];
}

- (XHTextField *)textFieldAtIndex:(int)index {
    return self.textFields[index];
}

- (int)numberOfTextFields {
    return self.textFields.count;
}

#pragma mark - UITextField inputView help

- (void)selectInputView:(UITextField *)textField
{
    if (self.fieldType == kXHDateField) {
        if (![textField.text isEqualToString:@""]){
            [self.datePicker setDate:[self.dateFormatter dateFromString:textField.text]];
        }
        [textField setInputView:self.datePicker];
    } else if (self.fieldType == kXHGenderField) {
        [textField setInputView:self.genderPickerView];
    } else if (self.fieldType == kXHAvatarField) {
        [textField setInputView:nil];
    }
}

- (void)datePickerValueChanged:(id)sender
{
    UIDatePicker *datePicker = (UIDatePicker*)sender;
    
    NSDate *selectedDate = datePicker.date;
    
    [_textField setText:[self.dateFormatter stringFromDate:selectedDate]];
    
    [self _chanegConstellation:selectedDate];
    
    [self validate];
}

- (void)_chanegConstellation:(NSDate *)date {
    NSInteger tagIndex = self.tag;
    XHTextField *textField =  [self.textFields objectAtIndex:++tagIndex];
    textField.text = [XHTextField getConstellation:date];
}

#pragma mark - keyboard help

- (void)scrollToField
{
    CGRect textFieldRect = _textField.frame;
    
    CGRect aRect = self.window.bounds;
    
    aRect.origin.y = -_scrollView.contentOffset.y;
    aRect.size.height -= _keyboardSize.height + self.inputToolbar.frame.size.height + 22;
    
    CGPoint textRectBoundary = CGPointMake(textFieldRect.origin.x, textFieldRect.origin.y + textFieldRect.size.height);
    
    if (!CGRectContainsPoint(aRect, textRectBoundary) || _scrollView.contentOffset.y > 0) {
        CGPoint scrollPoint = CGPointMake(0.0, self.superview.frame.origin.y + _textField.frame.origin.y + _textField.frame.size.height - aRect.size.height);
        
        if (scrollPoint.y < 0) scrollPoint.y = 0;
        
        [_scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (BOOL)validate
{
    self.backgroundColor = [UIColor colorWithRed:255 green:0 blue:0 alpha:0.5];
    
    if (self.required && ![self.text length]) {
        return NO;
    }
    else if (self.fieldType == kXHEmailField) {
        NSString *emailRegEx =
        @"(?:[A-Za-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[A-Za-z0-9!#$%\\&'*+/=?\\^_`{|}"
        @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
        @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[A-Za-z0-9](?:[a-"
        @"z0-9-]*[A-Za-z0-9])?\\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?|\\[(?:(?:25[0-5"
        @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
        @"9][0-9]?|[A-Za-z0-9-]*[A-Za-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
        @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
        
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
        
        if (![emailTest evaluateWithObject:self.text]){
            return NO;
        }
    } else if ([self.text length] > self.maxTextLength) {
        return NO;
    }
    
    [self setBackgroundColor:[UIColor whiteColor]];
    
    return YES;
}

- (void)keyboardDidShow:(NSNotification *) notification
{
    if (_textField == nil) return;
    if (_keyboardIsShown) return;
    if (![_textField isKindOfClass:[XHTextField class]]) return;
    
    NSDictionary* info = [notification userInfo];
    
    NSValue *aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    _keyboardSize = [aValue CGRectValue].size;
    
    [self scrollToField];
    
    self.keyboardIsShown = YES;
    
}

- (void)keyboardWillHide:(NSNotification *) notification
{
    NSTimeInterval duration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        if (_isDoneCommand)
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }];
    
    _keyboardIsShown = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:self];
}

#pragma mark - toolbar item help

- (void)setBarButtonNeedsDisplayAtTag:(int)tag
{
    BOOL previousBarButtonEnabled = NO;
    BOOL nexBarButtonEnabled = NO;
    
    for (int index = 0; index < [self.textFields count]; index++) {
        
        UITextField *textField = [self.textFields objectAtIndex:index];
        
        if (index < tag)
            previousBarButtonEnabled |= textField.isEnabled;
        else if (index > tag)
            nexBarButtonEnabled |= textField.isEnabled;
    }
    
    self.previousBarButton.enabled = previousBarButtonEnabled;
    self.nextBarButton.enabled = nexBarButtonEnabled;
}

- (void)doneButtonIsClicked:(id)sender
{
    [self setDoneCommand:YES];
    [self resignFirstResponder];
    [self setToolbarCommand:YES];
}

- (void)nextButtonIsClicked:(id)sender
{
    NSInteger tagIndex = self.tag;
    XHTextField *textField =  [self.textFields objectAtIndex:++tagIndex];
    
    while (!textField.isEnabled && tagIndex < [self.textFields count])
        textField = [self.textFields objectAtIndex:++tagIndex];
    
    [self becomeActive:textField];
}

- (void)previousButtonIsClicked:(id)sender
{
    NSInteger tagIndex = self.tag;
    
    XHTextField *textField =  [self.textFields objectAtIndex:--tagIndex];
    
    while (!textField.isEnabled && tagIndex < [self.textFields count])
        textField = [self.textFields objectAtIndex:--tagIndex];
    
    [self becomeActive:textField];
}

#pragma mark - UITextField notifications

- (void)textFieldDidBeginEditing:(NSNotification *) notification
{
    UITextField *textField = (UITextField*)[notification object];
    
    _textField = textField;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self setBarButtonNeedsDisplayAtTag:textField.tag];
    
    if ([self.superview isKindOfClass:[UIScrollView class]] && self.scrollView == nil)
        self.scrollView = (UIScrollView*)self.superview;
    
    [self selectInputView:textField];
    [self setInputAccessoryView:self.inputToolbar];
    
    [self setDoneCommand:NO];
    [self setToolbarCommand:NO];
}

- (void)textFieldDidEndEditing:(NSNotification *) notification
{
    UITextField *textField = (UITextField*)[notification object];
    
    [self validate];
    
    _textField = nil;
    
    if (self.fieldType == kXHDateField && [textField.text isEqualToString:@""] && _isDoneCommand) {
        [textField setText:[self.dateFormatter stringFromDate:[NSDate date]]];
        
        [self _chanegConstellation:[NSDate date]];
        
    } else if (self.fieldType == kXHGenderField && [textField.text isEqualToString:@""] && _isDoneCommand) {
        [self setGenderData:textField withGenderPickerView:(UIPickerView *)textField.inputView];
    }
}

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.fieldType == kXHAvatarField) {
        [self.avatarActionSheet showInView:self.superview.viewController.view];
        return NO;
    } else {
        return YES;
    }
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 2;
}

#pragma mark - UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UIImage *image = row == 0 ? [UIImage imageWithContentsOfFile:XH_BUNDLE_IMAGE(@"male")] : [UIImage imageWithContentsOfFile:XH_BUNDLE_IMAGE(@"female")];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 0, 32, 32);
    
    UILabel *genderLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 100, 32)];
    genderLabel.text = [row == 0 ? NSLocalizedString(@"男", @"") : NSLocalizedString(@"女", @"") uppercaseString];
    genderLabel.textAlignment = UITextAlignmentLeft;
    genderLabel.backgroundColor = [UIColor clearColor];
    
    UIView *rowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 32)];
    [rowView insertSubview:imageView atIndex:0];
    [rowView insertSubview:genderLabel atIndex:1];
    
    return rowView;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self setGenderData:self withGenderPickerView:pickerView];
}

- (void)setGenderData:(UITextField *)textField withGenderPickerView:(UIPickerView *)genderPickerView  {
    if ([genderPickerView selectedRowInComponent:0] == 0) {
        textField.text = NSLocalizedString(@"男", @"男");
    } else {
        textField.text = NSLocalizedString(@"女", @"女");
    }
}

#pragma mark - UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 2)
        return;
    
    [self _showImagePickerViewController:buttonIndex];
}

#pragma mark - UIImagePickerViewController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *userAvatar = [info valueForKey:UIImagePickerControllerEditedImage];
    [self.avatarImageView setImage:userAvatar];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
