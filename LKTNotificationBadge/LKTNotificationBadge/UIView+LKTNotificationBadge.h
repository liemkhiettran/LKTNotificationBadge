//
//  UIView+LKTNotificationBadge.h
//  LKTNotificationBadge
//
//  Created by liem-khiet tran on 1/11/16.
//  Copyright © 2016 liem-khiet tran. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TagWidth 40.f
#define TagHeight 17.f
#define kLabelTextNewFeatureTag 824

/* Values for DBZAlignment */
typedef NS_ENUM(NSInteger, DBZAlignment) {
  DBZAlignmentLeft      = 0,    // Visually left aligned
  DBZAlignmentCenter    = 1,    // Visually centered
  DBZAlignmentRight     = 2,    // Visually right aligned
};

@interface UIView (LKTNotificationBadge)

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
               withAlignment:(DBZAlignment)alignment;
@end
