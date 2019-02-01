//
//  PopupWindow.h
//  EmptyDemo
//
//  Created by njw on 2018/10/17.
//  Copyright © 2018 njw. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopupWindow : UIWindow

// default is NO. When YES, popup views will be hidden when user touch the translucent background.
@property (nonatomic, assign) BOOL touchWildToHide;

@property (nonatomic, readonly) UIView* attachView;



+ (PopupWindow *)sharedWindow;



@end

NS_ASSUME_NONNULL_END
