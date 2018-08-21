---
layout: page
permalink: /ios/worklog/screen
---

## screen

status bar = 高度为20px  (不一定， 有的设备的状态栏比这个高)
navigation bar = 竖屏时为44px；横屏为32px

self.navigationController.navigationBar.frame.size.height + self.navigationController.navigationBar.frame.origin.y  计算实际高度

通常为容器视图来管理屏幕属性，如是否显示navigation bar，y点从哪开始等等

ios7.0之后就是全屏布局
iOS7.0之前导航栏默认是不透明的, ios7.0之后默认是透明的
注意: 如果导航条透明状态, 那么原点在屏幕的左上角.如果导航条不透明, 那么原点在屏幕左上角下面64px的位置.

透明度translucent是导航栏的属性, 不是导航视图控制器的属性
firstNevigation.navigationBar.translucent = NO;

当controller的view是UIview时，会自动把y坐标减64
需要把autoresize subviews设置成NO
导舰栏要设置成不透明， 不然xib不计算导航栏了高度

### 沉浸式状态拦
自定义容器类  实现：

    - (void)viewDidAppear:(BOOL)animated {
        [super viewDidAppear:animated];
        self.delegate = self;
        [self setStatusBar:-20];
    }

    - (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
        if(self.viewControllers[0] != viewController){
            [self setStatusBar:0];
        } else {
            [self setStatusBar:-20];
        }
    }
    
    - (UIStatusBarStyle)preferredStatusBarStyle {
        return UIStatusBarStyleDefault;
    }
    
    - (void)setStatusBar:(int)size {
        if (@available(iOS 11.0, *)) {
            UIEdgeInsets newSafeAreaInsets = self.view.safeAreaInsets;
            newSafeAreaInsets.top = size;
            self.additionalSafeAreaInsets = newSafeAreaInsets;
        } else {
            // Fallback on earlier versions
        }
    }

### 从64px的位置开始计算

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;

### 状态栏变黑
//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

状态栏变黑不是主window没有背景  就是当前ViewController的主view没有背景
AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    delegate.window.backgroundColor = UIColor.whiteColor;
