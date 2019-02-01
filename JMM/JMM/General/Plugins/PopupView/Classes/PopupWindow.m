//
//  PopupWindow.m
//  EmptyDemo
//
//  Created by njw on 2018/10/17.
//  Copyright © 2018 njw. All rights reserved.
//

#import "PopupWindow.h"
#import "PopupCategory.h"
#import "PopupView.h"

@interface PopupWindow() <UIGestureRecognizerDelegate>

@end


@implementation PopupWindow

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if ( self )
    {
        self.windowLevel = UIWindowLevelStatusBar + 1;
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)];
        gesture.cancelsTouchesInView = NO;
        gesture.delegate = self;
        [self addGestureRecognizer:gesture];
    }
    return self;
}

+ (PopupWindow *)sharedWindow
{
    static PopupWindow *window;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        window = [[PopupWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        window.rootViewController = [UIViewController new];
        window.rootViewController.view.backgroundColor = nil;
    });
    
    return window;
}


- (void)actionTap:(UITapGestureRecognizer*)gesture
{
    if ( self.touchWildToHide && !self.p_dimBackgroundAnimating )
    {
        for ( UIView *view in [self attachView].p_dimBackgroundView.subviews )
        {
            if ( [view isKindOfClass:[PopupView class]] )
            {
                PopupView *popupView = (PopupView*)view;
                [popupView hide];
            }
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return ( touch.view == self.attachView.p_dimBackgroundView );
}

- (UIView *)attachView
{
    return self.rootViewController.view;
}


@end
