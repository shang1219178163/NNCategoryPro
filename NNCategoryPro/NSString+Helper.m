
//
//  NSString+Helper.m
//  
//
//  Created by BIN on 2017/7/31.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "NSString+Helper.h"

#import "UIApplication+Helper.h"
#import "UIViewController+Helper.h"

#import "NSAttributedString+Helper.h"
#import "NSDate+Helper.h"
#import "NSDateFormatter+Helper.h"

#import "NSNumberFormatter+Helper.h"
#import "NSNumber+Helper.h"
#import "UIAlertController+Helper.h"

#import <NNGloble/NNGloble.h>

@implementation NSString (Helper)

-(BOOL)isValid{
    NSString *tmp = self;
    tmp = [tmp stringByReplacingOccurrencesOfString:@" " withString:@""];
            
    NSArray *array = @[@"",@"nil",@"null"];
    if ([array containsObject:tmp] || [tmp containsString:@"null"]) {
//         NSLog(@"无效字符->(%@)",string);
        return false;
    }
    return true;
}

-(NSData *)jsonData{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

-(id)objValue{
    NSError *error;
    id obj = [NSJSONSerialization JSONObjectWithData:self.jsonData options:kNilOptions error:&error];
    if (error) {
        return nil;
    }
    return obj;
}

-(NSDictionary *)dictValue{
    NSError *error;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:self.jsonData options:kNilOptions error:&error];
    if (error) {
        return [NSDictionary dictionary];
    }
    return result;
}

-(NSArray *)arrayValue{
    NSError *error;
    NSArray *result = [NSJSONSerialization JSONObjectWithData:self.jsonData options:kNilOptions error:&error];
    if (error) {
        return [NSArray array];
    }
    return result;
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


NSString * NSStringFromIndexPath(NSIndexPath *indexPath) {
    return [NSString stringWithFormat:@"{%@,%@}",@(indexPath.section),@(indexPath.row)];
}

NSString * NSStringFromHTML(NSString *html) {
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while(scanner.isAtEnd == NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}

NSString * NSStringFromLet(id obj) {
    return [NSString stringWithFormat:@"%@", obj];
}

NSString * NSStringFromInt(NSInteger obj){
    return [@(obj) stringValue];
}

NSString * NSStringFromFloat(CGFloat obj){
    return [@(obj) stringValue];
}

+ (NSString *)repeating:(NSString *)repeatedValue count:(NSInteger)count{
    NSString *string = @"";
    for (NSInteger i = 0; i < count; i++) {
        string = [string stringByAppendingString:repeatedValue];
    }
    return string;
}

- (NSString *)stringByTrimmingCharactersInString:(NSString *)string{
    if (self.length <= 0) {
        return string;
    }
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:string];
    NSString *result = [string stringByTrimmingCharactersInSet:set];
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
    NSString *result = [self stringByReplacingCharactersInRange:range withString:[NSString repeating:@"*" count:range.length]];
    return result;
}


/// 判断是否时间戳字符串
- (BOOL)isTimeStamp{
    if ([self containsString:@" "] || [self containsString:@"-"] || [self containsString:@":"]) {
        return false;
    }
    
    if (![self isPureInteger] || self.doubleValue < NSDate.date.timeIntervalSince1970) {
        return false;
    }
    return true;
}

/// 整形判断
- (BOOL)isPureInteger{
    NSString * string = self;
    NSScanner * scan = [NSScanner scannerWithString:string];
    NSInteger val = 0;
    return [scan scanInteger:&val] && [scan isAtEnd];
}
/// 浮点形判断
- (BOOL)isPureFloat{
    NSString * string = self;
    NSScanner * scan = [NSScanner scannerWithString:string];
    CGFloat val = 0.0;
    return [scan scanDouble:&val] && [scan isAtEnd];
}

- (id)numberValue{
    if ([self isPureInteger]) {
        return @([self integerValue]);
    }
    
    if ([self isPureFloat]) {
        return @([self floatValue]);
    }
    return self;
}

- (BOOL)isPureByCharSet:(NSString *)charSet{
    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:charSet] invertedSet];
    NSString *result = [[self componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
    return [result isEqualToString:self];
}

- (NSString *)toFileString{
    NSArray * fileNameList = [self componentsSeparatedByString:@"."];
    NSString * path = [NSBundle.mainBundle pathForResource:fileNameList.firstObject ofType:fileNameList.lastObject];
    NSData * data = [NSData dataWithContentsOfFile:path];
    
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    return jsonString;
}

/**
 *  @brief  是否包含空格
 *  @return 是否包含空格
 */
- (BOOL)isContainBlank{
    NSRange range = [self rangeOfString:@" "];
    return (range.location != NSNotFound);
}

- (BOOL)isContainsCharacterSet:(NSCharacterSet *)set{
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

- (NSString *)stringBylimitLength:(NSInteger)limitLength{
    NSString * string = self;
    if (string.length > limitLength) {
        string = [string substringToIndex:limitLength];
        string = [string stringByAppendingString:@"..."];
    }
    return string;
}

+ (NSString *)stringFromNumber:(NSNumber *)number{
    NSString * sting = [number stringValue];
    return sting;
}

+ (NSString *)stringFromInter:(NSInteger)inter{
    NSString * sting = [@(inter) stringValue];
    return sting;
}

+ (NSString *)stringFromFloat:(CGFloat )inter{
    NSString * sting = [@(inter) stringValue];
    return sting;
}

+ (NSString *)stringFromDouble:(double)inter{
    NSString * sting = [@(inter) stringValue];
    return sting;
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
    NSArray * alphabetArray = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",
                                @"H",@"I",@"J",@"K",@"L",@"M",@"N",
                                @"O",@"P",@"Q",@"R",@"S",@"T",@"U",
                                @"V",@"W",@"X",@"Y",@"Z"];
    
    NSString *randomString = @"";
    for (NSInteger i = 0; i < length; i++) {
        int x = arc4random() % 25;
        randomString = [NSString stringWithFormat:@"%@%@",randomString,alphabetArray[x]];
    }
    return randomString;
}

- (NSString *)randomStringPartLength:(NSInteger)length{
    NSAssert(self.length >= length, @"length应该小于字符串长度");
    
    unichar ch[self.length];
    for (NSInteger i = 0; i < self.length; i++) {
        ch[i] = [self characterAtIndex:i];
    }
    
    NSString *randomString = @"";
    for (NSInteger j = 0; j < length; j++) {
        int x = arc4random() % (self.length - 1);
        randomString = [NSString stringWithFormat:@"%@%C",randomString,ch[x]];
    }
    return randomString;
}

#pragma mark - -时间戳

- (NSString *)toTimestampMonth{
    NSString * dateStr = (NSString *)self;
    
    NSString * tmp = @"01 00:00:00";//后台接口时间戳不要时分秒
    dateStr = [dateStr stringByReplacingCharactersInRange:NSMakeRange(dateStr.length - tmp.length, tmp.length) withString:tmp];
    return [NSDateFormatter intervalFromDateStr:dateStr fmt:kFormatDate];
}

- (NSString *)toTimestampBegin{
    NSString *dateStr = (NSString *)self;
    
    NSString *tmp = @" 00:00:00";//后台接口时间戳不要时分秒
    if (dateStr.length == 10) dateStr = [dateStr stringByAppendingString:tmp];
    dateStr = [dateStr stringByReplacingCharactersInRange:NSMakeRange(dateStr.length - tmp.length, tmp.length) withString:tmp];
    return [NSDateFormatter intervalFromDateStr:dateStr fmt:kFormatDate];
}

- (NSString *)toTimestampEnd{
    NSString *dateStr = (NSString *)self;
    
    NSString *tmp = @" 23:59:59";//后台接口时间戳不要时分秒
    if (dateStr.length == 10) dateStr = [dateStr stringByAppendingString:tmp];
    dateStr = [dateStr stringByReplacingCharactersInRange:NSMakeRange(dateStr.length - tmp.length, tmp.length) withString:tmp];
    return [NSDateFormatter intervalFromDateStr:dateStr fmt:kFormatDate];
}

- (NSString *)toDateShort{
    if (self.isTimeStamp) return self;
    NSString *dateStr = [self substringToIndex:10];
    return dateStr;
}

- (NSString *)toDateMonthDay{
    if (self.isTimeStamp) return self;
    NSString *dateStr = [self substringWithRange:NSMakeRange(5, 5)];
    return dateStr;
}

- (id)filterString:(NSString *)filterString{
    if (self.length <= 0) {
        return self;
    }
//    NSCharacterSet *charset = [[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]"] invertedSet];
    NSCharacterSet *charset = [[NSCharacterSet characterSetWithCharactersInString:filterString] invertedSet];
    NSString *string = [self stringByAddingPercentEncodingWithAllowedCharacters:charset];
    return string;
}

- (NSString *)deleteWhiteSpaceBeginEnd{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *string = [self stringByTrimmingCharactersInSet:set];
    return string;
}

- (NSString *)randomStringLength:(NSInteger)length{
    NSMutableString *mStr = [NSMutableString stringWithCapacity:0];
    for (NSInteger i = 0; i < length; i++) {
        NSUInteger randomIndex = arc4random()%length;
        [mStr appendFormat: @"%C", [self characterAtIndex:randomIndex]];
    }
    return mStr;
}

/**
 @param array 字符串数组
 @return 包含所有元素
 */
//- (BOOL)containArray:(NSArray *)array{
//    for (NSString *obj in array) {
//        if (![self containsString:obj]) return NO;
//    }
//    return YES;
//}
//
//- (NSString *)getPlaceholder{
//    NSString *placeHolder = [NSString stringWithFormat:@"请输入%@", self];
//    placeHolder = [placeHolder stringByReplacingOccurrencesOfString:@" " withString:@""];
//    placeHolder = [placeHolder stringByReplacingOccurrencesOfString:@":" withString:@""];
//    return placeHolder;
//}

+ (NSString *)ramdomText{
    NSArray *array = @[@"测试数据,",@"test_",@"AAAAA-",@"BBBBB>",@"秦时明月",@"犯我大汉天威者,虽远必诛",];
    CGFloat length = arc4random()%15 + 5;
    NSMutableString *mstr = [NSMutableString stringWithCapacity:0];
    for (NSUInteger i = 0; i < length; i++) {
        NSInteger random = (NSInteger)(arc4random() % array.count);
        NSString *text = array[random];
        [mstr appendString:text];
    }
    return mstr;
}

-(NSString *)multiplyAnothor:(NSString *)anothor{
    NSAssert([self isPureInteger] || [self isPureFloat], @"支持持纯数字字符串");
    if (!anothor || self.floatValue == 0.0 || anothor.floatValue == 0.0) {
        return @"0";
    }
    
    CGFloat result = self.floatValue * anothor.floatValue;
    return [@(result) stringValue];
}

-(NSString *)divideAnothor:(NSString *)anothor{
    NSAssert([self isPureInteger] || [self isPureFloat], @"支持持纯数字字符串");
    if (!anothor || self.floatValue == 0.0 || anothor.floatValue == 0.0) {
        return @"0";
    }
    
    CGFloat result = self.floatValue / anothor.floatValue;
    return [@(result) stringValue];
}

-(NSString *)addAnothor:(id)anothor{
    NSAssert([self isPureInteger] || [self isPureFloat], @"支持持纯数字字符串");
    NSParameterAssert([anothor isKindOfClass:[NSString class]] || [anothor isKindOfClass:[NSNumber class]]);
    
    CGFloat result = self.integerValue + [anothor integerValue];
    return [@(result) stringValue];
}
/**
 当标题包含*显示红色*,不包含*则显示透明色*
 */
- (NSAttributedString *)toAsterisk{
    BOOL isMust = [self containsString:kAsterisk] ? YES : NO;
    NSAttributedString *titleAtt = [NSAttributedString getAttringByPrefix:kAsterisk content:self isMust:isMust];
    
    return titleAtt;
}

- (BOOL)isBeyondWithLow:(NSString *)low high:(NSString *)high{
    if ([self floatValue] < [low floatValue] || [self floatValue] > [high floatValue]) return YES;
    return  NO;
}

/**
 字符串比大小
 */
- (BOOL)isCompare:(NSString *)string{
    if ([self isEqualToString:@""]) {
        return false;
    }
    
    NSString * str = self;
    if ([self containsString:@"."]) {
        str = [str stringByReplacingOccurrencesOfString:@"." withString:@""];
    }
    return str.integerValue > string.integerValue;
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
        .nn_present(true, nil);
    }
}

@end
