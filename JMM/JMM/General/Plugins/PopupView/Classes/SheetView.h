//
//  SheetView.h
//  EmptyDemo
//
//  Created by njw on 2018/10/17.
//  Copyright © 2018 njw. All rights reserved.
//

#import "PopupView.h"

@class SheetViewConfig;

@interface SheetView : PopupView


/**
 sheetView
 
 @ram title title.
 @ram detail detail. suport string and attributedString
 @ram customView customView.
 @ram showCancel show cancel button.
 @ram showClose show close button.
 @ram config config.
 @ram items items. suport String and PopupItem or NSArray<String&&PopupItem>
 @return sheetView
 */
- (instancetype)initWithTitle:(NSString *)title
                       detail:(id)detail
                   customView:(UIView*)customView
                   showCancel:(BOOL)showCancel
                    showClose:(BOOL)showClose
                       config:(SheetViewConfig *)config
                  actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION;

- (instancetype)initWithTitle:(NSString *)title
                  actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION;

- (instancetype)initWithTitle:(NSString *)title
                       config:(SheetViewConfig *)config
                  actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION;


- (instancetype)initWithDetail:(id)detail
                   actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION;

- (instancetype)initWithDetail:(id)detail
                        config:(SheetViewConfig *)config
                   actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION;


- (instancetype)initWithTitle:(NSString *)title
                       detail:(id)detail
                  actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION;

- (instancetype)initWithTitle:(NSString *)title
                       detail:(id)detail
                       config:(SheetViewConfig *)config
                  actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION;


- (instancetype)initWithTitle:(id)title
                   customView:(UIView*)customView
                   showCancel:(BOOL)showCancel
                    showClose:(BOOL)showClose
                  actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION;

- (instancetype)initWithTitle:(id)title
                   customView:(UIView*)customView
                   showCancel:(BOOL)showCancel
                    showClose:(BOOL)showClose
                       config:(SheetViewConfig *)config
                  actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION;



- (instancetype)initWithDetail:(id)detail
                    customView:(UIView*)customView
                    showCancel:(BOOL)showCancel
                     showClose:(BOOL)showClose
                   actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION;

- (instancetype)initWithDetail:(id)detail
                    customView:(UIView*)customView
                    showCancel:(BOOL)showCancel
                     showClose:(BOOL)showClose
                        config:(SheetViewConfig *)config
                   actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION;


@end



/**
 *  Global Configuration of SheetView.
 */
@interface SheetViewConfig : NSObject

+ (SheetViewConfig*) globalConfig;

+(void)resetGlobalConfig;

@property (nonatomic, assign) CGFloat buttonHeight;         // Default is 50.
@property (nonatomic, assign) CGFloat cornerRadius;         // Default is 0.

@property (nonatomic, assign) CGFloat topMargin;          // Default is 25.
@property (nonatomic, assign) CGFloat innerMargin;          // Default is 25.
@property (nonatomic, assign) CGFloat closeMargin;          // Default is 15.

@property (nonatomic, strong) UIFont *titleFont;        // Default is Bold System 16.
@property (nonatomic, strong) UIFont *detailFont;       // Default is System 14.

@property (nonatomic, strong) UIFont *itemNormalFont;       // Default is System 16.
@property (nonatomic, strong) UIFont *itemHighlightFont;       // Default is Bold System 16.
@property (nonatomic, strong) UIFont *itemDisabledFont;       // Default is System 16.
@property (nonatomic, strong) UIFont *itemCancelFont;     // Default is Bold System 16.

@property (nonatomic, strong) UIColor *itemNormalColor;     // Default is #333333.
@property (nonatomic, strong) UIColor *itemHighlightColor;  // Default is #E76153.
@property (nonatomic, strong) UIColor *itemDisabledColor;  // Default is #CCCCCC.

@property (nonatomic, strong) UIColor *itemPressedColor;    // Default is #EFEDE7.

@property (nonatomic, strong) UIColor *itemCancelColor;     // Default is #333333.
@property (nonatomic, strong) UIColor *backgroundColor;     // Default is #FFFFFF.
@property (nonatomic, strong) UIColor *titleColor;          // Default is #333333.
@property (nonatomic, strong) UIColor *detailColor;         // Default is #333333.
@property (nonatomic, strong) UIColor *splitColor;          // Default is #EFEFEF.

@property (assign, nonatomic) NSTextAlignment detailTextAlignment;   // Default is left

@property (nonatomic, strong) NSString *defaultTextCancel;  // Default is "取消" && "cancel"

@property (strong, nonatomic) UIImage *closeImage;


@end
