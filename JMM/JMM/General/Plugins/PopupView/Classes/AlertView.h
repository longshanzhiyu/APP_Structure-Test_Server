//
//  AlertView.h
//  EmptyDemo
//
//  Created by njw on 2018/10/17.
//  Copyright © 2018 njw. All rights reserved.
//

#import "PopupView.h"

typedef NS_ENUM(NSUInteger, ItemHighlightType)
{
    eItemHighlightTypeNone,
    eItemHighlightTypeFirst,
    eItemHighlightTypeLast,
};

@class AlertViewConfig;

@interface AlertView : PopupView

/**
 alertView
 
 @ram title title.
 @ram icon icon.
 @ram detail detatil. suport string and attributedString
 @ram customView customView
 @ram config config.
 @ram items items. suport String and PopupItem or NSArray<String&&PopupItem>
 @return alertView
 */
- (instancetype)initWithTitle:(NSString *)title
                         icon:(UIImage*)icon
                       detail:(id)detail
                   customView:(UIView*)customView
                    showClose:(BOOL)showClose
                       config:(AlertViewConfig*)config
                  actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION;


- (instancetype)initWithTitle:(NSString *)title
                       detail:(id)detail
                  actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION;

- (instancetype)initWithTitle:(NSString *)title
                       detail:(id)detail
                       config:(AlertViewConfig*)config
                  actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION;

- (instancetype)initWithIcon:(UIImage*)icon
                      detail:(id)detail
                 actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION;

- (instancetype)initWithIcon:(UIImage*)icon
                      detail:(id)detail
                      config:(AlertViewConfig*)config
                 actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION;

- (instancetype)initWithTitle:(NSString *)title
                       detail:(id)detail
                   customView:(UIView*)customView
                  actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION;

- (instancetype)initWithTitle:(NSString *)title
                       detail:(id)detail
                   customView:(UIView*)customView
                       config:(AlertViewConfig*)config
                  actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION;

@end





/**
 *  Global Configuration of AlertView.
 */
@interface AlertViewConfig : NSObject

+ (AlertViewConfig*) globalConfig;

+(void)resetGlobalConfig;

@property (nonatomic, assign) CGFloat width;                // Default is 275.
@property (nonatomic, assign) CGFloat buttonHeight;         // Default is 50.
@property (nonatomic, assign) CGFloat cornerRadius;         // Default is 10.

@property (nonatomic, assign) CGFloat topMargin;          // Default is 25.
@property (nonatomic, assign) CGFloat bottomMargin;          // Default is 25.
@property (nonatomic, assign) CGFloat horizontalMargin;          // Default is 25.
@property (nonatomic, assign) CGFloat innerMargin;          // Default is 25.
@property (nonatomic, assign) CGFloat closeMargin;          // Default is 15.


@property (nonatomic, strong) UIFont *titleFont;        // Default is Bold System 16.
@property (nonatomic, strong) UIFont *detailFont;       // Default is System 14.
@property (nonatomic, strong) UIFont *itemNormalFont;       // Default is System 16.
@property (nonatomic, strong) UIFont *itemHighlightFont;       // Default is Bold System 16.
@property (nonatomic, strong) UIFont *itemDisabledFont;       // Default is System 16.

@property (nonatomic, strong) UIColor *itemNormalColor;     // Default is #333333.
@property (nonatomic, strong) UIColor *itemHighlightColor;  // Default is #E76153.
@property (nonatomic, strong) UIColor *itemDisabledColor;  // Default is #CCCCCC.

@property (nonatomic, strong) UIColor *itemNormalPressedColor;    // Default is #EFEDE7.
@property (nonatomic, strong) UIColor *itemHighlightPressedColor;     // Default is #EFEDE7.
@property (nonatomic, strong) UIColor *itemDisabledPressedColor;     // Default is #EFEDE7.

@property (nonatomic, strong) UIColor *itemNormalBackgoundColor;     // Default is #FFFFFF.
@property (nonatomic, strong) UIColor *itemHighlightBackgoundColor;  // Default is #FFFFFF.
@property (nonatomic, strong) UIColor *itemDisabledBackgoundColor;  // Default is #FFFFFF.

@property (nonatomic, strong) UIColor *backgroundColor;     // Default is #FFFFFF.
@property (nonatomic, strong) UIColor *titleColor;          // Default is #666666.
@property (nonatomic, strong) UIColor *detailColor;         // Default is #666666.
@property (nonatomic, strong) UIColor *splitColor;          // Default is #EFEFEF.

@property (nonatomic, assign) CGFloat iconWidth;         // Default is 0.
@property (nonatomic, assign) CGFloat iconHeight;         // Default is 0.

@property (assign, nonatomic) NSTextAlignment detailTextAlignment;   // Default is left

@property (assign, nonatomic) ItemHighlightType itemHighlightType;  // // Default is last

@property (strong, nonatomic) UIImage *closeImage;

@end




