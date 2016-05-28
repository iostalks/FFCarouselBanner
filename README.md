FFCarouselBanner
==============
[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/ibireme/YYWebImage/master/LICENSE)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%207%2B-blue.svg)](https://www.apple.com/nl/ios/)&nbsp;

![CaroselBannerGif](https://github.com/iostalks/FFCarouselBanner/blob/master/Demo/CaroselBannerGif.gif)

FFCarouselBanner 是一个基于 [YYWebImage](https://github.com/ibireme/YYWebImage) 的无限轮播网络图片组件。

支持 Storyboard 和 代码两种初始化方式。

它底层用 [YYCache](https://github.com/ibireme/YYCache) 实现了图片的内存和磁盘缓存，使用
 YYAnimatedImageView 支持加载 gif 动画。


用法
==============

**注意：必须将使用该控件的 ViewController 的 `automaticallyAdjustsScrollViewInsets`属性设置为 `NO`。**
	
	CGRect frame = CGRectMake(0, 64, kScreenWidth, kScreenWidth*2/3);
    FFCarouselBanner *bannerView = [FFCarouselBanner bannerWithImageURLs:imageLinks];
    bannerView.frame = frame;
    bannerView.scrollTimeInterval = 2.0;
    bannerView.placeholder = [UIImage imageNamed:@"placeholder"];
    self.banner.selectedBlock = ^(NSUInteger selectedIndex) {
        NSLog(@"index: %lu", (unsigned long)selectedIndex);
    };
    [self.view addSubview:bannerView];
    

手动安装
==============
1. 下载 FFCarouselBanner 文件夹内的所有内容。
2. 将 FFCarouselBanner 内的源文件添加(拖放)到你的工程。
3. 链接以下 frameworks:
	* UIKit
	* CoreFoundation
	* QuartzCore
	* sqlite3
	* libz
4. 导入 `FFCarouselBanner.h`。
5. 注意：如果工程中已经使用了 `<YYKit/YYKit.h>` 只要添加 `FFCarouselBanner.h`和`FFCarouselBanner.m`两个文件即可。
    
系统要求
==============
该项目最低支持 `iOS 7.0` 和 `Xcode 7.0`。