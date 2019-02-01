//
//  NSString+security.m
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import "NSString+security.h"

@implementation NSString (security)
- (NSString *)stringWithBase64 {
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)decodeBase64StringToString
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self
                                                      options:0];
    NSString *base64Decoded = [[NSString alloc]
                               initWithData:data
                               encoding:NSUTF8StringEncoding];
    return base64Decoded;
}

- (CGSize)sizeWithAttributes:(NSDictionary *)attrs constrainedToSize:(CGSize)size
{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}

- (NSString *)trim
{
    NSMutableString *mutableString = [[NSMutableString alloc]initWithString:self];
    return [mutableString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


+ (BOOL)isNilOrEmpty:(NSString *)str
{
    if (str == nil || [str isEqual:[NSNull null]])
    {
        return YES;
    }
    else
    {
        if (str.length > 0)
        {
            return NO;
        }
        else {
            return YES;
        }
    }
}

- (NSString *)permilString
{
    if (!self||[self floatValue] == 0.00)
    {
        return @"0.00";
    }
    else if ([self floatValue]<1.00)
    {
        return self;
    }
    else
    {
        NSNumberFormatter *form =[[NSNumberFormatter alloc] init];
        [form setPositiveFormat:@",###.00;"];
        NSString *string = [form stringFromNumber:[NSNumber numberWithDouble:[self doubleValue]]];
        return string;
    }
    
    return @"";
}
@end
