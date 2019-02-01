//
//  PopupView.h
//  EmptyDemo
//
//  Created by njw on 2018/10/17.
//  Copyright © 2018 njw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupItem.h"


typedef NS_ENUM(NSUInteger, PopupType)
{
    ePopupTypeAlert,
    ePopupTypeSheet,
    ePopupTypeCustom,
};

@class PopupView;

typedef void(^PopupBlock)(PopupView *);
typedef void(^PopupCompletionBlock)(PopupView *, BOOL);
typedef void(^PopupItemHandler)(NSInteger index);

@protocol PopupViewDelegate<NSObject>
@optional

-(void)popupViewWillShow:(PopupView*)popView;
-(void)popupViewDidShow:(PopupView*)popView;
-(void)popupViewWillDismiss:(PopupView*)popView;
-(void)popupViewDidDismiss:(PopupView*)popView;

@end

@interface PopupView : UIView


@property (nonatomic,assign)  BOOL  dismissOnTap;        //Default is NO

@property (nonatomic, strong) UIView    *attachedView;       // default is MMPopupWindow. You can attach MMPopupView to any UIView.
@property (nonatomic, assign) PopupType   type;                // default is MMPopupTypeAlert.
@property (nonatomic, assign) NSTimeInterval    animationDuration;   // default is 0.3 sec.

@property (nonatomic, copy) PopupCompletionBlock   showCompletionBlock; // show completion block.
@property (nonatomic, copy) PopupCompletionBlock   hideCompletionBlock; // hide completion block
@property (nonatomic, copy) PopupCompletionBlock   tapDismissCompletionBlock; // tap dimiss completion block

@property (nonatomic, copy) PopupBlock   showAnimation;       // custom show animation block.
@property (nonatomic, copy) PopupBlock   hideAnimation;       // custom hide animation block.

@property (nonatomic, copy) PopupItemHandler   handler;       // custom hide animation block.

@property (nonatomic, weak) id <PopupViewDelegate> delegate;


/**
 *  show the popup view
 */
- (void) show;

/**
 *  show the popup view with completiom block
 *
 *  @ram block show completion block
 */
- (void) showWithBlock:(PopupCompletionBlock)block;


/**
 *  hide the popup view
 */
- (void) hide;


/**
 *  hide the popup view with completiom block
 *
 *  @ram block hide completion block
 */
- (void) hideWithBlock:(PopupCompletionBlock)block;


/**
 *  hide all popupview with current class, eg. [MMAlertview hideAll];
 */
+ (void) hideAll;



@end

