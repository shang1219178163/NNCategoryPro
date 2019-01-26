//
//  NSDecimalNumber+Helper.m
//  BNCategory
//
//  Created by BIN on 2018/11/22.
//

#import "NSDecimalNumber+Helper.h"

@implementation NSDecimalNumber (Helper)

-(NSString *)string{
    return [NSString stringWithFormat:@"%@",self];
}

NSDecimalNumber * NSDecNumFromString(NSString *string){
    return [NSDecimalNumber decimalNumberWithString:string];
}

NSDecimalNumber * NSDecNumFromFloat(CGFloat num){
    return [NSDecimalNumber decimalNumberWithDecimal:[@(num) decimalValue]];
}

NSDecimalNumber * NSDecNumFrom(NSDecimalNumber *num, NSUInteger scale, NSRoundingMode roundingMode){
    NSDecimalNumberHandler * handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roundingMode
                                                                                               scale:scale
                                                                                    raiseOnExactness:NO
                                                                                     raiseOnOverflow:NO
                                                                                    raiseOnUnderflow:NO
                                                                                 raiseOnDivideByZero:YES];
    return [num decimalNumberByRoundingAccordingToBehavior:handler];
}


/**
 四舍五入
 @param scale 小数点后保留的位数
 */
NSDecimalNumber * NSDecNumFromRoundPlain(NSDecimalNumber *num, NSUInteger scale){
    return NSDecNumFrom(num, scale, NSRoundPlain);
}

/**
 只入不舍
 @param scale 小数点后保留的位数
 */
NSDecimalNumber * NSDecNumFromRoundUp(NSDecimalNumber *num, NSUInteger scale){
    return NSDecNumFrom(num, scale, NSRoundUp);
}

/**
 只舍不入
 @param scale 小数点后保留的位数
 */
NSDecimalNumber * NSDecNumFromRoundDown(NSDecimalNumber *num, NSUInteger scale){
    return NSDecNumFrom(num, scale, NSRoundDown);
}

/**
 (也是四舍五入,这是和NSRoundPlain不一样,如果精确的哪位是5,
 它要看精确度的前一位是偶数还是奇数,如果是奇数,则入,偶数则舍,例如scale=1,表示精确到小数点后一位, NSDecimalNumber 为1.25时,
 NSRoundPlain结果为1.3,而NSRoundBankers则是1.2)
 @param scale 小数点后保留的位数
 */
NSDecimalNumber * NSDecNumFromRoundBanks(NSDecimalNumber *num, NSUInteger scale){
    return NSDecNumFrom(num, scale, NSRoundBankers);
}

@end
