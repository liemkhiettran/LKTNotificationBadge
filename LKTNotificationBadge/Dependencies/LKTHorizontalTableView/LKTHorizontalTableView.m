//
//  LKTHorizontalTableView.m
//  LKTHorizontalTableView
//
//  Created by liem-khiet tran on 7/7/15.
//  Copyright (c) 2015-2016 liem-khiet tran. All rights reserved.
//  https://github.com/liemkhiettran/LKTHorizontalTableView
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//


#import "LKTHorizontalTableView.h"

@interface LKTHorizontalTableView () <UIScrollViewDelegate>

@property (strong, nonatomic) NSMutableArray *mutableArrayTiles;
@property (readonly, nonatomic) NSUInteger currentTileIndex;
@property (nonatomic) NSUInteger visibleTileIndex;
@property (strong, nonatomic) NSMutableArray *mutableArrayTilePool;
@property (strong, nonatomic) NSNumber *tileWidth;
@property (nonatomic) NSInteger visibleTileCount;
@property (nonatomic) NSUInteger currentVisibleTileIndex;

@end

@implementation LKTHorizontalTableView

#pragma mark -
#pragma mark - INIT

- (void)awakeFromNib {
  [self prepareForView];
}

- (instancetype)init {
  self = [super init];
  if (self)
    [self prepareForView];
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  
  if (self)
    [self prepareForView];
  return self;
}

- (void)layoutSubviews {
  [self layoutTiles];
  [self didChangeCurrentTileIndex];
}

//***********************************
// SET CONTENTSIZE OF THE SCROLLVIEW
// TAKING IN ACCOUNT THE INTER MARGIN
// BETWEEN EACH TILE TO POSITION THE
// TILE ON THE X AXIS
//***********************************
- (void)layoutTiles {
  CGSize tileSize = self.bounds.size;
  
  CGFloat tileInterMargin = 0.f;
  CGFloat borderMargin = 0.f;
  
  if (_delegate) {
    tileInterMargin = [_delegate tileInterMargin:self];
    borderMargin = [_delegate borderMargin:self];
  }
  _scrollView.contentSize = CGSizeMake((_mutableArrayTiles.count * ([self getTileWidth] + tileInterMargin) - tileInterMargin) + borderMargin * 2, tileSize.height);
}

- (void)prepareForView {
  _mutableArrayTilePool = [[NSMutableArray alloc] initWithCapacity:3];
  
  _tileWidth = nil;
  
  self.clipsToBounds = YES;
  self.autoresizesSubviews = YES;
  
  _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
  _scrollView.backgroundColor = UIColor.clearColor;
  _scrollView.autoresizesSubviews = YES;
  _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  _scrollView.showsHorizontalScrollIndicator =
  _scrollView.showsVerticalScrollIndicator = NO;
  _scrollView.alwaysBounceVertical = NO;
  _scrollView.delegate = self;
  [self addSubview:_scrollView];
}

- (void)loadViewWithData {
  _mutableArrayTiles = [NSMutableArray array];
  
  NSUInteger numberOfVisibleTiles = [self numberOfTiles];
  
  for (int i = 0; i < numberOfVisibleTiles; i++)
    [_mutableArrayTiles addObject:[NSNull null]];
  
  [self setNeedsLayout];
}

#pragma mark -
#pragma mark - TILE

- (CGFloat)getTileWidth {
  if (!_tileWidth)
    if (_delegate) {
      _tileWidth = [NSNumber numberWithFloat:[_delegate tileWidthForTableView:self]];
    }
  return _tileWidth.floatValue;
}

- (CGSize)tableViewSize {
  return _scrollView.bounds.size;
}

- (BOOL)isTileDisplayed:(NSUInteger)index {
  return [_mutableArrayTiles objectAtIndex:index] != [NSNull null];
}

//***********************************
// SET LAYOUT FOR EACH VISIBLE TILE
// TAKING IN ACCOUNT THE INTER MARGIN
// BETWEEN EACH TILE TO POSITION THE
// TILE ON THE X AXIS
//***********************************
- (void)layoutForTileAtIndex:(NSUInteger)index {
  UIView *view = [self viewForTileAtIndex:index];
  
  CGFloat viewWidth = view.bounds.size.width;
  CGSize viewSize = [self tableViewSize];

  CGFloat xPosition = _delegate ?
  (viewWidth + [_delegate tileInterMargin:self]) * index:
  viewWidth * index;
  
  CGFloat borderMargin = 0.f;
  
  if (_delegate)
    borderMargin = [_delegate borderMargin:self];
  
  CGRect rect = CGRectMake(xPosition + borderMargin,
                           0,
                           viewWidth,
                           viewSize.height);
  
  view.frame = rect;
}

- (void)queueTileView:(UIView *)view {
  if (_mutableArrayTilePool.count >= 3)
    return;
  [_mutableArrayTilePool addObject:view];
}

- (UIView *)dequeueReuseTile {
  UIView *view = [_mutableArrayTilePool lastObject];
  if (view) {
    [_mutableArrayTilePool removeLastObject];
    NSLog(@"Tile reused from pool");
  }
  
  return view;
}

- (void)removeTileAtIndex:(NSUInteger)index {
  if ([_mutableArrayTiles objectAtIndex:index] != [NSNull null]) {
    NSLog(@"Tile removed at index %li", index);
    
    UIView *view = [_mutableArrayTiles objectAtIndex:index];
    [self queueTileView:view];
    [view removeFromSuperview];
    [_mutableArrayTiles replaceObjectAtIndex:index withObject:[NSNull null]];
  }
}

- (NSUInteger)numberOfTiles {
  NSUInteger numberOfTiles = 0;
  if (_delegate)
    numberOfTiles = [_delegate numberOfTilesForTableView:self];
  return numberOfTiles;
}

- (UIView *)viewForTileAtIndex:(NSUInteger)index {
  NSParameterAssert(index >= 0);
  NSParameterAssert(index < _mutableArrayTiles.count);
  
  UIView *view;
  if ([_mutableArrayTiles objectAtIndex:index] == [NSNull null]) {
    if (_delegate) {
      view = [_delegate tableView:self viewTileAtIndex:index];
      
      [_mutableArrayTiles replaceObjectAtIndex:index withObject:view];
      [_scrollView addSubview:view];
      
      NSLog(@"Tile added for index %li", index);
    }
  } else {
    view = [_mutableArrayTiles objectAtIndex:index];
  }
  
  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(tapGestureSelect:)];
  view.tag = index;
  view.userInteractionEnabled = YES;
  [view addGestureRecognizer:tapGesture];
  
  return view;
}

- (void)tapGestureSelect:(UITapGestureRecognizer *)sender {
  [self didSelectTileAtIndex:sender.view.tag];
}

- (void)didSelectTileAtIndex:(NSUInteger)index {
  if (_delegate)
    [_delegate tableView:self didSelectTileAtIndex:index];
}

- (void)didChangeCurrentTileIndex {
  CGSize tableViewSize = [self tableViewSize];
  
  CGFloat tileInterMargin = 0.f;
  
  if (_delegate)
    tileInterMargin = [_delegate tileInterMargin:self];

  CGFloat tileWidth = [self getTileWidth] + tileInterMargin;
  
  _visibleTileCount = tableViewSize.width / tileWidth + 2;
  
  NSInteger leftMostPageIndex = -1;
  NSInteger rightMostPageIndex = 0;
  
  for (NSInteger i = -2; i < _visibleTileCount; i++) {
    NSInteger index = _currentVisibleTileIndex + i;
    if (index < _mutableArrayTiles.count && index >= 0) {
      [self layoutForTileAtIndex:index];
      if (leftMostPageIndex < 0)
        leftMostPageIndex = index;
      rightMostPageIndex = index;
    }
  }
  
  for (NSInteger i = 0; i < leftMostPageIndex; i++)
    [self removeTileAtIndex:i];
  for (NSInteger i = rightMostPageIndex + 1; i < _mutableArrayTiles.count; i++)
    [self removeTileAtIndex:i];
}

//************************************
// CALCULATE THE VISIBLE TILE INDEX TO
// DISPLAY ON THE SCREEN
// TAKING IN ACCOUNT THE INTER MARGIN
// BETWEEN EACH TILE
//************************************
- (NSUInteger)visibleTileIndex {
  CGFloat tileInterMargin = 0.f;
  
  if (_delegate)
    tileInterMargin = [_delegate tileInterMargin:self];
  
  NSUInteger visibleTileIndex = _scrollView.contentOffset.x / ([self getTileWidth] + tileInterMargin);
  
  return visibleTileIndex;
}

- (void)setVisibleTileIndex:(NSUInteger)index {
  
  _scrollView.contentOffset = CGPointMake(index * [self tableViewSize].width, 0);
}

#pragma mark -
#pragma mark UISCROLLVIEWDELEGATE METHODS

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  
  if (_delegate)
    [_delegate horizontalScrollViewDidScroll:scrollView];
  
  NSUInteger newTileIndex = self.visibleTileIndex;
  
  if (newTileIndex == _currentVisibleTileIndex)
    return ;
  
  _currentVisibleTileIndex = newTileIndex;
  _currentTileIndex = newTileIndex;
  
  [self didChangeCurrentTileIndex];
}

@end
