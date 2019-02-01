//
//  BaseTextField.h
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN const NSInteger kCopyEnabled;
UIKIT_EXTERN const NSInteger kCutEnabled;
UIKIT_EXTERN const NSInteger kPasteEnabled;
UIKIT_EXTERN const NSInteger kSelectEnabled;
UIKIT_EXTERN const NSInteger kSelectAllEnabled;

typedef BOOL(^CharacterChangeBlock)(NSRange range, NSString *replacementString);

@interface BaseTextField : UITextField <UITextFieldDelegate>
@property(nonatomic,copy) CharacterChangeBlock characterChangeBlock;
@property(nonatomic,copy) NSString *pattern;/**<正则表达式*/
@property(nonatomic,assign) NSInteger action;/**<能做的操作*/

@end

NS_ASSUME_NONNULL_END
