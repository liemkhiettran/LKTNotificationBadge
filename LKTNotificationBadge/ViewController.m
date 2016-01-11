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

@interface ViewController ()

@property (strong, nonatomic) LKTHorizontalTableView *tableViewTo50;
@property (strong, nonatomic) LKTHorizontalTableView *tableViewTo100;
@property (strong, nonatomic) NSMutableArray *arrayFiguresTo50;
@property (strong, nonatomic) NSMutableArray *arrayFiguresTo100;

@property (strong, nonatomic) LKTTileCell *tileCell;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  _arrayFiguresTo50 = [NSMutableArray array];
  NSUInteger step = 2;
  NSUInteger i = 0;
  while (i < 50) {
    [_arrayFiguresTo50 addObject:[NSString stringWithFormat:@"%ld", i]];
    i += step;
  }
  
  _arrayFiguresTo100 = [NSMutableArray array];
  while (i < 100) {
    [_arrayFiguresTo100 addObject:[NSString stringWithFormat:@"%ld", i]];
    i += step;
  }
  
  _tableViewTo50 = [[LKTHorizontalTableView alloc] init];
  _tableViewTo50.translatesAutoresizingMaskIntoConstraints = NO;
  _tableViewTo50.tag = 50;
  _tableViewTo50.delegate = self;
  [self.view addSubview:_tableViewTo50];
  
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_tableViewTo50]-0-|"
                                                                    options:NSLayoutFormatDirectionLeftToRight
                                                                    metrics:nil
                                                                      views:NSDictionaryOfVariableBindings(_tableViewTo50)]];
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_tableViewTo50(150)]-0-|"
                                                                    options:NSLayoutFormatDirectionLeftToRight
                                                                    metrics:nil
                                                                      views:NSDictionaryOfVariableBindings(_tableViewTo50)]];
  
  UIView *previousView = _tableViewTo50;
  
  //****************************************************************************
  UIView  *seperator = [[UIView alloc]init];
  [seperator setTranslatesAutoresizingMaskIntoConstraints:NO];
  seperator.backgroundColor = UIColor.grayColor;
  [self.view addSubview:seperator];
  
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[seperator]-0-|"
                                                                    options:NSLayoutFormatDirectionLeftToRight
                                                                    metrics:nil
                                                                      views:NSDictionaryOfVariableBindings(seperator)]];
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[seperator(1)]-0-[previousView]"
                                                                    options:NSLayoutFormatDirectionLeftToRight
                                                                    metrics:nil
                                                                      views:NSDictionaryOfVariableBindings(seperator, previousView)]];
  previousView = seperator;
  
  //****************************************************************************
  
  _tableViewTo100 = [[LKTHorizontalTableView alloc] init];
  _tableViewTo100.translatesAutoresizingMaskIntoConstraints = NO;
  _tableViewTo100.tag = 100;
  _tableViewTo100.delegate = self;
  [self.view addSubview:_tableViewTo100];
  
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_tableViewTo100]-0-|"
                                                                    options:NSLayoutFormatDirectionLeftToRight
                                                                    metrics:nil
                                                                      views:NSDictionaryOfVariableBindings(_tableViewTo100)]];
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_tableViewTo100(150)]-0-[previousView]"
                                                                    options:NSLayoutFormatDirectionLeftToRight
                                                                    metrics:nil
                                                                      views:NSDictionaryOfVariableBindings(_tableViewTo100, previousView)]];
  
  [_tableViewTo50 loadViewWithData];
  [_tableViewTo100 loadViewWithData];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark HorizontalTableViewDelegate methods

- (void)tableView:(LKTHorizontalTableView *)tableView didSelectTileAtIndex:(NSUInteger)index {
  NSLog(@"\n\n****************************************************\nView selected : %@\n****************************************************\n\n", [NSString stringWithFormat:@"%@", tableView.tag == _tableViewTo50.tag ? [_arrayFiguresTo50 objectAtIndex:index] : [_arrayFiguresTo100 objectAtIndex:index]]);
}

- (NSInteger)numberOfTilesForTableView:(LKTHorizontalTableView *)tableView {
  if (tableView.tag == 50)
    return _arrayFiguresTo50.count;
  else
    return _arrayFiguresTo100.count;
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
  
  tile.labelTitle.text = tableView.tag == _tableViewTo50.tag ?
  [NSString stringWithFormat:@"%@", [_arrayFiguresTo50 objectAtIndex:index]] :
  [NSString stringWithFormat:@"%@", [_arrayFiguresTo100 objectAtIndex:index]];
  
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

@end