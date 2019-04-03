//
//  NSDictionary+Helper.m
//  
//
//  Created by BIN on 2017/8/24.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "NSDictionary+Helper.h"

#import "NSString+Helper.h"
#import "NSArray+Helper.h"
#import "NSMutableArray+Helper.h"

@implementation NSDictionary (Helper)

NSDictionary<NSAttributedStringKey, id> * AttributeDict(NSNumber * type){
    
    NSDictionary *dic = @{
                          NSForegroundColorAttributeName   :   UIColor.blackColor,
                          NSBackgroundColorAttributeName   :   UIColor.whiteColor,
                          };
    
    switch (type.integerValue) {
        case 1://下划线
        {
            dic = @{
                    NSUnderlineStyleAttributeName   :   @(NSUnderlineStyleSingle),
                    NSUnderlineColorAttributeName  :   UIColor.redColor,
                    
                    };
            
        }
            break;
        case 2://贯穿县
        {
            dic = @{
                    NSStrikethroughStyleAttributeName   :   @(NSUnderlineStyleSingle),
                    NSStrikethroughColorAttributeName   :   UIColor.redColor,
                    };
        }
            break;
        case 3://设置字形倾斜度取值为 NSNumber （float）,正值右倾，负值左倾
        {
            dic = @{
                    NSObliquenessAttributeName   :   @(0.8),
                    
                    };
        }
            break;
        case 4://拉伸文本
        {
            //正值横向拉伸文本，负值横向压缩文本
            dic = @{
                    NSExpansionAttributeName   :   @(0.3),
                    
                    };
        }
            break;
        case 5://书写方向(RightToLeft)
        {
            dic = @{
                    NSWritingDirectionAttributeName   :   @[@(3)],
                    //                    NSWritingDirectionAttributeName    :   @[@(NSWritingDirectionRightToLeft | NSWritingDirectionOverride)],
                    
                    };
            
            //            0 -> LRE -> NSWritingDirectionLeftToRight | NSWritingDirectionEmbedding
            //            1 -> RLE -> NSWritingDirectionRightToLeft | NSWritingDirectionEmbedding
            //            2 -> LRO -> NSWritingDirectionLeftToRight | NSWritingDirectionOverride
            //            3 -> RLO -> NSWritingDirectionRightToLeft | NSWritingDirectionOverride
        }
            break;
        default:
            break;
    }
    return dic;
}

/**
 在TARGETS里的CopyBundleResources中必须存在
 */
NSMutableDictionary *DicFromPlist(NSString *plistName){
    if ([plistName containsString:@".plist"]) {
        NSArray * list = [plistName componentsSeparatedByString:@"."];
        NSString *plistPath = [NSBundle.mainBundle pathForResource:list.firstObject ofType:list.lastObject];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
        return dic;
    }
    
    NSString *plistPath = [NSBundle.mainBundle pathForResource:plistName ofType:@"plist"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    //    NSLog(@"plistPath_%@",plistPath);
    //    NSLog(@"dic_%@",dic);
    return dic;
}

/**
根据key对字典values排序,区分大小写(按照ASCII排序)
 */
- (NSArray *)sortedValuesByKey{
    
    //将所有的key放进数组
    NSArray *allKeyArray = self.allKeys;
    
    NSArray *sortKeyList = [allKeyArray sortedArrayUsingSelector:@selector(compare:)];
//    DDLog(@"sortKeyList:%@",sortKeyList);
    if ([[allKeyArray firstObject] isKindOfClass:[NSString class]]) {
        sortKeyList = [self.allKeys sortedByAscending];
    }
    
    //通过排列的key值获取value
    NSMutableArray *valueArray = [NSMutableArray array];
    for (NSString *key in sortKeyList) {
        [valueArray addSafeObjct:self[key]];
        
    }
//    DDLog(@"valueArray:%@",valueArray);
    return valueArray.copy;
}

- (NSMutableDictionary *)filterDictByContainQuery:(NSString *)query isNumValue:(BOOL)isNumValue{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [self.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj containsString:query]) {
            id value = self[query];
            value = isNumValue == NO ? value : [value numberValue];
            [dic setObject:value forKey:obj];
            
        }
    }];
    return dic;
}

/**
 *  @brief  将NSDictionary转换成url 参数字符串
 *  @return url 参数字符串
 */
- (NSString *)toURLQueryString{
    NSMutableString *string = [NSMutableString string];
    for (NSString *key in [self allKeys]) {
        if ([string length]) {
            [string appendString:@"&"];
        }
        CFStringRef escaped = CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)[[self objectForKey:key] description],
                                                                      NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                      kCFStringEncodingUTF8);
        [string appendFormat:@"%@=%@", key, escaped];
        CFRelease(escaped);
    }
    return string;
}

/**
 *  @brief  将NSDictionary转换成XML 字符串
 *  @return XML 字符串
 */
- (NSString *)XMLString {
    
    return [self XMLStringWithRootElement:nil declaration:nil];
}

- (NSString*)XMLStringDefaultDeclarationWithRootElement:(NSString*)rootElement{
    return [self XMLStringWithRootElement:rootElement declaration:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"];
    
}

- (NSString*)XMLStringWithRootElement:(NSString*)rootElement declaration:(NSString*)declaration{
    NSMutableString *xml = [[NSMutableString alloc] initWithString:@""];
    if (declaration) {
        [xml appendString:declaration];
    }
    if (rootElement) {
        [xml appendString:[NSString stringWithFormat:@"<%@>",rootElement]];
    }
    [self convertNode:self withString:xml andTag:nil];
    if (rootElement) {
        [xml appendString:[NSString stringWithFormat:@"</%@>",rootElement]];
    }
    NSString *finalXML=[xml stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    return finalXML;
}

- (void)convertNode:(id)node withString:(NSMutableString *)xml andTag:(NSString *)tag{
    if ([node isKindOfClass:[NSDictionary class]] && !tag) {
        NSArray *keys = [node allKeys];
        for (NSString *key in keys) {
            [self convertNode:[node objectForKey:key] withString:xml andTag:key];
        }
    } else if ([node isKindOfClass:[NSArray class]]) {
        for (id value in node) {
            [self convertNode:value withString:xml andTag:tag];
        }
    } else {
        [xml appendString:[NSString stringWithFormat:@"<%@>", tag]];
        if ([node isKindOfClass:[NSString class]]) {
            [xml appendString:node];
        } else if ([node isKindOfClass:[NSDictionary class]]) {
            [self convertNode:node withString:xml andTag:nil];
        }
        [xml appendString:[NSString stringWithFormat:@"</%@>", tag]];
    }
}

- (NSString *)plistString{
    NSString *result = [[NSString alloc] initWithData:[self plistData]  encoding:NSUTF8StringEncoding];
    return result;
}
- (NSData *)plistData{
    //    return [NSPropertyListSerialization dataFromPropertyList:self format:NSPropertyListXMLFormat_v1_0   errorDescription:nil];
    NSError *error = nil;
    return [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
}

@end
