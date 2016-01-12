//
//  UIView+LKTNotificationBadge.m
//  LKTNotificationBadge
//
//  Created by liem-khiet tran on 1/11/16.
//  Copyright © 2016 liem-khiet tran. All rights reserved.
//

#import "UIView+LKTNotificationBadge.h"

@implementation UIView (LKTNotificationBadge)

//***************************************************************************************************
// ADD AN IN-APP NOTIFICATION BADGE LABEL TO THE SUPER VIEW PASSED IN PARAMETER
//
// YOU NEED TO PASS IN THE ARGUMENTS :
// superView : THE SUPERVIEW WHERE THE BADGE WILL BE ADDED AS A SUBVIEW
// text : COUNT NUMBER (SHOULD NOT EXCEED 99, OTHERWISE THE COUNT WILL BE FORMATTED AS 99+)
// isTextLanguageRightToLeft : IF THE APP LAYOUT ALIGNMENT IS FROM RIGHT TO LEFT (ARABIC FOR EXAMPLE)
// tag : A TAG IF NEEDED
// insideContainer : IF YOU WANT THE BADGE INSIDE OR OUTSIDE THE SUPERVIEW
// alignment : IF THE BADGE SHOULD BE ON THE LEFT/CENTER/RIGHT SIDE OF THE SUPERVIEW
//
// THE METHOD RETURNS THE BADGE LABEL TO KEEP THE REFERENCE OF IT AND DELETE THE BADGE LABEL
// FROM THE SUPERVIEW
//***************************************************************************************************

- (UILabel *)appendTagToSuperView:(UIView *)superView
                         withText:(NSString *)text
        isTextLanguageRightToLeft:(BOOL)isTextLanguageRightToLeft
                       tag:(NSUInteger)tag
             insideContainer:(BOOL)insideContainer
               withAlignment:(LKTNotificationBadgeAlignment)alignment {
  CGRect superViewframe = superView.frame;
  CGFloat interMargin = 5.f;
  
  UILabel *labelText;
  if (alignment == LKTNotificationBadgeAlignmentLeft && insideContainer)
    labelText = [[UILabel alloc] initWithFrame:CGRectMake(isTextLanguageRightToLeft ?
                                                          superViewframe.size.width - LKTNotificationBadgeTagWidth :
                                                          0,
                                                          5,
                                                          LKTNotificationBadgeTagWidth,
                                                          LKTNotificationBadgeTagHeight)];
  else if (alignment == LKTNotificationBadgeAlignmentLeft && !insideContainer)
    labelText = [[UILabel alloc] initWithFrame:CGRectMake(isTextLanguageRightToLeft ?
                                                          superViewframe.size.width :
                                                          -LKTNotificationBadgeTagWidth - interMargin,
                                                          5,
                                                          LKTNotificationBadgeTagWidth,
                                                          LKTNotificationBadgeTagHeight)];
  else if (alignment == LKTNotificationBadgeAlignmentRight && insideContainer)
    labelText = [[UILabel alloc] initWithFrame:CGRectMake(isTextLanguageRightToLeft ?
                                                          0 :
                                                          superViewframe.size.width - LKTNotificationBadgeTagWidth,
                                                          5,
                                                          LKTNotificationBadgeTagWidth,
                                                          LKTNotificationBadgeTagHeight)];
  else if (alignment == LKTNotificationBadgeAlignmentRight && !insideContainer)
    labelText = [[UILabel alloc] initWithFrame:CGRectMake(isTextLanguageRightToLeft ?
                                                           -LKTNotificationBadgeTagWidth - interMargin :
                                                          superViewframe.size.width + interMargin,
                                                          5,
                                                          LKTNotificationBadgeTagWidth,
                                                          LKTNotificationBadgeTagHeight)];
  else
    labelText = [[UILabel alloc] initWithFrame:CGRectMake(superViewframe.size.width / 2 - LKTNotificationBadgeTagWidth / 2,
                                                          5,
                                                          LKTNotificationBadgeTagWidth,
                                                          LKTNotificationBadgeTagHeight)];
  
  labelText.textColor = UIColor.whiteColor;
  labelText.textAlignment = NSTextAlignmentCenter;
  labelText.text = text.length > 3 ? @"99+" : text;
  labelText.backgroundColor = UIColor.redColor;
  labelText.clipsToBounds = YES;
  labelText.layer.cornerRadius = 6.f;
  labelText.tag = tag;

  [superView addSubview:labelText];
  
  return labelText;
}

@end
