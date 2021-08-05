
//
//  NSString+Helper.m
//  
//
//  Created by BIN on 2017/7/31.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "NSString+Helper.h"

#import "NSArray+Helper.h"
#import "UIApplication+Helper.h"
#import "UIViewController+Helper.h"

#import "NSAttributedString+Helper.h"
#import "NSDate+Helper.h"

#import "NSNumber+Helper.h"
#import "UIAlertController+Helper.h"

#import <NNGloble/NNGloble.h>

NSString * NSStringFromIndexPath(NSIndexPath *indexPath) {
    return [NSString stringWithFormat:@"{%@,%@}", @(indexPath.section), @(indexPath.row)];
}


@implementation NSString (Helper)

- (BOOL)isEmpty{
//    return (self.length == 0);
    NSString *tmp = [self stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    bool result = [@[@"", @"nil", @"null"] containsObject: tmp.lowercaseString];
    return result;
}

-(NSData *)jsonData{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (id)objValue{
    NSError *error;
    id obj = [NSJSONSerialization JSONObjectWithData:self.jsonData options:kNilOptions error:&error];
    if (error) {
        return nil;
    }
    return obj;
}

-(NSDictionary *)dictValue{
    if (!self.objValue || ![self.objValue isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return self.objValue;
}

-(NSArray *)arrayValue{
    if (!self.objValue || ![self.objValue isKindOfClass:[NSArray class]]) {
        return nil;
    }
    return self.objValue;
}

- (BOOL)boolValue{
    NSString *tmp = [[self stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet] lowercaseString];
    BOOL isContain = [@[@"true", @"yes", @"1"] containsObject:tmp];
    return isContain;
}

-(NSString *)localized{
    return NSLocalizedString(self, self);
}

-(NSDecimalNumber *)decNumer{
    return [NSDecimalNumber decimalNumberWithString:self];
}

- (NSString *)trimmed{
    return [self stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
}

- (NSString *(^)(NSString *))trimmedBy{
    return ^(NSString *value) {
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:value];
        NSString *result = [self stringByTrimmingCharactersInSet:set];
        return result;
    };
}

- (NSString * _Nonnull (^)(NSCharacterSet * _Nonnull))trimmedBySet{
    return ^(NSCharacterSet *value) {
        return [self stringByTrimmingCharactersInSet:value];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSUInteger))subStringBy{
    return ^(NSUInteger loc, NSUInteger len) {
        if (loc + len > self.length) {
            return self;
        }
        NSString *result = [self substringWithRange:NSMakeRange(loc, len)];
        return result;
    };
}

- (NSString * _Nonnull (^)(NSUInteger))subStringFrom{
    return ^(NSUInteger value) {
        return [self substringFromIndex:value];;
    };
}

- (NSString * _Nonnull (^)(NSUInteger))subStringTo{
    return ^(NSUInteger value) {
        return [self substringFromIndex:value];;
    };
}


- (NSString *(^)(NSString * _Nonnull))appending{
    return ^(NSString *value){
        return [self stringByAppendingString:value];
    };
}

- (NSString * _Nonnull (^)(NSString * _Nonnull, ...))appendingFormat{
    return ^(NSString *format, ...){
        va_list list;
        va_start(list, format);
        NSString *string = [[NSString alloc] initWithFormat:format arguments:list];
        va_end(list);
        NSString *result = [self stringByAppendingString:string];
        return result;
    };
}

- (NSString * _Nonnull (^)(NSString * _Nonnull, NSString * _Nonnull, NSStringCompareOptions))replacingOccurrences{
    return ^(NSString *target, NSString *replacement, NSStringCompareOptions options){
        return [self stringByReplacingOccurrencesOfString:target withString:replacement options:options range:NSMakeRange(0, self.length)];
    };
}

- (NSString * _Nonnull (^)(NSRange, NSString * _Nonnull))replacingCharacters{
    return ^(NSRange range, NSString *replacement){
        return [self stringByReplacingCharactersInRange:range withString:replacement];
    };
}

- (NSComparisonResult (^)(NSString * _Nonnull, NSStringCompareOptions))compareBy{
    return ^(NSString *value, NSStringCompareOptions options){
        return [self compare:value options:options];
    };
}

- (BOOL (^)(NSString * _Nonnull))equalTo{
    return ^(NSString *value){
        return [self isEqualToString:value];
    };
}

- (BOOL (^)(NSString * _Nonnull))hasPrefix{
    return ^(NSString *value){
        return [self hasPrefix:value];
    };
}

- (BOOL (^)(NSString * _Nonnull))hasSuffix{
    return ^(NSString *value){
        return [self hasSuffix:value];
    };
}

- (BOOL (^)(NSString * _Nonnull))contains{
    return ^(NSString *value){
        return [self containsString:value];
    };
}

- (NSRange (^)(NSString * _Nonnull, NSStringCompareOptions))rangeBy{
    return ^(NSString *value, NSStringCompareOptions options){
        return [self rangeOfString:value options:options];
    };
}

- (NSData * _Nonnull (^)(NSStringEncoding))encoding{
    return ^(NSStringEncoding value){
        return [self dataUsingEncoding:value];
    };
}

- (NSArray<NSString *> *(^)(NSString *))separatedBy{
    return ^(NSString *value) {
        return [self componentsSeparatedByString: value];
    };
}

- (NSArray<NSString *> * _Nonnull (^)(NSCharacterSet * _Nonnull))separatedBySet{
    return ^(NSCharacterSet *value) {
        return [self componentsSeparatedByCharactersInSet:value];
    };
}

//- (NSString * _Nonnull (^)(NSString * _Nonnull))filterBy{
//    return ^(NSString *value) {
//        //@"!*'();:@&=+$,/?%#[]"
//        NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:value] invertedSet];
//        NSString *result = [self stringByAddingPercentEncodingWithAllowedCharacters:set];
//        NSString *result = [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        return result;
//    };
//}

- (NSString *)urlDecoded{
    return [self stringByRemovingPercentEncoding];;
}

- (NSString *)urlEncoded{
    return [self stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLUserAllowedCharacterSet];;;
}

- (BOOL)isValidUrl{
    return ([[NSURL alloc]initWithString:self] != nil);
}

- (BOOL)isValidHttpUrl{
    NSURL *url = [[NSURL alloc]initWithString:self];
    return [url.scheme isEqualToString:@"http"];
}

- (BOOL)isValidFileUrl{
    NSURL *url = [[NSURL alloc]initWithString:self];
    return url.isFileURL;
}

- (BOOL)isValidPhone{
    if (self.length == 0) {
        return false;
    }
    NSString *pattern = @"^1[0-9]{10}$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pre evaluateWithObject:self];;
}

- (BOOL)isValidEmail{
    if (self.length == 0) {
        return false;
    }
    NSString *pattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pre evaluateWithObject:self];;
}

- (NSString *)dayBegin{
    if (self.length != 19 || ![self containsString:@":"]) {
        return self;
    }
    NSString *replacement = @" 00:00:00";
    NSString *result = [self stringByReplacingCharactersInRange:NSMakeRange(self.length - replacement.length, replacement.length) withString:replacement];
    return result;
}

- (NSString *)dayEnd{
    if (self.length != 19 || ![self containsString:@":"]) {
        return self;
    }
    NSString *replacement = @" 23:59:59";
    NSString *result = [self stringByReplacingCharactersInRange:NSMakeRange(self.length - replacement.length, replacement.length) withString:replacement];
    return result;
}

- (NSString *)filterHTML {
    NSString *html = self;
    
    NSScanner *scanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    while(scanner.isAtEnd == NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    return html;
}

#pragma mark -高阶函数
- (NSString *)mapBySeparator:(NSString *)separator transform:(NSString * (NS_NOESCAPE ^)(NSString *obj))transform{
    if (!transform) {
        NSParameterAssert(transform != nil);
        return self;
    }
    NSArray<NSString *> *list = [self componentsSeparatedByString:separator];
    
    __block NSMutableArray *marr = [NSMutableArray array];
    [list enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *value = transform(obj);
        if (value) {
            [marr addObject:value];
        }
    }];
    
    NSString *result = [marr componentsJoinedByString:separator];
    return result;
}

#pragma mark -funtions
- (CGSize)sizeWithFont:(UIFont *)font width:(CGFloat)width{
    CGSize size = [self boundingRectWithSize: CGSizeMake(width, CGFLOAT_MAX)
                                     options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes: @{NSFontAttributeName: font}
                                     context:nil
                   ].size;
    CGSize result = CGSizeMake(ceil(size.width), ceil(size.height));
    return result;
}

+ (NSString *)repeating:(NSString *)repeatedValue count:(NSInteger)count{
    NSString *string = @"";
    for (NSInteger i = 0; i < count; i++) {
        string = [string stringByAppendingString:repeatedValue];
    }
    return string;
}

- (NSString *)repeating:(NSInteger)count{
    NSString *string = @"";
    for (NSInteger i = 0; i < count; i++) {
        string = [string stringByAppendingString:self];
    }
    return string;
}

- (NSString *)padLeft:(NSInteger)width padding:(NSString *)padding{
    if (width < self.length) {
        return self;
    }
    return [[padding repeating: width - self.length] stringByAppendingString:self];
}

- (NSString *)padRight:(NSInteger)width padding:(NSString *)padding{
    if (width < self.length) {
        return self;
    }
    return [self stringByAppendingString:[padding repeating: width - self.length]];
}

- (NSString *)stringByTrimmingCharactersInString:(NSString *)string{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:string];
    NSString *result = [self stringByTrimmingCharactersInSet:set];
    return result;
}

- (NSString *)stringByReplacingCharacterIdx:(NSUInteger)index withString:(NSString *)string{
    NSAssert(index < self.length, @"index非法!!!");
    return [self stringByReplacingCharactersInRange:NSMakeRange(index, 1) withString:string];
}

- (NSString *)subStringFrom:(NSString *)startString to:(NSString *)endString{
    NSRange startRange = [self rangeOfString:startString];
    NSRange endRange = [self rangeOfString:endString];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    return [self substringWithRange:range];
}

- (NSString *)stringByReplacingAsteriskRange:(NSRange)range{
    NSAssert([self substringWithRange:range], @"星号代替字符失败,请检查字符串和range");
    NSString *result = [self stringByReplacingCharactersInRange:range withString:[@"*" repeating:range.length]];
    return result;
}

/// 整形判断
- (BOOL)isPureInteger{
    NSScanner *scan = [NSScanner scannerWithString:self];
    NSInteger val = 0;
    return ([scan scanInteger:&val] && [scan isAtEnd]);
}
/// 浮点形判断
- (BOOL)isPureFloat{
    NSScanner *scan = [NSScanner scannerWithString:self];
    double val = 0.0;
    return ([scan scanDouble:&val] && [scan isAtEnd]);
}

- (BOOL)isPureByCharSet:(NSString *)charSet{
    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:charSet] invertedSet];
    NSString *result = [[self componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
    return [result isEqualToString:self];
}

- (BOOL)isContainsSet:(NSCharacterSet *)set{
    NSRange rang = [self rangeOfCharacterFromSet:set];
    return (rang.location != NSNotFound);
}

//Unicode编码的字符串转成NSString
- (NSString *)makeUnicodeToString{
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    //NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData mutabilityOption:NSPropertyListImmutable format:NULL errorDescription:NULL];
    
    NSString *returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListMutableContainersAndLeaves format:NULL error:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

/**
 汉字转拼音
 */
- (NSString *)transformToPinyin{
    //转成了可变字符串
    NSMutableString *mstr = [NSMutableString stringWithString:self];
//    //先转换为带声调的拼音
//    CFStringTransform((CFMutableStringRef)mstr, NULL, kCFStringTransformMandarinLatin, false);
//    //再转换为不带声调的拼音
//    CFStringTransform((CFMutableStringRef)mstr, NULL, kCFStringTransformStripCombiningMarks, false);
    bool canTransform = CFStringTransform((CFMutableStringRef)mstr, NULL, kCFStringTransformMandarinLatin, false) && CFStringTransform((CFMutableStringRef)mstr, NULL, kCFStringTransformStripCombiningMarks, false);
    if (canTransform == true) {
        return [NSString stringWithString:mstr];
    }
    return @"";
}

+ (NSString *)randomStringLength:(NSInteger)length{
    NSArray *array = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",
                       @"H",@"I",@"J",@"K",@"L",@"M",@"N",
                       @"O",@"P",@"Q",@"R",@"S",@"T",@"U",
                       @"V",@"W",@"X",@"Y",@"Z"];
    
    NSString *randomString = @"";
    for (NSInteger i = 0; i < length; i++) {
        int x = arc4random() % 25;
        randomString = [NSString stringWithFormat:@"%@%@", randomString, array[x]];
    }
    return randomString;
}

/**
 当标题包含*显示红色*,不包含*则显示透明色*
 */
- (NSAttributedString *)toAsterisk{
    BOOL isMust = [self containsString:kAsterisk] ? YES : NO;
    
    NSAttributedString *attr = [self.matt appendPrefix:kAsterisk color:UIColor.redColor font:[UIFont systemFontOfSize:15]];
//    NSAttributedString *attr = [NSAttributedString getAttringByPrefix:kAsterisk content:self isMust:isMust color:UIColor.blackColor];
    return attr;
}

- (void)copyToPasteboard:(BOOL)hiddenTips{
    NSAssert([self isKindOfClass:[NSString class]] | [self isKindOfClass:[NSAttributedString class]], @"目前仅支持NSString,NSAttributedString");
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if ([self isKindOfClass:[NSAttributedString class]]) {
        pasteboard.string = [(NSAttributedString *)self string];
        
    }
    if ([self isKindOfClass:[NSString class]]) {
        pasteboard.string = (NSString *)self;
    }
    
    if (hiddenTips == NO) {
        NSString * tips = [NSString stringWithFormat:@"'%@'已复制!",pasteboard.string];
        [UIAlertController alertControllerWithTitle:@"" message:tips preferredStyle:UIAlertControllerStyleAlert]
        .present(true, nil);
    }
}

@end



@implementation NSMutableString (Ext)

- (NSMutableString * _Nonnull (^)(NSString * _Nonnull))appending{
    return ^(NSString *value) {
        [self appendString:value];
        return self;
    };
}

- (NSMutableString * _Nonnull (^)(NSString * _Nonnull, ...))appendingFormat{
    return ^(NSString *format, ...){
        va_list args;
        va_start(args, format);
        NSString *string = [[NSString alloc] initWithFormat:format arguments:args];
        va_end(args);
        [self appendString:string];
        return self;
    };
}

- (NSMutableString * _Nonnull (^)(NSRange, NSString * _Nonnull))replacingCharacters{
    return ^(NSRange range, NSString *value) {
        [self replaceCharactersInRange:range withString:value];
        return self;
    };
}
                                                                                                    
- (NSMutableString * _Nonnull (^)(NSString * _Nonnull, NSString * _Nonnull, NSStringCompareOptions))replacingOccurrences{
    return ^(NSString *target, NSString *replacement, NSStringCompareOptions options) {
        [self replaceOccurrencesOfString:target withString:replacement options:options range:NSMakeRange(0, self.length)];
        return self;
    };
}

- (NSMutableString * _Nonnull (^)(NSString * _Nonnull, NSUInteger))insertAtIndex{
    return ^(NSString *value, NSUInteger index) {
        [self insertString:value atIndex:index];
        return self;
    };
}

- (NSMutableString * _Nonnull (^)(NSRange))deleteCharacters{
    return ^(NSRange range) {
        [self deleteCharactersInRange:range];
        return self;
    };
}


@end
