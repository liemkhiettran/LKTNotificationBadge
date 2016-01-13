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

@interface LKTNotificationBadge : NSObject

@property (strong, nonatomic) NSMutableArray *mutableArrayBadges;

+ (id)sharedInstance;

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
                      withAlignment:(LKTNotificationBadgeAlignment)alignment;

//********************************************************************************
// REMOVE THE BADGE LABEL VIA THE TAG ONCE THE USER INTERACTED WITH THE UI ELEMENT
//********************************************************************************
- (void)removeBadgeForTag:(NSNumber *)tag;

@end
