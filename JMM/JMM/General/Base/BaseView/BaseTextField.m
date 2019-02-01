//
//  BaseTextField.m
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import "BaseTextField.h"

const NSInteger kCopyEnabled = 0x00000001;
const NSInteger kCutEnabled = 0x00000002;
const NSInteger kPasteEnabled = 0x00000004;
const NSInteger kSelectEnabled = 0x00000008;
const NSInteger kSelectAllEnabled = 0x00000010;

@interface BaseTextField ()
@property (nonatomic, copy) NSString *lastText;
@end

@implementation BaseTextField

- (instancetype)init
{
    if (self = [super init])
    {
        self.keyboardType = UIKeyboardTypeDecimalPad;
        [self addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.keyboardType = UIKeyboardTypeDecimalPad;
        [self addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:))/**<禁止粘贴*/
        return _action & kPasteEnabled;
    if (action == @selector(select:))/**<禁止选择*/
        return _action & kSelectEnabled;
    if (action == @selector(selectAll:))/**<禁止全选*/
        return _action & kSelectAllEnabled;
    if(action == @selector(cut:))
        return _action & kCutEnabled;
    if (action == @selector(copy:))
        return _action & kCopyEnabled;
    return [super canPerformAction:action withSender:sender];
}

- (void)textFieldEditingChanged:(UITextField *)textField
{
    if (textField.text.length == 0) {
        _lastText = @"";
        return;
    }
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",self.pattern];
    BOOL isMatch = [pred evaluateWithObject:textField.text];
    if (isMatch) {
        _lastText = textField.text;
    } else {
        textField.text = _lastText;
    }
}

@end
