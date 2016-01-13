//
//  ViewController.m
//  LKTNotificationBadge
//
//  Created by liem-khiet tran on 1/11/16.
//  Copyright © 2016 liem-khiet tran. All rights reserved.
//  https://github.com/liemkhiettran/LKTNotificationBadge
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

#import "ViewController.h"
#import "LKTTileCell.h"
#import "LKTNotificationBadge.h"

@interface ViewController ()

@property (strong, nonatomic) LKTHorizontalTableView *tableViewTo4;

@property (strong, nonatomic) NSMutableArray *arrayFiguresTo4;

@property (strong, nonatomic) LKTTileCell *tileCell;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  _arrayFiguresTo4 = [NSMutableArray array];
  
  [LKTNotificationBadge sharedInstance];
  
  NSUInteger i = 0;
  while (i < 4) {
    [_arrayFiguresTo4 addObject:[NSString stringWithFormat:@"%ld", i]];
    i += 1;
  }
  
  _tableViewTo4 = [[LKTHorizontalTableView alloc] init];
  _tableViewTo4.translatesAutoresizingMaskIntoConstraints = NO;
  _tableViewTo4.tag = 4;
  _tableViewTo4.delegate = self;
  [self.view addSubview:_tableViewTo4];
  
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_tableViewTo4]-0-|"
                                                                    options:NSLayoutFormatDirectionLeftToRight
                                                                    metrics:nil
                                                                      views:NSDictionaryOfVariableBindings(_tableViewTo4)]];
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_tableViewTo4(150)]-0-|"
                                                                    options:NSLayoutFormatDirectionLeftToRight
                                                                    metrics:nil
                                                                      views:NSDictionaryOfVariableBindings(_tableViewTo4)]];
  
  [_tableViewTo4 loadViewWithData];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark HorizontalTableViewDelegate methods

- (NSInteger)numberOfTilesForTableView:(LKTHorizontalTableView *)tableView {
  return _arrayFiguresTo4.count;

}

- (UIView *)tableView:(LKTHorizontalTableView *)tableView
      viewTileAtIndex:(NSUInteger)index {
  
  LKTTileCell *tile = (LKTTileCell *)[tableView dequeueReuseTile];
  
  if (!tile) {
    NSLog(@"Constructing new view");
    
    _tileCell = [[LKTTileCell alloc] initWithFrame:CGRectMake((150 + [self tileInterMargin:tableView]) * index, 0, 150, 150)];
    _tileCell.labelTitle.frame = CGRectMake(_tileCell.frame.size.width / 4,
                                            _tileCell.frame.size.height / 4,
                                            _tileCell.frame.size.width / 2,
                                            _tileCell.frame.size.height / 2);
    
    tile = _tileCell;
  }
  
  tile.layer.borderColor = UIColor.redColor.CGColor;
  tile.layer.borderWidth = 1.f;
  
  tile.labelTitle.text = [NSString stringWithFormat:@"%ld", index];
  
  tile.labelTitle.text = [NSString stringWithFormat:@"%@", [_arrayFiguresTo4 objectAtIndex:index]];
  
  NSLog(@"%llu", tile.labelTitle.text.longLongValue);
  
  [[LKTNotificationBadge sharedInstance] appendBadgeToSuperView:tile
                                                        withText:tile.labelTitle.text
                                                            font:nil
                                                       textColor:UIColor.whiteColor
                                       isTextLanguageRightToLeft:NO
                                                 backgroundColor:UIColor.redColor
                                                             tag:[NSNumber numberWithUnsignedInteger:index]
                                                 insideContainer:NO
                                                    atEdgeCorner:YES
                                                       alignment:LKTNotificationBadgeAlignmentRight];
  
  
  return tile;
}

- (CGFloat)tileInterMargin:(LKTHorizontalTableView *)tableView {
  return 20.f;
}

- (CGFloat)borderMargin:(LKTHorizontalTableView *)tableView {
  return 20.f;
}

- (CGFloat)tileWidthForTableView:(LKTHorizontalTableView *)tableView {
  return 150.0f;
}

- (void)horizontalScrollViewDidScroll:(UIScrollView *)scrollView {
  
}

- (void)tableView:(LKTHorizontalTableView *)tableView didSelectTileAtIndex:(NSUInteger)index {
  NSLog(@"\n\n****************************************************\nView selected : %@\n****************************************************\n\n", [NSString stringWithFormat:@"%@", [_arrayFiguresTo4 objectAtIndex:index]]);
  
  [[LKTNotificationBadge sharedInstance] removeBadgeForTag:[NSNumber numberWithUnsignedInteger:index]];
}

@end