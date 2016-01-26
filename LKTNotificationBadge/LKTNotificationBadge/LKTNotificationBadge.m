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

//***************************************************************************************************
// ADD AN IN-APP NOTIFICATION BADGE LABEL TO THE SUPER VIEW PASSED IN PARAMETER
//
// YOU NEED TO PASS IN THE ARGUMENTS :
// superView : THE SUPERVIEW WHERE THE BADGE WILL BE ADDED AS A SUBVIEW
// text : COUNT NUMBER (SHOULD NOT EXCEED 99, OTHERWISE THE COUNT WILL BE FORMATTED AS 99+)
// font : TEXT FONT
// textColor : TEXT COLOR
// isTextLanguageRightToLeft : IF THE APP LAYOUT ALIGNMENT IS FROM RIGHT TO LEFT (ARABIC FOR EXAMPLE)
// backgroundColor : THE BADGE BACKGROUND COLOR
// tag : A TAG IF NEEDED
// insideContainer : IF YOU WANT THE BADGE INSIDE OR OUTSIDE THE SUPERVIEW
// atEdgeCorner : THE BADGE WILL OVERLAY THE EDGE TOP CORNER
// alignment : IF THE BADGE SHOULD BE ON THE LEFT/CENTER/RIGHT SIDE OF THE SUPERVIEW
//
// THE METHOD RETURNS THE BADGE LABEL WITH ITS FRAME SET
//***************************************************************************************************

- (instancetype)initBadgeToSuperView:(UIView *)superView
                            withText:(NSString *)text
                                font:(UIFont *)font
                           textColor:(UIColor *)textColor
           isTextLanguageRightToLeft:(BOOL)isTextLanguageRightToLeft
                     backgroundColor:(UIColor *)backgroundColor
                                 tag:(NSNumber *)tag
                     insideContainer:(BOOL)insideContainer
                        atEdgeCorner:(BOOL)atEdgeCorner
                           alignment:(LKTNotificationBadgeAlignment)alignment {
  
    CGRect superViewframe = superView.frame;
    
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
    
    CGFloat yPosition = atEdgeCorner ?
    - (badgeWidth / 2) :
    (superView.frame.size.height / 2 - (badgeWidth / 2));
    
  if (alignment == LKTNotificationBadgeAlignmentLeft && insideContainer)
    self = [super initWithFrame:CGRectMake(isTextLanguageRightToLeft ?
                                           superViewframe.size.width - badgeWidth :
                                           0,
                                           yPosition,
                                           badgeWidth,
                                           badgeHeight)];
  else if (alignment == LKTNotificationBadgeAlignmentLeft && !insideContainer)
    self = [super initWithFrame:CGRectMake(isTextLanguageRightToLeft ?
                                           superViewframe.size.width - (badgeWidth / 2) :
                                           -(badgeWidth / 2),
                                           yPosition,
                                           badgeWidth,
                                           badgeHeight)];
  else if (alignment == LKTNotificationBadgeAlignmentRight && insideContainer)
    self = [super initWithFrame:CGRectMake(isTextLanguageRightToLeft ?
                                           0 :
                                           superViewframe.size.width - badgeWidth,
                                           yPosition,
                                           badgeWidth,
                                           badgeHeight)];
  else if (alignment == LKTNotificationBadgeAlignmentRight && !insideContainer)
    self = [super initWithFrame:CGRectMake(isTextLanguageRightToLeft ?
                                           -(badgeWidth / 2) :
                                           superViewframe.size.width - (badgeWidth / 2),
                                           yPosition,
                                           badgeWidth,
                                           badgeHeight)];
  else
    self = [super initWithFrame:CGRectMake(superViewframe.size.width / 2 - badgeWidth / 2,
                                           yPosition,
                                           badgeWidth,
                                           badgeHeight)];
  
  if (self) {
    
    self.backgroundColor = UIColor.clearColor;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                       0,
                                                       self.frame.size.width,
                                                       self.frame.size.height)];
    [self addSubview:_label];
    [self bringSubviewToFront:_label];
    
    _label.textColor = textColor ? textColor : UIColor.whiteColor;
    _label.textAlignment = NSTextAlignmentCenter;
    _label.text = text.length > 2 ? @"99+" : text;
    _label.backgroundColor = UIColor.redColor;
    [_label setFont:font ? font : [UIFont boldSystemFontOfSize:14]];
    _label.adjustsFontSizeToFitWidth = YES;
    _label.clipsToBounds = YES;
    self.layer.cornerRadius =
    _label.layer.cornerRadius = self.frame.size.width / 2;
    self.tag = tag.unsignedIntegerValue;
  }
  
  return self;
}

@end
