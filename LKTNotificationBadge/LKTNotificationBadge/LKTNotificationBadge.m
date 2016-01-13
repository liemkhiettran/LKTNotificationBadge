//
//  LKTNotificationBadge.m
//  LKTNotificationBadge
//
//  Created by liem-khiet tran on 1/13/16.
//  Copyright © 2016 liem-khiet tran. All rights reserved.
//

#import "LKTNotificationBadge.h"

#import <QuartzCore/QuartzCore.h>

@implementation LKTNotificationBadge

+ (id)sharedInstance {
  
  static LKTNotificationBadge *sharedInstance = nil;
  
  if (sharedInstance != nil) {
    return sharedInstance;
  }
  
  static dispatch_once_t once;
  
  dispatch_once(&once, ^{
    sharedInstance = [[LKTNotificationBadge alloc] init];
    sharedInstance.mutableArrayBadges = [NSMutableArray array];
  });
  
  return sharedInstance;
}

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

- (void)appendBadgeToSuperView:(UIView *)superView
                      withText:(NSString *)text
     isTextLanguageRightToLeft:(BOOL)isTextLanguageRightToLeft
                           tag:(NSNumber *)tag
               insideContainer:(BOOL)insideContainer
                 withAlignment:(LKTNotificationBadgeAlignment)alignment {
  
  CGRect superViewframe = superView.frame;
  __unused CGFloat interMargin = 5.f;
  
  CGFloat badgeWidth = 0.f;
  if (text.length >= 3)
    badgeWidth = LKTNotificationBadgeTagWidth3Characters;
  else if (text.length == 2)
    badgeWidth = LKTNotificationBadgeTagWidth2Characters;
  else
    badgeWidth = LKTNotificationBadgeTagWidth1Character;
  
  CGFloat badgeHeight = 0.f;
  if (text.length >= 3)
    badgeHeight = LKTNotificationBadgeTagHeight3Characters;
  else if (text.length == 2)
    badgeHeight = LKTNotificationBadgeTagHeight2Characters;
  else
    badgeHeight = LKTNotificationBadgeTagHeight1Character;
  
  UILabel *labelText;
  if (alignment == LKTNotificationBadgeAlignmentLeft && insideContainer)
    labelText = [[UILabel alloc] initWithFrame:CGRectMake(isTextLanguageRightToLeft ?
                                                          superViewframe.size.width - badgeWidth :
                                                          0,
                                                          5,
                                                          badgeWidth,
                                                          badgeHeight)];
  else if (alignment == LKTNotificationBadgeAlignmentLeft && !insideContainer)
    labelText = [[UILabel alloc] initWithFrame:CGRectMake(isTextLanguageRightToLeft ?
                                                          superViewframe.size.width - (badgeWidth / 2) :
                                                          -(badgeWidth / 2),
                                                          5,
                                                          badgeWidth,
                                                          badgeHeight)];
  else if (alignment == LKTNotificationBadgeAlignmentRight && insideContainer)
    labelText = [[UILabel alloc] initWithFrame:CGRectMake(isTextLanguageRightToLeft ?
                                                          0 :
                                                          superViewframe.size.width - badgeWidth,
                                                          5,
                                                          badgeWidth,
                                                          badgeHeight)];
  else if (alignment == LKTNotificationBadgeAlignmentRight && !insideContainer)
    labelText = [[UILabel alloc] initWithFrame:CGRectMake(isTextLanguageRightToLeft ?
                                                          -(badgeWidth / 2) :
                                                          superViewframe.size.width - (badgeWidth / 2),
                                                          5,
                                                          badgeWidth,
                                                          badgeHeight)];
  else
    labelText = [[UILabel alloc] initWithFrame:CGRectMake(superViewframe.size.width / 2 - badgeWidth / 2,
                                                          5,
                                                          badgeWidth,
                                                          badgeHeight)];
  
  labelText.textColor = UIColor.whiteColor;
  labelText.textAlignment = NSTextAlignmentCenter;
  labelText.text = text.length > 2 ? @"99+" : text;
  labelText.backgroundColor = UIColor.redColor;
  [labelText setFont:[UIFont boldSystemFontOfSize:14]];
  labelText.adjustsFontSizeToFitWidth = YES;
  labelText.clipsToBounds = YES;
  labelText.layer.cornerRadius = labelText.frame.size.width / 2;
  labelText.tag = tag.unsignedIntegerValue;
  
  [superView addSubview:labelText];
  
  if (![[[LKTNotificationBadge sharedInstance] mutableArrayBadges] containsObject:[NSString stringWithFormat:@"%ld", (long)labelText.tag]])
    [[[LKTNotificationBadge sharedInstance] mutableArrayBadges] addObject:labelText];
}

//********************************************************************************
// REMOVE THE BADGE LABEL VIA THE TAG ONCE THE USER INTERACTED WITH THE UI ELEMENT
//********************************************************************************
- (void)removeBadgeForTag:(NSNumber *)tag {
  
  for (UILabel *label in [[LKTNotificationBadge sharedInstance] mutableArrayBadges]) {
    if (label.tag == tag.unsignedIntegerValue) {
      [label removeFromSuperview];
      break ;
    }
  }
}

@end
