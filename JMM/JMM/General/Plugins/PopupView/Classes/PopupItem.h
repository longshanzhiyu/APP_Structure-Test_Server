//
//  PopupItem.h
//  EmptyDemo
//
//  Created by njw on 2018/10/17.
//  Copyright © 2018 njw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, PopupItemType)
{
    ePopupItemTypeNormal,
    ePopupItemTypeHighlight,
    ePopupItemTypeDisabled
};


@interface PopupItem : NSObject

@property (nonatomic, assign) PopupItemType type;
@property (nonatomic, strong) NSString *title;

+(instancetype)itemWithTitle:(NSString*)title;
+(instancetype)itemWithTitle:(NSString*)title type:(PopupItemType)type;

@end





NS_ASSUME_NONNULL_END
