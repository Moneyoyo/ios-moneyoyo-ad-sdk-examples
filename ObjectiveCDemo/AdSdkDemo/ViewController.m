//
//  ViewController.m
//  AdSdkDemo
//
//  Created by admin on 27/8/26.
//

#import "ViewController.h"
#import "Config.h"
#import "AdSdkDemo-Swift.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.bundleLabel.text = NSBundle.mainBundle.bundleIdentifier ?: @"no";
    self.errorLabel.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadAd];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[AdManager shared] clearBanner];
}

- (void)loadAd {
    __weak typeof(self) weakSelf = self;
    [[AdManager shared] loadBannerWithZoneId:kBannerZoneId
                               into:self.bannerContainer
                                  completion:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"%@", error);
            [weakSelf showError:error.localizedDescription];
        }
    }];
}

- (void)showError:(NSString *)message {
    self.errorLabel.text = message;
    self.errorLabel.hidden = NO;
}

@end
