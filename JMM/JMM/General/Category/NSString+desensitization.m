//
//  NSString+desensitization.m
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import "NSString+desensitization.h"

@implementation NSString (desensitization)
-(NSString *)firstNameDesensitize{
    if (self.length>0)
    {
        NSString *desenStr =[NSString stringWithFormat:@"*%@",[self substringWithRange:NSMakeRange(1, self.length-1)]];
        return desenStr;
    }
    return self;
}
- (NSString *)nameDesensitize
{
    if (self.length>0)
    {
        NSMutableString *tempStr = [[NSMutableString alloc] init];
        for (NSInteger index = 0; index < self.length-1; ++index)
        {
            [tempStr appendString:@"*"];
        }
        [tempStr appendString:[self substringFromIndex:self.length-1]];
        return tempStr;
    }
    return self;
}

- (NSString *)idNumDesensitize
{
    if (![self isIDCardWithString])
    {
        return @"";
    }
    
    return [self stringByReplacingCharactersInRange:NSMakeRange(3, self.length - 7) withString:@"********"];
}


- (NSString *)mobileNumDesensitize
{
    if (![self isPhoneNumberString]) {
        return @"";
    }
    
    return [self stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
}
@end
