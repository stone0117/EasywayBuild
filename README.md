# EasywayBuild
简单搭建navigation &amp; tabbarcontroller


继承自SNTabBarController之后
```objc
- (void)viewDidLoad {
    
    
    // Do any additional setup after loading the view.
    [super viewDidLoad];

    self.fullScreenBack = YES;
    
    self.customViewControllers = @[
        [[ViewController alloc] initWithTitle:@"车源" normalIcon:[UIImage imageNamed:@"cy"] seletedIcon:[UIImage imageNamed:@"cy_h"]],
        [[UIViewController alloc] initWithTitle:@"寻车" normalIcon:[UIImage imageNamed:@"xc"]  seletedIcon:[UIImage imageNamed:@"xc_h"]],
        [[UIViewController alloc] initWithTitle:@"我的" normalIcon:[UIImage imageNamed:@"my"]  seletedIcon:[UIImage imageNamed:@"my_h"] ]
    ];
}
```
fullScreenBack 属性表示 是否开启 全屏滑动返回

