//
//  FFXibViewController.m
//  FFCarouselBanner
//
//  Created by Jone on 16/5/26.
//  Copyright © 2016年 Jone. All rights reserved.
//

#import "FFXibViewController.h"
#import "FFCodeViewController.h"
#import "FFCarouselBanner.h"

#ifndef kScreenWidth
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#endif

@interface FFXibViewController ()
@property (weak, nonatomic) IBOutlet FFCarouselBanner *bannerView;
@end

@implementation FFXibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"Init From Xib";

    NSArray *imageLinks = @[
                            // jpg: https://dribbble.com/snootyfox
                            @"https://d13yacurqjgara.cloudfront.net/users/102505/screenshots/2667095/homepage_1x.png",
                            @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1833469/porter.jpg",
                            @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1521183/farmers.jpg",
                            @"https://d13yacurqjgara.cloudfront.net/users/44323/screenshots/2737293/joy_dribz.png",

                            // gif: https://dribbble.com/markpear
                            @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1734216/dots9.0.gif",
                            @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/2599413/lines4.0.gif",
                            @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/2219244/dots28.gif",
                            @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/2024958/dots26.gif",
                            
                            ];
    
    __weak typeof(self) _self = self;
    self.bannerView.imageURLs = imageLinks;
    self.bannerView.placeholder = [UIImage imageNamed:@"placeholder"];
    self.bannerView.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.bannerView.selectedBlock = ^(NSUInteger selectedIndex) {
        FFCodeViewController *codeVC = [FFCodeViewController new];
        [_self.navigationController pushViewController:codeVC animated:YES];
        NSLog(@"selected index: %ld", selectedIndex);
    };
}

- (IBAction)clearCache:(id)sender {
    [self.bannerView clearCache];
}

@end
