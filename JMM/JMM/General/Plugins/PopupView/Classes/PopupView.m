//
//  PopupView.m
//  EmptyDemo
//
//  Created by njw on 2018/10/17.
//  Copyright © 2018 njw. All rights reserved.
//

#import "PopupView.h"
#import "PopupWindow.h"
#import "PopupDefine.h"
#import "PopupCategory.h"
#import <Masonry/Masonry.h>


static NSString * const PopupViewHideAllNotification = @"PopupViewHideAllNotification";



@implementation PopupView
{
    BOOL _isShow;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */




#pragma mark -
#pragma mark  Public Method

-(void)setType:(PopupType)type
{
    _type = type;
    
    switch (type)
    {
        case ePopupTypeAlert:
        {
            self.showAnimation = [self alertShowAnimation];
            self.hideAnimation = [self alertHideAnimation];
            break;
        }
        case ePopupTypeSheet:
        {
            self.showAnimation = [self sheetShowAnimation];
            self.hideAnimation = [self sheetHideAnimation];
            break;
        }
        case ePopupTypeCustom:
        {
            self.showAnimation = [self customShowAnimation];
            self.hideAnimation = [self customHideAnimation];
            break;
        }
            
        default:
            break;
    }
}

- (void)setAnimationDuration:(NSTimeInterval)animationDuration
{
    _animationDuration = animationDuration;
    
    self.attachedView.p_dimAnimationDuration = animationDuration;
}

- (void)show
{
    [self showWithBlock:nil];
}


- (void)showWithBlock:(PopupCompletionBlock)block
{
    
    if (_isShow)
    {
        return;
    }
    
    _isShow = YES;
    
    if ( block )
    {
        self.showCompletionBlock = block;
    }
    
    if ( !self.attachedView )
    {
        self.attachedView = [PopupWindow sharedWindow].attachView;
    }
    
    [self.attachedView p_showDimBackground];
    
    PopupBlock showAnimation = self.showAnimation;
    
    NSAssert(showAnimation, @"show animation must be there");
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(popupViewWillShow:)])
    {
        [self.delegate popupViewWillShow:self];
    }
    
    showAnimation(self);
}


- (void)hide
{
    [self hideWithBlock:nil];
}

- (void)hideWithBlock:(PopupCompletionBlock)block
{
    if (!_isShow)
    {
        return;
    }
    
    _isShow = NO;
    
    if ( block )
    {
        self.hideCompletionBlock = block;
    }
    
    if ( !self.attachedView )
    {
        self.attachedView = [PopupWindow sharedWindow].attachView;
    }
    
    [self.attachedView p_hideDimBackground];
    
    PopupBlock hideAnimation = self.hideAnimation;
    
    NSAssert(hideAnimation, @"hide animation must be there");
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(popupViewWillDismiss:)])
    {
        [self.delegate popupViewWillDismiss:self];
    }
    
    hideAnimation(self);
}


+ (void)hideAll
{
    [[NSNotificationCenter defaultCenter] postNotificationName:PopupViewHideAllNotification object:[self class]];
}


#pragma mark -
#pragma mark  DataInitialize

- (void)setup
{
    
    // default
    self.type = ePopupTypeAlert;
    self.animationDuration = 0.3f;
    self.attachedView = [PopupWindow sharedWindow].attachView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyHideAll:) name:PopupViewHideAllNotification object:nil];
}

#pragma mark -
#pragma mark  Lifecycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if ( self )
    {
        [self setup];
    }
    
    return self;
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    if (_dismissOnTap && !view)
    {
        [self hideWithBlock:self.tapDismissCompletionBlock];
    }
    return view;
}




#pragma mark -
#pragma mark  Interface Components



#pragma mark -
#pragma mark  Target Action

- (void)notifyHideAll:(NSNotification*)n
{
    if ( [self isKindOfClass:n.object] )
    {
        [self hide];
    }
}


#pragma mark -
#pragma mark  Private Methods


- (PopupBlock)alertShowAnimation
{
    PWeakify(self);
    PopupBlock block = ^(PopupView *popupView){
        PStrongify(self);
        
        if ( !self.superview )
        {
            [self.attachedView.p_dimBackgroundView addSubview:self];
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self.attachedView).centerOffset(CGPointMake(0, 0));
            }];
            [self.superview layoutIfNeeded];
        }
        
        self.layer.transform = CATransform3DMakeScale(1.2f, 1.2f, 1.0f);
        self.alpha = 0.0f;
        
        [UIView animateWithDuration:self.animationDuration
                              delay:0.0 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             
                             self.layer.transform = CATransform3DIdentity;
                             self.alpha = 1.0f;
                             
                         } completion:^(BOOL finished) {
                             if (self.delegate && [self.delegate respondsToSelector:@selector(popupViewDidShow:)])
                             {
                                 [self.delegate popupViewDidShow:self];
                             }
                             if ( self.showCompletionBlock )
                             {
                                 self.showCompletionBlock(self, finished);
                             }
                         }];
    };
    
    return block;
}

- (PopupBlock)alertHideAnimation
{
    PWeakify(self);
    PopupBlock block = ^(PopupView *popupView){
        PStrongify(self);
        
        [UIView animateWithDuration:self.animationDuration
                              delay:0
                            options: UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             
                             self.alpha = 0.0f;
                             
                         }
                         completion:^(BOOL finished) {
                             
                             if ( finished )
                             {
                                 [self removeFromSuperview];
                             }
                             if (self.delegate && [self.delegate respondsToSelector:@selector(popupViewDidDismiss:)])
                             {
                                 [self.delegate popupViewDidDismiss:self];
                             }
                             if ( self.hideCompletionBlock )
                             {
                                 self.hideCompletionBlock(self, finished);
                             }
                             
                         }];
    };
    
    return block;
}

- (PopupBlock)sheetShowAnimation
{
    PWeakify(self);
    PopupBlock block = ^(PopupView *popupView){
        PStrongify(self);
        
        if ( !self.superview )
        {
            [self.attachedView.p_dimBackgroundView addSubview:self];
            
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.attachedView);
                make.bottom.equalTo(self.attachedView.mas_bottom).offset(self.attachedView.frame.size.height);
            }];
            [self.superview layoutIfNeeded];
        }
        
        [UIView animateWithDuration:self.animationDuration
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             
                             [self mas_updateConstraints:^(MASConstraintMaker *make) {
                                 make.bottom.equalTo(self.attachedView.mas_bottom).offset(0);
                             }];
                             
                             [self.superview layoutIfNeeded];
                             
                         }
                         completion:^(BOOL finished) {
                             if (self.delegate && [self.delegate respondsToSelector:@selector(popupViewDidShow:)])
                             {
                                 [self.delegate popupViewDidShow:self];
                             }
                             if ( self.showCompletionBlock )
                             {
                                 self.showCompletionBlock(self, finished);
                             }
                             
                         }];
    };
    
    return block;
}

- (PopupBlock)sheetHideAnimation
{
    PWeakify(self);
    PopupBlock block = ^(PopupView *popupView){
        PStrongify(self);
        
        [UIView animateWithDuration:self.animationDuration
                              delay:0
                            options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             
                             [self mas_updateConstraints:^(MASConstraintMaker *make) {
                                 make.bottom.equalTo(self.attachedView.mas_bottom).offset(self.attachedView.frame.size.height);
                             }];
                             
                             [self.superview layoutIfNeeded];
                             
                         }
                         completion:^(BOOL finished) {
                             
                             if ( finished )
                             {
                                 [self removeFromSuperview];
                             }
                             
                             if (self.delegate && [self.delegate respondsToSelector:@selector(popupViewDidDismiss:)])
                             {
                                 [self.delegate popupViewDidDismiss:self];
                             }
                             
                             if ( self.hideCompletionBlock )
                             {
                                 self.hideCompletionBlock(self, finished);
                             }
                             
                         }];
    };
    
    return block;
}

- (PopupBlock)customShowAnimation
{
    PWeakify(self);
    PopupBlock block = ^(PopupView *popupView){
        PStrongify(self);
        
        if ( !self.superview )
        {
            [self.attachedView.p_dimBackgroundView addSubview:self];
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self.attachedView).centerOffset(CGPointMake(0, -self.attachedView.bounds.size.height));
            }];
            [self.superview layoutIfNeeded];
        }
        
        [UIView animateWithDuration:self.animationDuration
                              delay:0
             usingSpringWithDamping:0.8
              initialSpringVelocity:1.5
                            options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             
                             [self mas_updateConstraints:^(MASConstraintMaker *make) {
                                 make.center.equalTo(self.attachedView).centerOffset(CGPointMake(0, 0));
                             }];
                             
                             [self.superview layoutIfNeeded];
                             
                         } completion:^(BOOL finished) {
                             if (self.delegate && [self.delegate respondsToSelector:@selector(popupViewDidShow:)])
                             {
                                 [self.delegate popupViewDidShow:self];
                             }
                             if ( self.showCompletionBlock )
                             {
                                 self.showCompletionBlock(self, finished);
                             }
                             
                         }];
    };
    
    return block;
}

- (PopupBlock)customHideAnimation
{
    PWeakify(self);
    PopupBlock block = ^(PopupView *popupView){
        PStrongify(self);
        
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             
                             [self mas_updateConstraints:^(MASConstraintMaker *make) {
                                 make.center.equalTo(self.attachedView).centerOffset(CGPointMake(0, self.attachedView.bounds.size.height));
                             }];
                             
                             [self.superview layoutIfNeeded];
                             
                         } completion:^(BOOL finished) {
                             
                             if ( finished )
                             {
                                 [self removeFromSuperview];
                             }
                             
                             if (self.delegate && [self.delegate respondsToSelector:@selector(popupViewDidDismiss:)])
                             {
                                 [self.delegate popupViewDidDismiss:self];
                             }
                             if ( self.hideCompletionBlock )
                             {
                                 self.hideCompletionBlock(self, finished);
                                 
                                 
                             }
                         }];
    };
    
    return block;
}



#pragma mark -
#pragma mark  Dealloc


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PopupViewHideAllNotification object:nil];
}



@end
