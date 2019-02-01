//
//  SheetView.m
//  EmptyDemo
//
//  Created by njw on 2018/10/17.
//  Copyright © 2018 njw. All rights reserved.
//

#import "SheetView.h"
#import "PopupItem.h"
#import "PopupCategory.h"
#import "PopupDefine.h"
#import <Masonry/Masonry.h>


@interface SheetView()

@property (nonatomic, strong) UIView        *titleView;
@property (nonatomic, strong) UILabel       *titleLabel;

@property (nonatomic, strong) UIView        *detailView;
@property (nonatomic, strong) UILabel       *detailLabel;

@property (nonatomic, strong) UIView        *customView;
@property (nonatomic, strong) UIView        *buttonView;
@property (nonatomic, strong) UIButton      *cancelButton;
@property (nonatomic, strong) UIView        *cancelView;
@property (nonatomic, strong) NSArray       *actionItems;

@property (strong, nonatomic) SheetViewConfig *config;

@end


@implementation SheetView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (instancetype)initWithTitle:(NSString *)title
                  actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION
{
    
    P_VA_LIST
    
    if ([items isKindOfClass:[NSArray class]])
    {
        itemsArr = items;
    }
    
    return [self initWithTitle:title detail:nil customView:nil showCancel:YES showClose:NO config:nil actionItemArray:itemsArr];
    
}

- (instancetype)initWithTitle:(NSString *)title
                       config:(SheetViewConfig *)config
                  actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION
{
    P_VA_LIST
    
    if ([items isKindOfClass:[NSArray class]])
    {
        itemsArr = items;
    }
    
    return [self initWithTitle:title detail:nil customView:nil showCancel:YES showClose:NO config:config actionItemArray:itemsArr];
}

- (instancetype)initWithDetail:(id)detail
                   actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION
{
    P_VA_LIST
    
    if ([items isKindOfClass:[NSArray class]])
    {
        itemsArr = items;
    }
    
    return [self initWithTitle:nil detail:detail customView:nil showCancel:YES showClose:NO config:nil actionItemArray:itemsArr];
}

- (instancetype)initWithDetail:(id)detail
                        config:(SheetViewConfig *)config
                   actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION
{
    P_VA_LIST
    
    if ([items isKindOfClass:[NSArray class]])
    {
        itemsArr = items;
    }
    
    return [self initWithTitle:nil detail:detail customView:nil showCancel:YES showClose:NO config:config actionItemArray:itemsArr];
}

- (instancetype)initWithTitle:(NSString *)title
                       detail:(id)detail
                  actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION
{
    P_VA_LIST
    
    if ([items isKindOfClass:[NSArray class]])
    {
        itemsArr = items;
    }
    
    return [self initWithTitle:title detail:detail customView:nil showCancel:YES showClose:NO config:nil actionItemArray:itemsArr];
}

- (instancetype)initWithTitle:(NSString *)title
                       detail:(id)detail
                       config:(SheetViewConfig *)config
                  actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION
{
    P_VA_LIST
    
    if ([items isKindOfClass:[NSArray class]])
    {
        itemsArr = items;
    }
    
    return [self initWithTitle:title detail:detail customView:nil showCancel:YES showClose:NO config:config actionItemArray:itemsArr];
}


- (instancetype)initWithTitle:(id)title
                   customView:(UIView*)customView
                   showCancel:(BOOL)showCancel
                    showClose:(BOOL)showClose
                  actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION
{
    P_VA_LIST
    
    if ([items isKindOfClass:[NSArray class]])
    {
        itemsArr = items;
    }
    
    return [self initWithTitle:title detail:nil customView:customView showCancel:showCancel showClose:showClose config:nil actionItemArray:itemsArr];
}

- (instancetype)initWithTitle:(id)title
                   customView:(UIView*)customView
                   showCancel:(BOOL)showCancel
                    showClose:(BOOL)showClose
                       config:(SheetViewConfig *)config
                  actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION
{
    P_VA_LIST
    
    if ([items isKindOfClass:[NSArray class]])
    {
        itemsArr = items;
    }
    
    return [self initWithTitle:title detail:nil customView:customView showCancel:showCancel showClose:showClose config:config actionItemArray:itemsArr];
}

- (instancetype)initWithDetail:(id)detail
                    customView:(UIView*)customView
                    showCancel:(BOOL)showCancel
                     showClose:(BOOL)showClose
                   actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION
{
    P_VA_LIST
    
    if ([items isKindOfClass:[NSArray class]])
    {
        itemsArr = items;
    }
    
    return [self initWithTitle:nil detail:detail customView:customView showCancel:showCancel showClose:showClose config:nil actionItemArray:itemsArr];
}

- (instancetype)initWithDetail:(id)detail
                    customView:(UIView*)customView
                    showCancel:(BOOL)showCancel
                     showClose:(BOOL)showClose
                        config:(SheetViewConfig *)config
                   actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION
{
    P_VA_LIST
    
    if ([items isKindOfClass:[NSArray class]])
    {
        itemsArr = items;
    }
    
    return [self initWithTitle:nil detail:detail customView:customView showCancel:showCancel showClose:showClose config:config actionItemArray:itemsArr];
}


- (instancetype)initWithTitle:(NSString *)title
                       detail:(id)detail
                   customView:(UIView*)customView
                   showCancel:(BOOL)showCancel
                    showClose:(BOOL)showClose
                       config:(SheetViewConfig *)config
                  actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION
{
    
    P_VA_LIST
    
    if ([items isKindOfClass:[NSArray class]])
    {
        itemsArr = items;
    }
    
    return [self initWithTitle:title detail:detail customView:customView showCancel:showCancel showClose:showClose config:config actionItemArray:itemsArr];
}



- (instancetype)initWithTitle:(NSString *)title
                       detail:(id)detail
                   customView:(UIView*)customView
                   showCancel:(BOOL)showCancel
                    showClose:(BOOL)showClose
                       config:(SheetViewConfig *)config
              actionItemArray:(NSArray *)items
{
    self = [super init];
    
    if ( self )
    {
        //        NSAssert(items.count>0, @"Could not find any items.");
        
        config = config ?: [SheetViewConfig globalConfig];
        self.config = config;
        
        NSMutableArray *actionItems = [NSMutableArray array];
        
        for (int i = 0; i < items.count; i++)
        {
            id item = items[i];
            
            if ([item isKindOfClass:[NSString class]])
            {
                [actionItems addObject:[PopupItem itemWithTitle:item type:ePopupItemTypeNormal]];
            }
            else
            {
                [actionItems addObject:item];
            }
        }
        
        
        self.type = ePopupTypeSheet;
        self.actionItems = actionItems;
        self.backgroundColor = config.splitColor;
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        }];
        [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisVertical];
        
        
        MASViewAttribute *lastAttribute = self.mas_top;
        UIView * lastView = nil;
        CGFloat buttomOffset = config.innerMargin;
        
        CGFloat topMargin = config.topMargin;
        
        // title
        if ( title.length > 0 )
        {
            self.titleView = [UIView new];
            [self addSubview:self.titleView];
            
            [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.equalTo(self);
            }];
            self.titleView.backgroundColor = config.backgroundColor;
            
            self.titleLabel = [UILabel new];
            [self.titleView addSubview:self.titleLabel];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.equalTo(self.titleView).insets(UIEdgeInsetsMake(topMargin, config.innerMargin, config.innerMargin, config.innerMargin));
                make.bottom.equalTo(self.titleView).offset(-config.innerMargin).priority(MASLayoutPriorityDefaultMedium);
            }];
            self.titleLabel.textColor = config.titleColor;
            self.titleLabel.font = config.titleFont;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.titleLabel.numberOfLines = 0;
            self.titleLabel.text = title;
            
            lastAttribute = self.titleView.mas_bottom;
            topMargin = config.innerMargin;
            lastView = self.titleLabel;
        }
        
        
        // detail
        if ( [detail length] > 0 )
        {
            topMargin = title.length ? 0 : topMargin;
            
            self.detailView = [UIView new];
            [self addSubview:self.detailView];
            
            [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                make.top.equalTo(lastAttribute);
            }];
            self.detailView.backgroundColor = config.backgroundColor;
            
            
            self.detailLabel = [UILabel new];
            [self.detailView addSubview:self.detailLabel];
            [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.detailView);
                make.left.greaterThanOrEqualTo(self.detailView).insets(UIEdgeInsetsMake(0, config.innerMargin, 0, config.innerMargin));
                make.top.equalTo(self.detailView).offset(topMargin);
                make.bottom.equalTo(self.detailView).offset(-config.innerMargin).priority(MASLayoutPriorityDefaultMedium);
            }];
            self.detailLabel.textColor = config.detailColor;
            self.detailLabel.textAlignment = config.detailTextAlignment;
            self.detailLabel.font = config.detailFont;
            self.detailLabel.numberOfLines = 0;
            self.detailLabel.backgroundColor = self.detailView.backgroundColor;
            
            if ([detail isKindOfClass:[NSAttributedString class]])
            {
                self.detailLabel.attributedText = detail;
            }
            else
            {
                self.detailLabel.text = detail;
            }
            
            lastAttribute = self.detailView.mas_bottom;
            topMargin = config.innerMargin;
            lastView = self.detailLabel;
        }
        
        
        // customView
        
        if (customView)
        {
            self.customView = [UIView new];
            self.customView.backgroundColor = config.backgroundColor;
            [self.customView addSubview:customView];
            [self addSubview:self.customView];
            
            [self.customView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastAttribute);
                make.left.right.equalTo(self);
            }];
            
            [customView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.customView);
                make.bottom.equalTo(self.customView).priority(MASLayoutPriorityDefaultMedium);
                make.centerX.equalTo(self.customView);
            }];
            
            lastAttribute = self.customView.mas_bottom;
            topMargin = config.innerMargin;
            lastView = customView;
            buttomOffset = 0;
        }
        
        if (items.count)
        {
            // button item
            self.buttonView = [UIView new];
            [self addSubview:self.buttonView];
            [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                make.top.equalTo(lastAttribute);
            }];
            
            __block UIButton *firstButton = nil;
            __block UIButton *lastButton = nil;
            
            for ( NSInteger i = 0 ; i < actionItems.count; ++i )
            {
                PopupItem *item = actionItems[i];
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
                btn.exclusiveTouch = YES;
                btn.tag = i;
                
                [self.buttonView addSubview:btn];
                
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.right.equalTo(self.buttonView).insets(UIEdgeInsetsMake(0, -P_SPLIT_WIDTH, 0, -P_SPLIT_WIDTH));
                    make.height.mas_equalTo(config.buttonHeight);
                    
                    if ( !firstButton )
                    {
                        firstButton = btn;
                        make.top.equalTo(self.buttonView.mas_top).offset(-P_SPLIT_WIDTH);
                    }
                    else
                    {
                        make.top.equalTo(lastButton.mas_bottom).offset(-P_SPLIT_WIDTH);
                        make.height.equalTo(firstButton);
                    }
                    
                    lastButton = btn;
                }];
                [btn setBackgroundImage:[UIImage p_imageWithColor:config.backgroundColor] forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage p_imageWithColor:config.backgroundColor] forState:UIControlStateDisabled];
                [btn setBackgroundImage:[UIImage p_imageWithColor:config.itemPressedColor] forState:UIControlStateHighlighted];
                
                [btn setTitle:item.title forState:UIControlStateNormal];
                
                switch (item.type)
                {
                    case ePopupItemTypeNormal:
                    {
                        [btn setTitleColor:config.itemNormalColor forState:UIControlStateNormal];
                        btn.titleLabel.font = config.itemNormalFont;
                    }
                        break;
                    case ePopupItemTypeHighlight:
                    {
                        [btn setTitleColor:config.itemHighlightColor forState:UIControlStateNormal];
                        btn.titleLabel.font = config.itemHighlightFont;
                    }
                        break;
                    case ePopupItemTypeDisabled:
                    {
                        [btn setTitleColor:config.itemDisabledColor forState:UIControlStateNormal];
                        btn.titleLabel.font = config.itemDisabledFont;
                    }
                        break;
                        
                    default:
                        break;
                }
                
                btn.layer.borderWidth = P_SPLIT_WIDTH;
                btn.layer.borderColor = config.splitColor.CGColor;
                
            }
            [lastButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.buttonView.mas_bottom).offset(P_SPLIT_WIDTH).priority(MASLayoutPriorityDefaultMedium);
            }];
            
            lastAttribute = self.buttonView.mas_bottom;
            lastView = lastButton;
            buttomOffset = 0;
        }
        
        
        // cancel button
        if (showCancel)
        {
            self.cancelView = [UIView new];
            self.cancelView.backgroundColor = config.backgroundColor;
            
            [self addSubview:self.cancelView];
            
            UIButton *cancelbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [cancelbtn addTarget:self action:@selector(actionCancel) forControlEvents:UIControlEventTouchUpInside];
            cancelbtn.exclusiveTouch = YES;
            self.cancelButton = cancelbtn;
            [self.cancelView addSubview:self.cancelButton];
            
            
            [self.cancelView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                make.top.equalTo(lastAttribute).offset(8);
            }];
            
            [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.equalTo(self.cancelView);
                make.height.mas_equalTo(config.buttonHeight);
                make.bottom.equalTo(self.cancelView).priority(MASLayoutPriorityDefaultMedium);
            }];
            
            self.cancelButton.titleLabel.font = config.itemCancelFont;
            
            [self.cancelButton setBackgroundImage:[UIImage p_imageWithColor:config.backgroundColor] forState:UIControlStateNormal];
            [self.cancelButton setBackgroundImage:[UIImage p_imageWithColor:config.itemPressedColor] forState:UIControlStateHighlighted];
            [self.cancelButton setTitle:config.defaultTextCancel forState:UIControlStateNormal];
            [self.cancelButton setTitleColor:config.itemCancelColor forState:UIControlStateNormal];
            
            lastView = self.cancelButton;
            lastAttribute = self.cancelView.mas_bottom;
            buttomOffset = 0;
        }
        
        // close button
        if (showClose)
        {
            UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [closeButton setImage:config.closeImage forState:UIControlStateNormal];
            [self addSubview:closeButton];
            [closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
            closeButton.exclusiveTouch = YES;
            [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(config.closeMargin);
                make.right.equalTo(self).offset(-config.closeMargin);
            }];
        }
        
        if (lastView)
        {
            if (@available(iOS 11.0, *))
            {
                [lastView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self.mas_safeAreaLayoutGuideBottom).offset(-buttomOffset);
                }];
            }
        }
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lastAttribute);
        }];
        
        
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(self.config.cornerRadius, self.config.cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)actionButton:(UIButton*)btn
{
    PopupItem *item = self.actionItems[btn.tag];
    
    if ( self.handler )
    {
        self.handler(btn.tag);
    }
    
    if (item.type == ePopupItemTypeDisabled )
    {
        return;
    }
    
    [self hide];
}

-(void)closeAction:(UIButton*)btn
{
    [self hide];
}

- (void)actionCancel
{
    [self hide];
}

@end




@implementation SheetViewConfig

static SheetViewConfig *config = nil;
static dispatch_once_t onceToken;

+ (SheetViewConfig *)globalConfig
{
    
    dispatch_once(&onceToken, ^{
        
        config = [[SheetViewConfig alloc] initGlobalConfig];
        
    });
    
    return config;
}

+(void)resetGlobalConfig
{
    config = nil;
    onceToken = 0;
}


- (instancetype)initGlobalConfig
{
    self = [super init];
    
    if ( self )
    {
        
        self.buttonHeight           = 50.0f;
        self.cornerRadius           = 0.0f;
        
        self.topMargin              = 25.0f;
        self.innerMargin            = 25.0f;
        self.closeMargin            = 15.0f;
        
        self.titleFont              = [UIFont boldSystemFontOfSize:16];
        self.detailFont             = [UIFont systemFontOfSize:14];
        
        self.itemNormalFont         = [UIFont systemFontOfSize:16];
        self.itemHighlightFont      = [UIFont boldSystemFontOfSize:16];
        self.itemDisabledFont       = [UIFont systemFontOfSize:16];
        
        self.itemNormalColor        = PHexColor(0x333333FF);
        self.itemHighlightColor     = PHexColor(0xE76153FF);
        self.itemDisabledColor      = PHexColor(0xCCCCCCFF);
        self.itemPressedColor       = PHexColor(0xEFEDE7FF);
        
        self.backgroundColor        = PHexColor(0xFFFFFFFF);
        self.titleColor             = PHexColor(0x666666FF);
        self.detailColor            = PHexColor(0x666666FF);
        self.splitColor             = PHexColor(0xEFEFEFFF);
        
        self.detailTextAlignment    = NSTextAlignmentLeft;
        
        self.itemCancelColor        = PHexColor(0x333333FF);
        self.itemCancelFont         = [UIFont boldSystemFontOfSize:16];
        self.defaultTextCancel      = PopupLibraryLocalizedString(@"PopupViewCancel", @"PopupView");
        self.closeImage             = PopupBundleImage(@"sheet_delete@2x.png", @"PopupView");
        
    }
    
    return self;
}


- (instancetype)init
{
    self = [super init];
    
    if ( self )
    {
        
        SheetViewConfig *config = [SheetViewConfig globalConfig];
        
        self.buttonHeight           = config.buttonHeight;
        self.cornerRadius           = config.cornerRadius;
        
        self.topMargin              = config.topMargin;
        self.innerMargin            = config.innerMargin;
        self.closeMargin            = config.closeMargin;
        
        self.titleFont              = config.titleFont;
        self.detailFont             = config.detailFont;
        
        self.itemNormalFont         = config.itemNormalFont;
        self.itemHighlightFont      = config.itemHighlightFont;
        self.itemDisabledFont       = config.itemDisabledFont;
        
        self.itemNormalColor        = config.itemNormalColor;
        self.itemHighlightColor     = config.itemHighlightColor;
        self.itemDisabledColor      = config.itemDisabledColor;
        self.itemPressedColor       = config.itemPressedColor;
        
        self.backgroundColor        = config.backgroundColor;
        self.titleColor             = config.titleColor;
        self.detailColor            = config.detailColor;
        self.splitColor             = config.splitColor;
        
        self.detailTextAlignment    = config.detailTextAlignment;
        
        self.itemCancelColor        = config.itemCancelColor;
        self.itemCancelFont         = config.itemCancelFont;
        self.defaultTextCancel      = config.defaultTextCancel;
        
        self.closeImage             = config.closeImage;
        
    }
    
    return self;
}

@end
