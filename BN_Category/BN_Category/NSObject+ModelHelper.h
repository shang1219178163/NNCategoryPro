//
//  NSObject+ModelHelper.h
//  HuiZhuBang
//
//  Created by BIN on 2017/11/28.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (ModelHelper)

-(id)convertFromDict:(NSDictionary *)dict key:(NSString *)key;

//-(NSString *)convertToStrFromDict:(NSDictionary *)dict key:(NSString *)key;

-(void)convertBaseTypesForYYModelDict:(NSDictionary *)dict;
-(void)convertBaseTypesForYYModelDict:(NSDictionary *)dict mapperDict:(NSDictionary *)mapperDict;

-(void)BN_setValidValueFromModel:(id)model;

//- (NSMutableArray *)dataByList:(NSArray *)modelList propertyList:(NSArray *)propertyList isNumValue:(BOOL)isNumValue;


@end
