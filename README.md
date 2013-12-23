XHTextField
===========

中文：类似微信的用户头像选择、系统信息App的手势控制键盘隐藏，还有自定义9种输入风格，比如输入Email并检查是否正确、输入密码检查是否输入正确、输入生日自动帮你选择星座、自定义textField的leftView的图标等功能，注意：还有输入错误的标识提示哦！ 


English: micro letter like avatars selection, system information App gesture keypad, and custom style 9 kinds of input, such as input Email and check whether it is right, input the password check whether correct, input automatically help you choose birthday constellation, customize the textField leftView ICONS, and other functions, note: there are input error identification tips!

![image](https://github.com/JackTeam/XHTextField/raw/master/Screenshots/TextField.gif)

##安装
##Installation

中文:      [CocosPods](http://cocosPods.org)安装XHMediaRecorder的推荐方法,只是在Podfile添加以下行:

english:   [CocosPods](http://cocosPods.org) is the recommended methods of installation XHMediaRecorder, just add the following line to `Profile`:

## Profile

```
pod 'XHTextField'
```

## 例子
## Example

```objective-c
- (void)_setup {
    XHTextField *emailTextField = [[XHTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 35)];
    [emailTextField setFieldType:kXHEmailField];
    // diss keyboard gesture
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    XHTextFieldScrollView *scrollView = [[XHTextFieldScrollView alloc] initWithFrame:self.view.bounds];
    [scrollView setDismissivePanGestureRecognizer:pan];
    [scrollView addSubview:emailTextField];
    [self.view addSubview:scrollView];
}

- (void)viewDidLoad {
    [self _setup];
}
```

### Thank you

[mehfuzh](https://github.com/mehfuzh) 
