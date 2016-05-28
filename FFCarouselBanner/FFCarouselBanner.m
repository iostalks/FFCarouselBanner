//
//  FFCarouselBanner.m
//  FFCarouselBanner
//
//  Created by Jone on 16/5/25.
//  Copyright © 2016年 Jone. All rights reserved.
//

#import "FFCarouselBanner.h"

#import "YYTimer.h"
#import "UIView+YYAdd.h"

#if __has_include(<YYKit/YYKit.h>)
#import <YYKit/YYKit.h>
#else
#import "YYWebImage.h"
#endif

@interface FFCarouselBannerCollectionViewCell: UICollectionViewCell
@property (nonatomic, strong) YYAnimatedImageView *webImageView;
@end

@implementation FFCarouselBannerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _webImageView = [YYAnimatedImageView new];
        _webImageView.size = self.size;
        _webImageView.clipsToBounds = YES;
        _webImageView.contentMode = UIViewContentModeScaleToFill;
        _webImageView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_webImageView];
    }
    return self;
}

- (void)setImageURL:(NSURL *)imageURL placeholder:(UIImage *)placeholder
{
#if __has_include(<YYKit/YYKit.h>)
    [_webImageView setImageWithURL:imageURL placeholder:placeholder options:YYWebImageOptionShowNetworkActivity completion:NULL];
#else
    [_webImageView yy_setImageWithURL:imageURL placeholder:placeholder options:YYWebImageOptionShowNetworkActivity completion:NULL];
#endif
}

@end


NSUInteger const kMultipleItems = 999;
static NSString * const kFFCarouselBannerCollectionViewCellID = @"kFFCarouselBannerCollectionViewCellID";

@interface FFCarouselBanner()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, readwrite) UIPageControl *pageControl;
@end

@implementation FFCarouselBanner {
    UICollectionView *_collectionVew;
    UICollectionViewFlowLayout *_flowLayout;
    
    NSArray *_imageURLs;
    YYTimer *_timer;
}

#pragma mark - Pulbic

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self baseInitializtion];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self baseInitializtion];
    }
    return self;
}

+ (nullable FFCarouselBanner *)bannerWithImageURLs:(nullable NSArray *)imageURLs
{
    return [[FFCarouselBanner alloc] initWithImageURLs:imageURLs];
}

- (nullable instancetype)initWithImageURLs:(nullable NSArray *)imageURLs
{
    return [self initWithImageURLs:imageURLs placeholder:nil selectedBlock:nil];
}

- (nullable instancetype)initWithImageURLs:(nullable NSArray *)imageURLs
                               placeholder:(nullable UIImage *)placeholder
                             selectedBlock:(nullable FFCarouselBannerDidSelectedBlock)selectedBlock
{
    self = [super init];
    if (self) {
        _imageURLs = [imageURLs copy];
        _placeholder = placeholder;
        _selectedBlock = selectedBlock;
        [self baseInitializtion];
    }
    return self;
}

- (void)clearCache
{
    [[YYImageCache sharedCache].memoryCache removeAllObjects];
    [[YYImageCache sharedCache].diskCache removeAllObjectsWithBlock:^{}];
    [_collectionVew performSelector:@selector(reloadData) withObject:nil afterDelay:0.1];
}

- (void)layoutSubviews
{
    if (self.size.width == 0 || self.size.height == 0) return;
    
    _collectionVew.size  = self.size;
    _flowLayout.itemSize = self.size;

    [self layoutPageControl];
    [self scrollToStartIndex];
    [super layoutSubviews];
}

#pragma mark - Layout Helper

- (void)layoutPageControl
{
    CGFloat kMarginSpace = 16.0f;
    _pageControl.width = kMarginSpace * _imageURLs.count;
    _pageControl.bottom  = self.height - kMarginSpace;
    switch (_pageControlAlignment) {
        case FFPageControlAlignmentLeft:
            _pageControl.left = kMarginSpace;
            break;
        case FFPageControlAlignmentCenter:
            _pageControl.centerX = self.centerX;
            break;
        case FFPageControlAlignmentRight:
            _pageControl.right = self.width - kMarginSpace;
            break;
    }
}

- (void)scrollToStartIndex
{
    if (_imageURLs.count > 1) {
        NSUInteger startIndex = _imageURLs.count * kMultipleItems / 2 - _imageURLs.count / 2;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:startIndex inSection:0];
        [_collectionVew scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }

}

#pragma mark - Accesser

- (void)setImageURLs:(NSArray *)imageURLs
{
    if (_imageURLs != imageURLs) {
        _imageURLs = imageURLs;
        _pageControl.numberOfPages = _imageURLs.count;
        if (imageURLs.count > 1) [self initializationTimer];
        [_collectionVew reloadData];
    }
}

- (void)setScrollTimeInterval:(NSTimeInterval)scrollTimeInterval
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    if (scrollTimeInterval > 0) {
        _scrollTimeInterval = scrollTimeInterval;
        [self initializationTimer];
    }
}

#pragma mark - Private

- (void)baseInitializtion
{
    [self configureComponent];
    if (_imageURLs.count > 1) {
        [self initializationTimer];
    }
}

- (void)configureComponent
{
    _scrollTimeInterval = 3;
    _pageControlAlignment = FFPageControlAlignmentCenter;
    
    _flowLayout = [UICollectionViewFlowLayout new];
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionVew = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
    _collectionVew.backgroundColor = [UIColor whiteColor];
    _collectionVew.showsVerticalScrollIndicator = NO;
    _collectionVew.showsHorizontalScrollIndicator = NO;
    _collectionVew.pagingEnabled = YES;
    _collectionVew.scrollsToTop = NO;
    _collectionVew.dataSource = self;
    _collectionVew.delegate = self;
    [_collectionVew registerClass:[FFCarouselBannerCollectionViewCell class]
       forCellWithReuseIdentifier:kFFCarouselBannerCollectionViewCellID];
    [self addSubview:_collectionVew];
    [_collectionVew reloadData];

    _pageControl = [UIPageControl new];
    _pageControl.numberOfPages = _imageURLs.count;
    _pageControl.hidesForSinglePage = YES;
    [self addSubview:self.pageControl];
}

- (void)initializationTimer
{
    _timer = [YYTimer timerWithTimeInterval:_scrollTimeInterval
                                     target:self
                                   selector:@selector(loopImages:)
                                    repeats:YES];
    
}

- (void)loopImages:(YYTimer *)timer
{
    NSUInteger targetRow = [self currentRow] + 1;
    BOOL isInvalidRow = targetRow >= (_imageURLs.count * kMultipleItems) || targetRow <= 0;
    if (isInvalidRow) {
        targetRow = _imageURLs.count * kMultipleItems / 2 - _imageURLs.count / 2;
    }
    
    NSIndexPath *targetIndexPath = [NSIndexPath indexPathForRow:targetRow inSection:0];
    [_collectionVew scrollToItemAtIndexPath:targetIndexPath
                           atScrollPosition:UICollectionViewScrollPositionNone
                                   animated:!isInvalidRow];
}

- (NSUInteger)currentRow
{
    return (_collectionVew.contentOffset.x + 1) / _flowLayout.itemSize.width;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger currentIndex = indexPath.row % _imageURLs.count;
    if (self.selectedBlock) {
        self.selectedBlock(currentIndex);
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_imageURLs.count <= 1) {
        return _imageURLs.count;
    }
    return (_imageURLs.count * kMultipleItems);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FFCarouselBannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kFFCarouselBannerCollectionViewCellID forIndexPath:indexPath];
    [cell setImageURL:_imageURLs[indexPath.row % _imageURLs.count] placeholder:_placeholder];
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _pageControl.currentPage = [self currentRow] % _imageURLs.count;
}

@end
