//
//  NSDictionary+Helper.h
//  HuiZhuBang
//
//  Created by BIN on 2017/8/24.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Helper)

/**
 根据key对字典values排序,区分大小写(按照ASCII排序)
 */
- (NSArray *)sortedValuesByKey;

- (NSMutableDictionary *)filterDictByContainQuery:(NSString *)query isNumValue:(BOOL)isNumValue;

/**
 *  @brief  将NSDictionary转换成url 参数字符串
 *  @return url 参数字符串
 */
- (NSString *)toURLQueryString;

/**
 *  @brief  将NSDictionary转换成XML字符串 不带XML声明 不带根节点
 *  @return XML 字符串
 */
- (NSString *)jk_XMLString;
/**
 *  @brief  将NSDictionary转换成XML字符串, 默认 <?xml version=\"1.0\" encoding=\"utf-8\"?> 声明   自定义根节点
 *  @param rootElement 根节点
 *  @return XML 字符串
 */
- (NSString *)jk_XMLStringDefaultDeclarationWithRootElement:(NSString*)rootElement;
/**
 *  @brief  将NSDictionary转换成XML字符串, 自定义根节点  自定义xml声明
 *  @param rootElement 根节点
 *  @param declaration xml声明
 *  @return 标准合法 XML 字符串
 */
- (NSString *)jk_XMLStringWithRootElement:(NSString*)rootElement declaration:(NSString*)declaration;
/**
 *  @brief  将NSDictionary转换成Plist字符串
 *  @return Plist 字符串
 */
- (NSString *)jk_plistString;
/**
 *  @brief  将NSDictionary转换成Plist data
 *  @return Plist data
 */
- (NSData *)jk_plistData;


@end
