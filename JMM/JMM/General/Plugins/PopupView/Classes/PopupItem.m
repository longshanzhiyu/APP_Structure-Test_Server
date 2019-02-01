//
//  PopupItem.m
//  EmptyDemo
//
//  Created by njw on 2018/10/17.
//  Copyright © 2018 njw. All rights reserved.
//

#import "PopupItem.h"

@implementation PopupItem

+(instancetype)itemWithTitle:(NSString*)title
{
    return [self itemWithTitle:title type:ePopupItemTypeNormal];
}

+(instancetype)itemWithTitle:(NSString*)title type:(PopupItemType)type
{
    PopupItem *item = [PopupItem new];
    
    item.type = type;
    item.title = title;
    
    return item;
}

@end
