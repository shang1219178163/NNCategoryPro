//
//  NSMutableDictionary+Helper.m
//  HuiZhuBang
//
//  Created by BIN on 2017/8/11.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "NSMutableDictionary+Helper.h"

@implementation NSMutableDictionary (Helper)

-(void)setSafeObjct:(id)obj forKey:(id<NSCopying>)akey{
    if (obj == nil || [obj isKindOfClass:[NSNull class]]) {
        [self setObject:@"" forKey:akey];
        
    }else{
        [self setObject:obj forKey:akey];
        
    }
}


@end
