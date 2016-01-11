//
//  LKTHorizontalTableView.h
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

#import <UIKit/UIKit.h>

@class LKTHorizontalTableView;

@protocol LKTHorizontalTableViewDelegate

@required

- (CGFloat)tileWidthForTableView:(LKTHorizontalTableView *)tableView;
- (CGFloat)tileInterMargin:(LKTHorizontalTableView *)tableView;
- (CGFloat)borderMargin:(LKTHorizontalTableView *)tableView;
- (NSInteger)numberOfTilesForTableView:(LKTHorizontalTableView *)tableView;
- (UIView *)tableView:(LKTHorizontalTableView *)tableView
      viewTileAtIndex:(NSUInteger)index;

@optional
- (void)tableView:(LKTHorizontalTableView *)tableView didSelectTileAtIndex:(NSUInteger)index;
- (void)horizontalScrollViewDidScroll:(UIScrollView *)scrollView;
@end

@interface LKTHorizontalTableView : UIView {
  __weak id _delegate;
}

@property (weak) id<LKTHorizontalTableViewDelegate> delegate;
@property (strong, nonatomic) UIScrollView *scrollView;

- (void)loadViewWithData;
- (UIView *)dequeueReuseTile;

@end

