
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
#import "NSDate+Helper.h"
#import "NSDateFormatter+Helper.h"

#import "NSNumberFormatter+Helper.h"
#import "NSNumber+Helper.h"

#import "BNGloble.h"

@implementation NSString (Helper)

-(NSDecimalNumber *)decNumer{
    return [NSDecimalNumber decimalNumberWithString:self];
}

/**
 NSIndexPath->字符串
 */
NSString * NSStringFromIndexPath(NSIndexPath *indexPath) {
    return [NSString stringWithFormat:@"{%@,%@}",@(indexPath.section),@(indexPath.row)];
}
/**
 html->字符串
 */
NSString * NSStringFromHTML(NSString *html) {
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while(scanner.isAtEnd == NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //  过滤html中的\n\r\t换行空格等特殊符号
    //    NSMutableString *str1 = [NSMutableString stringWithString:html];
    //    for (NSInteger i = 0; i < str1.length; i++) {
    //        unichar c = [str1 characterAtIndex:i];
    //        NSRange range = NSMakeRange(i, 1);
    //
    //        //  在这里添加要过滤的特殊符号
    //        if ( c == '\r' || c == '\n' || c == '\t') {
    //            [str1 deleteCharactersInRange:range];
    //            --i;
    //        }
    //    }
    //    html  = [NSString stringWithString:str1];
    return html;
}
/**
 id类型->字符串
 */
NSString * NSStringFromLet(id obj) {
    return [NSString stringWithFormat:@"%@",obj];
}

/**
 NSInteger->字符串
 */
NSString * NSStringFromInt(NSInteger obj){
    return [@(obj) stringValue];
}

/**
 CGFloat->字符串
 */
NSString * NSStringFromFloat(CGFloat obj){
    return [@(obj) stringValue];
}

//整形判断
- (BOOL)isPureInteger{
    NSString * string = self;
    NSScanner * scan = [NSScanner scannerWithString:string];
    NSInteger val = 0;
    return [scan scanInteger:&val] && [scan isAtEnd];
}
//浮点形判断：
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

/**
 json转NSObject
 */
- (id)objcValue{
    NSError *error;
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    id obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (error != nil) {
#ifdef DEBUG
        NSLog(@"fail to get dictioanry from JSON: %@, error: %@", self, error);
#endif
    }
    return obj;
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


- (NSString *)subStringFrom:(NSString *)startString to:(NSString *)endString{
    NSRange startRange = [self rangeOfString:startString];
    NSRange endRange = [self rangeOfString:endString];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    return [self substringWithRange:range];
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
    return TimeStampFromObj(dateStr);
}

- (NSString *)toTimestampShort{
    NSString * dateStr = (NSString *)self;
    
    NSString * tmp = @" 00:00:00";//后台接口时间戳不要时分秒
    if (dateStr.length == 10) dateStr = [dateStr stringByAppendingString:tmp];
    dateStr = [dateStr stringByReplacingCharactersInRange:NSMakeRange(dateStr.length - tmp.length, tmp.length) withString:tmp];
    return TimeStampFromObj(dateStr);
}

- (NSString *)toTimestampFull{
    NSString * dateStr = (NSString *)self;
    
    NSString * tmp = @" 23:59:59";//后台接口时间戳不要时分秒
    if (dateStr.length == 10) dateStr = [dateStr stringByAppendingString:tmp];
    dateStr = [dateStr stringByReplacingCharactersInRange:NSMakeRange(dateStr.length - tmp.length, tmp.length) withString:tmp];
    return TimeStampFromObj(dateStr);
}

- (NSString *)toDateShort{
    if (IsTimeStamp(self)) return self;
    NSString *dateStr = [self substringToIndex:10];
    return dateStr;
}

- (NSString *)toDateMonthDay{
    if (IsTimeStamp(self)) return self;
    NSString *dateStr = [self substringWithRange:NSMakeRange(5, 5)];
    return dateStr;
}

- (NSString *)toBeforeDays:(NSInteger)days{
    NSTimeInterval timeInterval = [TimeStampFromObj(self) integerValue] - days*24*3600;
    
    NSDateFormatter *formatter = [NSDateFormatter dateFormat:kFormatDate];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString * timeStr = [formatter stringFromDate:date];
    return timeStr;
}

- (NSString *)compareDate:(NSString *)otherDate isMax:(BOOL)isMax type:(NSNumber *)type{
    
    NSString * timestampA = @"";
    NSString * timestampB = @"";
    switch (type.integerValue) {
        case 1:
        {
            timestampA = [self toTimestampShort];
            timestampB = [otherDate toTimestampShort];
        }
            break;
        case 2:
        {
            timestampA = [self toTimestampFull];
            timestampB = [otherDate toTimestampFull];
        }
            break;
        default:
        {
            timestampA = TimeStampFromObj(self);
            timestampB = TimeStampFromObj(otherDate);
        }
            break;
    }
    
    if ([timestampA integerValue] >= [timestampB integerValue] && isMax) {
        return self;
        
    } else {
        return otherDate;
        
    }
    return nil;
}

+ (NSString *)stringFromData:(NSData *)data{
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}

- (id)filterString:(NSString *)filterString{
    NSString * string = self;
    if (self.length > 0) {
//        NSCharacterSet *charset = [[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]"] invertedSet];
        NSCharacterSet *charset = [[NSCharacterSet characterSetWithCharactersInString:filterString] invertedSet];
        string = [string stringByAddingPercentEncodingWithAllowedCharacters:charset];
        
    }
    return string;
}

- (NSString *)stringByReplacingList:(NSArray *)list withString:(NSString *)replacement{
    __block NSString * string = self;
    
    [list enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        string = [string stringByReplacingOccurrencesOfString:obj  withString:replacement];
        
    }];
    return string;
}

- (NSString *)deleteWhiteSpaceBeginEnd{
    NSCharacterSet  *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString * string = [self stringByTrimmingCharactersInSet:set];
    return string;
}

- (NSString *)stringByTitle{
    NSString * string = self;
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@":" withString:@""];

    return string;
    
}

- (NSString *)stringByReplacingAsteriskRange:(NSRange)range{
    NSString *replaceStr = self;
    if ([replaceStr substringWithRange:range]) {
        replaceStr = [replaceStr stringByReplacingCharactersInRange:range withString:[self getAsteriskStringByRange:range]];

    }
    else{
        NSAssert([replaceStr substringWithRange:range], @"星号代替字符失败,请检查字符串和range");
        
    }
    return replaceStr;
}

- (NSString *)getAsteriskStringByRange:(NSRange)range{
    NSString * string = @"";
    for (NSInteger i = 0; i < range.length; i++) {
        string = [string stringByAppendingString:@"*"];
    }
    return string;
}

- (NSString *)stringByReplacingCharacterIndex:(NSUInteger)index withString:(NSString *)string{
    NSAssert(index < self.length, @"index非法!!!");
    return [self stringByReplacingCharactersInRange:NSMakeRange(index, 1) withString:string];
}

- (NSString *)randomStringLength:(NSInteger)length{
    NSString *fromString = self;

    NSMutableString *mStr = [NSMutableString stringWithCapacity:0];
    for (NSInteger i = 0; i < length; i++) {
        //        [mStr appendFormat: @"%C", [fromString characterAtIndex:arc4random_uniform((u_int32_t)fromString.length)]];
        NSUInteger randomIndex = arc4random()%length;
        [mStr appendFormat: @"%C", [fromString characterAtIndex:randomIndex]];
        
    }
    return mStr;
}

/**

 @param array 字符串数组
 @return 包含所有元素
 */
- (BOOL)containArray:(NSArray *)array{
    for (NSString * obj in array) {
        if (![self containsString:obj]) return NO;
    }
    return YES;
}

- (NSString *)getPlaceholder{
    NSString * placeHolder = [NSString stringWithFormat:@"请输入%@",self];
    placeHolder = [placeHolder stringByReplacingOccurrencesOfString:@" " withString:@""];
    placeHolder = [placeHolder stringByReplacingOccurrencesOfString:@":" withString:@""];
    return placeHolder;
}


+ (NSString *)ramdomText{
    
    NSArray * array = @[@"测试数据,",@"test_",@"AAAAA-",@"BBBBB>",@"秦时明月",@"犯我大汉天威者,虽远必诛",];
    CGFloat length = arc4random()%15 + 5;
    NSMutableString * mstr = [NSMutableString stringWithCapacity:0];
    for (NSUInteger i = 0; i < length; i++) {
        
        NSInteger random = (NSInteger)(arc4random() % array.count);
        NSString * text = array[random];
        [mstr appendString:text];
    }
    return mstr;
    
}

-(NSString *)multiplyAnothor:(NSString *)anothor{
    NSAssert([self isPureInteger] || [self isPureFloat], @"支持持纯数字字符串");
    if (!anothor || [self floatValue] == 0.0  || [anothor floatValue] == 0.0) {
        return @"0";
    }
    
    CGFloat result = [self floatValue] * [anothor floatValue];
    return [@(result) stringValue];
}


-(NSString *)divideAnothor:(NSString *)anothor{
    NSAssert([self isPureInteger] || [self isPureFloat], @"支持持纯数字字符串");
    if (!anothor || [self floatValue] == 0.0  || [anothor floatValue] == 0.0) {
        return @"0";
    }
    
    CGFloat result = [self floatValue] / [anothor floatValue];
    return [@(result) stringValue];
}

-(NSString *)addAnothor:(id)anothor{
    NSAssert([self isPureInteger] || [self isPureFloat], @"支持持纯数字字符串");
    NSParameterAssert([anothor isKindOfClass:[NSString class]] || [anothor isKindOfClass:[NSNumber class]]);
    
    CGFloat result = [self integerValue] + [anothor integerValue];
    return [@(result) stringValue];
}

- (NSString *)stringWithFront:(NSString *)front back:(NSString *)back{
    NSParameterAssert([self containsString:front] && [self containsString:back]);
    NSRange rangeStart = [self rangeOfString:front];
    NSRange rangeEnd = [self rangeOfString:back];
    
    NSRange range = NSMakeRange(rangeStart.location + rangeStart.length, rangeEnd.location - rangeStart.location - rangeStart.length);
    NSString * result = [self substringWithRange:range];
    return result;
}

/**
 当标题包含*显示红色*,不包含*则显示透明色*
 */
- (NSAttributedString *)toAsterisk{
    BOOL isMust = [self containsString:kAsterisk] ? YES : NO;
    NSAttributedString *titleAtt = [self getAttringByPrefix:kAsterisk content:self must:@(isMust)];
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
//        [(UIView *)UIApplication.keyWindow makeToast:tips duration:1 position:CSToastPositionCenter];
        [UIApplication.rootController showAlertTitle:@"" msg:tips];
        
    }
}

- (void)copyToPasteboard{
    [self copyToPasteboard:YES];
    
}

- (BOOL)openThisURL{
    NSAssert([self isKindOfClass:[NSAttributedString class]] || [self isKindOfClass:[NSString class]], @"只支持字符串,请检查格式!");
    
    NSString * urlString = nil;
    if ([self isKindOfClass:[NSAttributedString class]]) {
        urlString = [(NSAttributedString *)self string];
        
    }
    if ([self isKindOfClass:[NSString class]]) {
        urlString = (NSString *)self;
        
    }
    UIApplication *application = UIApplication.sharedApplication;
    NSURL *URL = [NSURL URLWithString:urlString];
    
    
    __block BOOL isSuccess = NO;
    if (iOSVer(10)) {
        [application openURL:URL options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @YES} completionHandler:^(BOOL success) {
            isSuccess = success;
        }];
    }
    else{
        BOOL success = [application openURL:URL];
        isSuccess = success;
        
    }
    return isSuccess;
}

- (BOOL)callPhone{
    NSString * phoneNum = self;
    if (phoneNum) {
        phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@" " withString:@""];
        phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@"-" withString:@""];
        phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@"转" withString:@""];
    }
    
    NSMutableString *str = [[NSMutableString alloc]initWithFormat:@"tel:%@",phoneNum];
    
    __block  BOOL isSuccess = NO;
    [UIApplication.rootController showAlertTitle:nil msg:phoneNum actionTitles:@[kActionTitle_Cancell,kActionTitle_Call] handler:^(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nullable action) {
        if ([action.title isEqualToString:kActionTitle_Call]) {
            isSuccess = [UIApplication.sharedApplication openURL:[NSURL URLWithString:str]];
            
        }
    }];
    return isSuccess;
}


@end
