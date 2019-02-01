//
//  BaseTextView.h
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, PasteboardActionType) {
    PasteboardActionTypeCopyEnabled = 1 << 0,/**<允许复制*/
    PasteboardActionTypeCutEnabled = 1 << 1,/**<允许剪切*/
    PasteboardActionTypePasteEnabled = 1 << 2,/**<允许粘贴*/
    PasteboardActionTypeSelectEnabled = 1 << 3,/**<允许选择*/
    PasteboardActionTypeSelectAllEnabled = 1 << 4,/**<允许全选*/
    PasteboardActionTypeNOPaste = PasteboardActionTypeCopyEnabled|PasteboardActionTypeCutEnabled|PasteboardActionTypeSelectEnabled|PasteboardActionTypeSelectAllEnabled,/**<禁止粘贴*/
};

@interface BaseTextView : UITextView
@property(nonatomic,assign) PasteboardActionType action;/**<能做的操作*/
@end

NS_ASSUME_NONNULL_END
