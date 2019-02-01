//
//  PopupCategory.m
//  EmptyDemo
//
//  Created by njw on 2018/10/17.
//  Copyright © 2018 njw. All rights reserved.
//

#import "PopupCategory.h"
#import <objc/runtime.h>
#import "PopupWindow.h"
#import "PopupDefine.h"
#import <Masonry/Masonry.h>


@implementation NSObject (PopupExtend)

+ (NSBundle*)_bundleNamed:(NSString*)name
{
    static NSBundle *bundle = nil;
    
    if (bundle == nil)
    {
        bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:name ofType:@"bundle"]];
    }
    return bundle;
}

@end


@implementation NSBundle (PopupExtend)

- (UIImage*)imageNamed:(NSString*)name
{
    static UIImage *image = nil;
    if (image == nil)
    {
        image = [[UIImage imageWithContentsOfFile:[self pathForResource:name ofType:nil]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return image;
}

@end


@implementation UIColor (PopupExtend)

+ (UIColor *) p_colorWithHex:(NSUInteger)hex
{
    
    float r = (hex & 0xff000000) >> 24;
    float g = (hex & 0x00ff0000) >> 16;
    float b = (hex & 0x0000ff00) >> 8;
    float a = (hex & 0x000000ff);
    
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/255.0];
}

@end

@implementation UIImage (PopupExtend)

+ (UIImage *) p_imageWithColor:(UIColor *)color
{
    return [UIImage p_imageWithColor:color Size:CGSizeMake(4.0f, 4.0f)];
}

+ (UIImage *) p_imageWithColor:(UIColor *)color Size:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [image p_stretched];
}

- (UIImage *) p_stretched
{
    CGSize size = self.size;
    
    UIEdgeInsets insets = UIEdgeInsetsMake(truncf(size.height-1)/2, truncf(size.width-1)/2, truncf(size.height-1)/2, truncf(size.width-1)/2);
    
    return [self resizableImageWithCapInsets:insets];
}

@end






@interface UIView (PopupInnerExtend)

@property (nonatomic, assign) NSInteger p_dimReferenceCount;

@end


@implementation UIView (PopupInnerExtend)

-(void)setp_dimReferenceCount:(NSInteger)p_dimReferenceCount
{
    objc_setAssociatedObject(self, @selector(p_dimReferenceCount), @(p_dimReferenceCount), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)p_dimReferenceCount
{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

@end






@implementation UIView (PopupView)

// p_dimBackgroundView
- (UIView *)p_dimBackgroundView
{
    UIView *dimView = objc_getAssociatedObject(self, _cmd);
    
    if ( !dimView )
    {
        dimView = [UIView new];
        [self addSubview:dimView];
        [dimView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        dimView.alpha = 0.0f;
        dimView.backgroundColor = PHexColor(0x0000007F);
        dimView.layer.zPosition = FLT_MAX;
        
        self.p_dimAnimationDuration = 0.3f;
        
        objc_setAssociatedObject(self, @selector(p_dimBackgroundView), dimView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return dimView;
}


//p_dimBackgroundAnimating
-(void)setP_dimBackgroundAnimating:(BOOL)p_dimBackgroundAnimating
{
    objc_setAssociatedObject(self, @selector(p_dimBackgroundAnimating), @(p_dimBackgroundAnimating), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)p_dimBackgroundAnimating
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}


//p_dimAnimationDuration
- (NSTimeInterval)p_dimAnimationDuration
{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}
-(void)setp_dimAnimationDuration:(NSTimeInterval)p_dimAnimationDuration
{
    objc_setAssociatedObject(self, @selector(p_dimAnimationDuration), @(p_dimAnimationDuration), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



- (void)p_showDimBackground
{
    ++self.p_dimReferenceCount;
    
    if ( self.p_dimReferenceCount > 1 )
    {
        return;
    }
    
    self.p_dimBackgroundView.hidden = NO;
    self.p_dimBackgroundAnimating = YES;
    
    if ( self == [PopupWindow sharedWindow].attachView )
    {
        [PopupWindow sharedWindow].hidden = NO;
        [[PopupWindow sharedWindow] makeKeyAndVisible];
    }
    else if ( [self isKindOfClass:[UIWindow class]] )
    {
        self.hidden = NO;
        [(UIWindow*)self makeKeyAndVisible];
    }
    else
    {
        [self bringSubviewToFront:self.p_dimBackgroundView];
    }
    
    [UIView animateWithDuration:self.p_dimAnimationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         self.p_dimBackgroundView.alpha = 1.0f;
                         
                     } completion:^(BOOL finished) {
                         
                         if ( finished )
                         {
                             self.p_dimBackgroundAnimating = NO;
                         }
                         
                     }];
}

- (void)p_hideDimBackground
{
    --self.p_dimReferenceCount;
    
    if ( self.p_dimReferenceCount > 0 )
    {
        return;
    }
    
    self.p_dimBackgroundAnimating = YES;
    [UIView animateWithDuration:self.p_dimAnimationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         self.p_dimBackgroundView.alpha = 0.0f;
                         
                     } completion:^(BOOL finished) {
                         
                         if ( finished )
                         {
                             self.p_dimBackgroundAnimating = NO;
                             
                             if ( self == [PopupWindow sharedWindow].attachView )
                             {
                                 [PopupWindow sharedWindow].hidden = YES;
                                 [[[UIApplication sharedApplication].delegate window] makeKeyWindow];
                             }
                             else if ( self == [PopupWindow sharedWindow] )
                             {
                                 self.hidden = YES;
                                 [[[UIApplication sharedApplication].delegate window] makeKeyWindow];
                             }
                         }
                     }];
}


@end
