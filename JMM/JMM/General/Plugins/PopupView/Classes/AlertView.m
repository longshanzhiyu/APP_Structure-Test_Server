//
//  AlertView.m
//  EmptyDemo
//
//  Created by njw on 2018/10/17.
//  Copyright © 2018 njw. All rights reserved.
//

#import "AlertView.h"
#import "PopupItem.h"
#import "PopupCategory.h"
#import "PopupDefine.h"
#import <Masonry/Masonry.h>

@interface AlertView()

@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UIImageView   *iconImageView;
@property (nonatomic, strong) UILabel       *detailLabel;
@property (nonatomic, strong) UIView        *customView;
@property (nonatomic, strong) UIView        *buttonView;

@property (nonatomic, strong) NSArray       *actionItems;

@end


@implementation AlertView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */




#pragma mark -
#pragma mark  Public Method


- (instancetype)initWithTitle:(NSString *)title
                       detail:(id)detail
                  actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION
{
    
    P_VA_LIST
    
    if ([items isKindOfClass:[NSArray class]])
    {
        itemsArr = items;
    }
    
    return [self initWithTitle:title icon:nil detail:detail customView:nil showClose:NO config:nil actionItems:itemsArr, nil];
    
}

- (instancetype)initWithTitle:(NSString *)title
                       detail:(id)detail
                       config:(AlertViewConfig*)config
                  actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION
{
    
    P_VA_LIST
    
    if ([items isKindOfClass:[NSArray class]])
    {
        itemsArr = items;
    }
    
    return [self initWithTitle:title icon:nil detail:detail customView:nil showClose:NO config:config actionItems:itemsArr, nil];
    
}

- (instancetype)initWithIcon:(UIImage*)icon
                      detail:(id)detail
                 actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION
{
    
    P_VA_LIST
    
    if ([items isKindOfClass:[NSArray class]])
    {
        itemsArr = items;
    }
    
    return [self initWithTitle:nil icon:icon detail:detail customView:nil showClose:NO config:nil actionItems:itemsArr, nil];
    
}

- (instancetype)initWithIcon:(UIImage*)icon
                      detail:(id)detail
                      config:(AlertViewConfig*)config
                 actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION
{
    P_VA_LIST
    
    if ([items isKindOfClass:[NSArray class]])
    {
        itemsArr = items;
    }
    
    return [self initWithTitle:nil icon:icon detail:detail customView:nil showClose:NO config:config actionItems:itemsArr, nil];
    
}

- (instancetype)initWithTitle:(NSString *)title
                       detail:(id)detail
                   customView:(UIView*)customView
                  actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION
{
    P_VA_LIST
    
    if ([items isKindOfClass:[NSArray class]])
    {
        itemsArr = items;
    }
    
    return [self initWithTitle:title icon:nil detail:detail customView:customView showClose:NO config:nil actionItems:itemsArr, nil];
    
}

- (instancetype)initWithTitle:(NSString *)title
                       detail:(id)detail
                   customView:(UIView*)customView
                       config:(AlertViewConfig*)config
                  actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION
{
    P_VA_LIST
    
    if ([items isKindOfClass:[NSArray class]])
    {
        itemsArr = items;
    }
    
    return [self initWithTitle:title icon:nil detail:detail customView:customView showClose:NO config:config actionItems:itemsArr, nil];
    
}

- (instancetype)initWithTitle:(NSString *)title
                         icon:(UIImage*)icon
                       detail:(id)detail
                   customView:(UIView*)customView
                    showClose:(BOOL)showClose
                       config:(AlertViewConfig*)config
                  actionItems:(id)items,... NS_REQUIRES_NIL_TERMINATION
{
    P_VA_LIST
    
    if ([items isKindOfClass:[NSArray class]])
    {
        itemsArr = items;
    }
    
    return [self initWithTitle:title icon:icon detail:detail customView:customView showClose:showClose config:config actionItemArray:itemsArr];
}


- (instancetype)initWithTitle:(NSString *)title
                         icon:(UIImage*)icon
                       detail:(id)detail
                   customView:(UIView*)customView
                    showClose:(BOOL)showClose
                       config:(AlertViewConfig*)config
              actionItemArray:(NSArray *)items
{
    self = [super init];
    
    if ( self )
    {
//        NSAssert(items.count>0, @"Could not find any items.");
 
        config = config ?: [AlertViewConfig globalConfig];

        NSMutableArray *actionItems = [NSMutableArray array];
        
        for (int i = 0; i < items.count; i++)
        {
            id item = items[i];
            
            if ([item isKindOfClass:[NSString class]])
            {
                PopupItemType type = ePopupItemTypeNormal;
                
                switch (config.itemHighlightType)
                {
                    case eItemHighlightTypeFirst:
                        type = i == 0 ? ePopupItemTypeHighlight : ePopupItemTypeNormal;
                        break;
                    case eItemHighlightTypeLast:
                        type = i == items.count-1 ? ePopupItemTypeHighlight : ePopupItemTypeNormal;
                        break;
                    default:
                        break;
                }
                
                [actionItems addObject:[PopupItem itemWithTitle:item type:type]];
            }
            else
            {
                [actionItems addObject:item];
            }
        }
        
        self.type = ePopupTypeAlert;
        self.actionItems = actionItems;
        self.layer.cornerRadius = config.cornerRadius;
        self.clipsToBounds = YES;
        self.backgroundColor = config.backgroundColor;
        self.layer.borderWidth = P_SPLIT_WIDTH;
        self.layer.borderColor = config.splitColor.CGColor;
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(config.width);
        }];
        
        [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisVertical];
        
        
        MASViewAttribute *lastAttribute = self.mas_top;
        CGFloat topMargin = config.topMargin;
        
        
        // title
        if ( title.length > 0 )
        {
            self.titleLabel = [UILabel new];
            [self addSubview:self.titleLabel];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastAttribute).offset(topMargin);
                make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, config.horizontalMargin, 0, config.horizontalMargin));
            }];
            self.titleLabel.textColor = config.titleColor;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.titleLabel.font = config.titleFont;
            self.titleLabel.numberOfLines = 0;
            self.titleLabel.backgroundColor = self.backgroundColor;
            self.titleLabel.text = title;
            
            lastAttribute = self.titleLabel.mas_bottom;
            topMargin = config.innerMargin;
        }
        
        // icon
        if ( icon )
        {
            self.iconImageView = [[UIImageView alloc] initWithImage:icon];
            [self addSubview:self.iconImageView];
            
            [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastAttribute).offset(topMargin);
                make.centerX.equalTo(self);
                config.iconWidth ? make.width.mas_equalTo(config.iconWidth) : nil;
                config.iconHeight ? make.height.mas_equalTo(config.iconHeight) : nil;
            }];
            
            lastAttribute = self.iconImageView.mas_bottom;
            topMargin = config.innerMargin;
        }
        
        // detail
        if ( [detail length] > 0 )
        {
            self.detailLabel = [UILabel new];
            [self addSubview:self.detailLabel];
            [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastAttribute).offset(topMargin);
                make.centerX.equalTo(self);
                make.left.greaterThanOrEqualTo(self).insets(UIEdgeInsetsMake(0, config.horizontalMargin, 0, config.horizontalMargin));
            }];
            self.detailLabel.textColor = config.detailColor;
            self.detailLabel.textAlignment = config.detailTextAlignment;
            self.detailLabel.font = config.detailFont;
            self.detailLabel.numberOfLines = 0;
            self.detailLabel.backgroundColor = self.backgroundColor;
            
            if ([detail isKindOfClass:[NSAttributedString class]])
            {
                self.detailLabel.attributedText = detail;
            }
            else
            {
                self.detailLabel.text = detail;
            }
            
            lastAttribute = self.detailLabel.mas_bottom;
            topMargin = config.innerMargin;
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
        
        // custom
        if ( customView )
        {
            self.customView = customView;
            [self addSubview:self.customView];
            
            [self.customView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastAttribute).offset(topMargin);
                make.centerX.equalTo(self);
            }];
            
            lastAttribute = self.customView.mas_bottom;
            topMargin = config.innerMargin;
        }
        
        
        // button item
        self.buttonView = [UIView new];
        [self addSubview:self.buttonView];
        
        [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastAttribute).offset(config.bottomMargin);
            make.left.right.equalTo(self);
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
                
                if ( actionItems.count <= 2 )
                {
                    make.top.bottom.equalTo(self.buttonView);
                    make.height.mas_equalTo(config.buttonHeight);
                    
                    if ( !firstButton )
                    {
                        firstButton = btn;
                        make.left.equalTo(self.buttonView.mas_left).offset(-P_SPLIT_WIDTH);
                    }
                    else
                    {
                        make.left.equalTo(lastButton.mas_right).offset(-P_SPLIT_WIDTH);
                        make.width.equalTo(firstButton);
                    }
                }
                else
                {
                    make.left.right.equalTo(self.buttonView);
                    make.height.mas_equalTo(config.buttonHeight);
                    
                    if ( !firstButton )
                    {
                        firstButton = btn;
                        make.top.equalTo(self.buttonView.mas_top).offset(-P_SPLIT_WIDTH);
                    }
                    else
                    {
                        make.top.equalTo(lastButton.mas_bottom).offset(-P_SPLIT_WIDTH);
                        make.width.equalTo(firstButton);
                    }
                }
                
                lastButton = btn;
            }];
            
            btn.layer.borderWidth = P_SPLIT_WIDTH;
            btn.layer.borderColor = config.splitColor.CGColor;
            [btn setTitle:item.title forState:UIControlStateNormal];
            
            switch (item.type)
            {
                case ePopupItemTypeNormal:
                {
                    [btn setTitleColor:config.itemNormalColor forState:UIControlStateNormal];
                    btn.titleLabel.font = config.itemNormalFont;
                    [btn setBackgroundImage:[UIImage p_imageWithColor:config.itemNormalBackgoundColor] forState:UIControlStateNormal];
                    [btn setBackgroundImage:[UIImage p_imageWithColor:config.itemNormalPressedColor] forState:UIControlStateHighlighted];
                }
                    break;
                case ePopupItemTypeHighlight:
                {
                    [btn setTitleColor:config.itemHighlightColor forState:UIControlStateNormal];
                    btn.titleLabel.font = config.itemHighlightFont;
                    [btn setBackgroundImage:[UIImage p_imageWithColor:config.itemHighlightBackgoundColor] forState:UIControlStateNormal];
                    [btn setBackgroundImage:[UIImage p_imageWithColor:config.itemHighlightPressedColor] forState:UIControlStateHighlighted];
                }
                    break;
                case ePopupItemTypeDisabled:
                {
                    [btn setTitleColor:config.itemDisabledColor forState:UIControlStateNormal];
                    btn.titleLabel.font = config.itemDisabledFont;
                    [btn setBackgroundImage:[UIImage p_imageWithColor:config.itemDisabledBackgoundColor] forState:UIControlStateNormal];
                    [btn setBackgroundImage:[UIImage p_imageWithColor:config.itemDisabledPressedColor] forState:UIControlStateHighlighted];
                }
                    break;
                    
                default:
                    break;
            }
        }
        
        [lastButton mas_updateConstraints:^(MASConstraintMaker *make) {
            
            if ( actionItems.count <= 2 )
            {
                make.right.equalTo(self.buttonView.mas_right).offset(P_SPLIT_WIDTH);
            }
            else
            {
                make.bottom.equalTo(self.buttonView.mas_bottom).offset(P_SPLIT_WIDTH);
            }
            
        }];
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.buttonView.mas_bottom);
        }];
    }
    
    return self;
}

#pragma mark -
#pragma mark  DataInitialize


#pragma mark -
#pragma mark  Lifecycle



#pragma mark -
#pragma mark  Interface Components



#pragma mark -
#pragma mark  Target Action


-(void)closeAction:(UIButton*)btn
{
    [self hide];
}


#pragma mark -
#pragma mark  Private Methods


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


#pragma mark -
#pragma mark  Dealloc



@end





@implementation AlertViewConfig

static AlertViewConfig *config;
static dispatch_once_t onceToken;

+ (AlertViewConfig *)globalConfig
{
    dispatch_once(&onceToken, ^{
        
        config = [[AlertViewConfig alloc] initGlobalConfig];
        
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
        
        self.width                          = 275.0f;
        self.buttonHeight                   = 50.0f;
        self.cornerRadius                   = 10.0f;
        
        self.bottomMargin                   = 25.0f;
        self.topMargin                      = 25.0f;
        self.horizontalMargin               = 25.0f;
        self.innerMargin                    = 25.0f;
        self.closeMargin                    = 15.0f;

        self.titleFont                      = [UIFont boldSystemFontOfSize:16.0f];
        self.detailFont                     = [UIFont systemFontOfSize:14.0f];
        self.itemNormalFont                 = [UIFont systemFontOfSize:16.0f];
        self.itemHighlightFont              = [UIFont boldSystemFontOfSize:16.0f];
        self.itemDisabledFont               = [UIFont systemFontOfSize:16.0f];
        
        self.itemNormalColor                = PHexColor(0x333333FF);
        self.itemHighlightColor             = PHexColor(0xE76153FF);
        self.itemDisabledColor              = PHexColor(0xCCCCCCFF);
        
        
        self.itemNormalPressedColor         = PHexColor(0xEFEDE7FF);
        self.itemHighlightPressedColor      = PHexColor(0xEFEDE7FF);
        self.itemDisabledPressedColor       = PHexColor(0xEFEDE7FF);
        
        self.itemNormalBackgoundColor       = PHexColor(0xFFFFFFFF);
        self.itemHighlightBackgoundColor    = PHexColor(0xFFFFFFFF);
        self.itemDisabledBackgoundColor     = PHexColor(0xFFFFFFFF);
    
        self.backgroundColor                = PHexColor(0xFFFFFFFF);
        self.titleColor                     = PHexColor(0x666666FF);
        self.detailColor                    = PHexColor(0x666666FF);
        self.splitColor                     = PHexColor(0xEFEFEFFF);
    
        self.iconWidth                      = 0.0f;
        self.iconHeight                     = 0.0f;
    
        self.detailTextAlignment            = NSTextAlignmentLeft;
    
        self.itemHighlightType              = eItemHighlightTypeLast;
        
        self.closeImage             = PopupBundleImage(@"sheet_delete@2x.png", @"PopupView");

        
    }
    
    return self;

}


- (instancetype)init
{
    self = [super init];
    
    if ( self )
    {
        
        AlertViewConfig*config =  [AlertViewConfig globalConfig];

        
        self.width                              = config.width;
        self.buttonHeight                       = config.buttonHeight;
        self.cornerRadius                       = config.cornerRadius;
        
        self.bottomMargin                       = config.bottomMargin;
        self.topMargin                          = config.topMargin;
        self.horizontalMargin                   = config.horizontalMargin;
        self.innerMargin                        = config.innerMargin;
        self.closeMargin                        = config.closeMargin;
        
        self.titleFont                          = config.titleFont;
        self.detailFont                         = config.detailFont;
        self.itemNormalFont                     = config.itemNormalFont;
        self.itemHighlightFont                  = config.itemHighlightFont;
        self.itemDisabledFont                   = config.itemDisabledFont;
        
        self.itemNormalColor                    = config.itemNormalColor;
        self.itemHighlightColor                 = config.itemHighlightColor;
        self.itemDisabledColor                  = config.itemDisabledColor;
        
        self.itemNormalBackgoundColor           = config.itemNormalBackgoundColor;
        self.itemHighlightBackgoundColor        = config.itemHighlightBackgoundColor;
        self.itemDisabledBackgoundColor         = config.itemDisabledBackgoundColor;
        
        self.itemNormalPressedColor             = config.itemNormalPressedColor;
        self.itemHighlightPressedColor          = config.itemHighlightPressedColor;
        self.itemDisabledPressedColor           = config.itemDisabledPressedColor;
        
        self.backgroundColor                    = config.backgroundColor;
        self.titleColor                         = config.titleColor;
        self.detailColor                        = config.detailColor;
        self.splitColor                         = config.splitColor;
        
        self.iconWidth                          = config.iconWidth;
        self.iconHeight                         = config.iconHeight;
        
        self.detailTextAlignment                = config.detailTextAlignment;
        
        self.itemHighlightType                  = config.itemHighlightType;
        
        self.closeImage             = config.closeImage;
        
    }
    
    return self;
}

@end
