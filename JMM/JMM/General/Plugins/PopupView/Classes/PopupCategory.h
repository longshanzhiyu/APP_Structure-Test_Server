//
//  PopupCategory.h
//  EmptyDemo
//
//  Created by njw on 2018/10/17.
//  Copyright © 2018 njw. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


#define PopupLibraryLocalizedString(key, bundleName) NSLocalizedStringFromTableInBundle(key, nil, [[self class] _bundleNamed:bundleName], nil)
#define PopupBundleImage(imageName, bundleName) [[[self class] _bundleNamed:bundleName] _imageNamed:imageName];

@interface NSObject (PopupExtend)

+ (NSBundle*)_bundleNamed:(NSString*)name;

@end

@interface NSBundle (PopupExtend)

- (UIImage*)_imageNamed:(NSString*)name;

@end


@interface UIColor (PopupExtend)

+ (UIColor *) p_colorWithHex:(NSUInteger)hex;

@end



@interface UIImage (PopupExtend)

+ (UIImage *) p_imageWithColor:(UIColor *)color;
+ (UIImage *) p_imageWithColor:(UIColor *)color Size:(CGSize)size;
- (UIImage *) p_stretched;

@end



@interface UIView (PopupExtend)

@property (nonatomic, strong, readonly ) UIView            *p_dimBackgroundView;
@property (nonatomic, assign, readonly ) BOOL              p_dimBackgroundAnimating;
@property (nonatomic, assign           ) NSTimeInterval    p_dimAnimationDuration;

- (void) p_showDimBackground;
- (void) p_hideDimBackground;

@end





NS_ASSUME_NONNULL_END
