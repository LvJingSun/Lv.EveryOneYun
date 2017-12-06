//
//  EaseMessageCell+DXLinkClick.m
//  Dajiayun
//
//  Created by mac on 16/6/16.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "EaseMessageCell+DXLinkClick.h"

@implementation EaseMessageCell (DXLinkClick)

-(void)addLinks:(NSString*)str toLabel:(UILabel*)label
{
    NSMutableAttributedString*strMutable=[[NSMutableAttributedString alloc]initWithString:str];
    [strMutable addAttribute:NSFontAttributeName value:label.font range:NSMakeRange(0, str.length)];
    [strMutable addAttribute:NSForegroundColorAttributeName value:label.textColor range:NSMakeRange(0, str.length)];
    NSDataDetector*detect=[[NSDataDetector alloc]    initWithTypes:NSTextCheckingTypeLink error:nil];
    
    NSArray*matches=[detect matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    
    for(NSTextCheckingResult*result in matches)
    {
        if (result.resultType==NSTextCheckingTypeLink) {
            [strMutable addAttribute:NSLinkAttributeName value:@"http://www.baidu.com" range:result.range ];
        }
    }
    if ([matches count]>0) {
        label.attributedText=strMutable;
    }
}

@end
