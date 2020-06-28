//
//  NSObject+ModelHelper.h
//  
//
//  Created by BIN on 2017/11/28.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//弃用
@interface NSObject (ModelHelper)

-(id)convertFromDict:(NSDictionary *)dict key:(NSString *)key;

-(void)convertBaseTypesForYYModelDict:(NSDictionary *)dict;
-(void)convertBaseTypesForYYModelDict:(NSDictionary *)dict mapperDict:(NSDictionary *)mapperDict;

@end

NS_ASSUME_NONNULL_END
