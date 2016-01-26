//
//  LKTNotificationBadge.h
//  LKTNotificationBadge
//
//  Created by liem-khiet tran on 1/13/16.
//  Copyright © 2016 liem-khiet tran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define LKTNotificationBadgeTagWidth3Characters 30.f
#define LKTNotificationBadgeTagWidth2Characters 28.f
#define LKTNotificationBadgeTagWidth1Character 28.f
#define LKTNotificationBadgeTagHeight3Characters 30.f
#define LKTNotificationBadgeTagHeight2Characters 28.f
#define LKTNotificationBadgeTagHeight1Character 28.f

/* Values for LKTNotificationBadgeAlignment */
typedef NS_ENUM(NSInteger, LKTNotificationBadgeAlignment) {
  LKTNotificationBadgeAlignmentLeft      = 0,    // Visually left aligned
  LKTNotificationBadgeAlignmentCenter    = 1,    // Visually centered
  LKTNotificationBadgeAlignmentRight     = 2,    // Visually right aligned
};

@interface LKTNotificationBadge : UIView

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) NSMutableArray *mutableArrayBadges;

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
// THE METHOD CREATE A BADGE LABEL
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
                           alignment:(LKTNotificationBadgeAlignment)alignment;

@end
