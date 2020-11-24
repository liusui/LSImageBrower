//
//  ViewController.m
//  demo
//
//  Created by liusui on 2020/11/5.
//

#import "ViewController.h"
#import "XXImageBrowser.h"

@interface ViewController () <UIGestureRecognizerDelegate>
@property(nonatomic, strong) UIView *backView;
@property(nonatomic, strong) XXImageBrowser *imageBrowser;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.imageBrowser];
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 300)];
        _backView.backgroundColor = [UIColor cyanColor];
    }
    return _backView;
}

- (XXImageBrowser *)imageBrowser {
    if (!_imageBrowser) {
        _imageBrowser = [[XXImageBrowser alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
        _imageBrowser.imageview.image = [UIImage imageNamed:@"test.jpg"];
    }
    return _imageBrowser;
}

@end
