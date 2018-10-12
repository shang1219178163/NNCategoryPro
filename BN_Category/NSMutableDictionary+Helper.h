//
//  NSMutableDictionary+Helper.h
//  HuiZhuBang
//
//  Created by BIN on 2017/8/11.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Helper)

-(void)setSafeObjct:(id)obj forKey:(id<NSCopying>)akey;


@end
