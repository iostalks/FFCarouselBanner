//
//  FFCarouselBanner.h
//  FFCarouselBanner
//
//  Created by Jone on 16/5/25.
//  Copyright © 2016年 Jone. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

// GitHub Repository: https://github.com/iostalks/FFCarouselBanner
///======================================================================================
/// NOTE: You must to set UIViewcontroller `automaticallyAdjustsScrollViewInsets` to `NO`
///======================================================================================


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^FFCarouselBannerDidSelectedBlock)(NSUInteger currentIndex);

/** Values for FFPageControlAlignment */
typedef NS_ENUM(NSUInteger, FFPageControlAlignment) {
    FFPageControlAlignmentLeft,
    FFPageControlAlignmentCenter,
    FFPageControlAlignmentRight
};

@interface FFCarouselBanner : UIView

@property (nullable, nonatomic, copy)     NSArray        *imageURLs;
@property (nullable, nonatomic, strong)   UIImage        *placeholder;  // default is nill.
@property (nullable, nonatomic, readonly) UIPageControl  *pageControl;
@property (nonatomic, assign)             NSTimeInterval           scrollTimeInterval;   // default value is 3.0s.
@property (nonatomic, assign)             FFPageControlAlignment   pageControlAlignment; // default is FFPageControlAlignmentCenter.
@property (nullable, nonatomic, copy)     FFCarouselBannerDidSelectedBlock selectedBlock;

+ (nullable FFCarouselBanner *)bannerWithImageURLs:(nullable NSArray *)imageURLs;

- (nullable instancetype)initWithImageURLs:(nullable NSArray *)imageURLs;

- (nullable instancetype)initWithImageURLs:(nullable NSArray *)imageURLs
                           placeholder:(nullable UIImage *)placeholder
                         selectedBlock:(nullable FFCarouselBannerDidSelectedBlock)selectedBlock;

/**
 *  Clear image cache base on YYImageCache
 */
- (void)clearCache;

@end

NS_ASSUME_NONNULL_END