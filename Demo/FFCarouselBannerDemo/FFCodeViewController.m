//
//  FFCodeViewController.m
//  FFCarouselBanner
//
//  Created by Jone on 16/5/26.
//  Copyright © 2016年 Jone. All rights reserved.
//

#import "FFCodeViewController.h"
#import "FFCarouselBanner.h"

#ifndef kScreenWidth
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#endif

@interface FFCodeViewController ()
@property (nonatomic, strong) FFCarouselBanner *banner;
@end

@implementation FFCodeViewController

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"Init By Code";
    
    NSArray *imageLinks = @[
                            // gif: https://dribbble.com/markpear
                            @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1734216/dots9.0.gif",
                            @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/2599413/lines4.0.gif",
                            @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/2219244/dots28.gif",
                            @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/2024958/dots26.gif",

                            // jpg: https://dribbble.com/snootyfox
                            @"https://d13yacurqjgara.cloudfront.net/users/102505/screenshots/2667095/homepage_1x.png",
                            @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1833469/porter.jpg",
                            @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1521183/farmers.jpg",
                            @"https://d13yacurqjgara.cloudfront.net/users/44323/screenshots/2737293/joy_dribz.png",
                            
    ];
    
    CGRect frame = CGRectMake(0, 64, kScreenWidth, kScreenWidth*2/3);
    self.banner = [FFCarouselBanner bannerWithImageURLs:imageLinks];
    self.banner.frame = frame;
    self.banner.scrollTimeInterval = 2.0;
    self.banner.placeholder = [UIImage imageNamed:@"placeholder"];
    self.banner.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:1.0 green:0.502 blue:0.0 alpha:1.0];
    self.banner.pageControlAlignment = FFPageControlAlignmentRight;
    self.banner.selectedBlock = ^(NSUInteger selectedIndex) {
        NSLog(@"index: %lu", (unsigned long)selectedIndex);
    };
    
    [self.view addSubview:_banner];
    
}
@end;
