//
//  BaseTextView.m
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import "BaseTextView.h"

@implementation BaseTextView

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:))/**<粘贴*/
        return _action & PasteboardActionTypePasteEnabled;
    if (action == @selector(select:))/**<选择*/
        return _action & PasteboardActionTypeSelectEnabled;
    if (action == @selector(selectAll:))/**<全选*/
        return _action & PasteboardActionTypeSelectAllEnabled;
    if(action == @selector(cut:))
        return _action & PasteboardActionTypeCutEnabled;
    if (action == @selector(copy:))
        return _action & PasteboardActionTypeCopyEnabled;
    return [super canPerformAction:action withSender:sender];
}

@end
