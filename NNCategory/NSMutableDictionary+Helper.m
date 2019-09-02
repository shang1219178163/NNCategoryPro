//
//  NSMutableDictionary+Helper.m
//  
//
//  Created by BIN on 2017/8/11.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "NSMutableDictionary+Helper.h"

@implementation NSMutableDictionary (Helper)

-(void)setSafeObjct:(id _Nullable)obj forKey:(id<NSCopying>)akey{
    if (!obj || [obj isKindOfClass:[NSNull class]]) {
        [self setObject:@"" forKey:akey];
        return;
    }
    [self setObject:obj forKey:akey];
}

//-(void)setSafeObjct:(id _Nullable)obj forKey:(id<NSCopying>)akey{
//    if (!obj || [obj isKindOfClass:[NSNull class]]) {
//        [self setObject:@"" forKey:akey];
//
//    } else {
//        [self setObject:obj forKey:akey];
//
//    }
//}


@end
