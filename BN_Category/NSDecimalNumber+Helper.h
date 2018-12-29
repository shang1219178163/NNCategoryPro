//
//  NSDecimalNumber+Helper.h
//  BN_Category
//
//  Created by BIN on 2018/11/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDecimalNumber (Helper)

@property (nonatomic, strong, readonly) NSString *string;

NSDecimalNumber * NSDecNumFromString(NSString *string);

NSDecimalNumber * NSDecNumFromFloat(CGFloat num);

/**
 四舍五入
 @param scale 小数点后保留的位数
 */
NSDecimalNumber * NSDecNumFromRoundPlain(NSDecimalNumber *num, NSUInteger scale);

/**
 只入不舍
 @param scale 小数点后保留的位数
 */
NSDecimalNumber * NSDecNumFromRoundUp(NSDecimalNumber *num, NSUInteger scale);
/**
 只舍不入
 @param scale 小数点后保留的位数
 */
NSDecimalNumber * NSDecNumFromRoundDown(NSDecimalNumber *num, NSUInteger scale);
/**
 (也是四舍五入,这是和NSRoundPlain不一样,如果精确的哪位是5,
 它要看精确度的前一位是偶数还是奇数,如果是奇数,则入,偶数则舍,例如scale=1,表示精确到小数点后一位, NSDecimalNumber 为1.25时,
 NSRoundPlain结果为1.3,而NSRoundBankers则是1.2)
 @param scale 小数点后保留的位数
 */
NSDecimalNumber * NSDecNumFromRoundBanks(NSDecimalNumber *num, NSUInteger scale);
    
@end

NS_ASSUME_NONNULL_END
