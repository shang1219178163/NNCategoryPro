//
//  NSUserDefaults+Helper.m
//  HuiZhuBang
//
//  Created by BIN on 2018/3/16.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "NSUserDefaults+Helper.h"

#import <objc/runtime.h>

@implementation NSUserDefaults (Helper)

+ (NSArray *)typeList{
    return @[@"NSData", @"NSString", @"NSNumber", @"NSDate", @"NSArray", @"NSDictionary"];
    
}

-(NSArray *)typeArray{
    //    return objc_getAssociatedObject(self, _cmd);
    
    NSArray * array = @[@"NSData", @"NSString", @"NSNumber", @"NSDate", @"NSArray", @"NSDictionary"];
    return array;
}

//-(void)setTypeArray:(NSArray *)typeArray{
//    objc_setAssociatedObject(self, @selector(typeArray), typeArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//
//}

- (void)BN_setObject:(id)value forKey:(NSString *)defaultName{
    
    NSArray * array = [self typeArray];
    if (![array containsObject:NSStringFromClass([value class])]) {
        value = [NSKeyedArchiver archivedDataWithRootObject:value];//保存自定义对象
        
    }
    [self setObject:value forKey:defaultName];
    
}

- (id)BN_objectForKey:(NSString *)defaultName{
    id obj = [self objectForKey:defaultName];
    if ([obj isKindOfClass:[NSData class]]) {
        obj = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
        
    }
    return obj;
}

+ (void)BN_setObject:(id)value forKey:(NSString *)defaultName{
    //添加数组支持
    NSArray * array = [[self standardUserDefaults]typeArray];
    if (![array containsObject:NSStringFromClass([value class])]) {
        value = [NSKeyedArchiver archivedDataWithRootObject:value];//保存自定义对象
        
    }
    [[self standardUserDefaults] setObject:value forKey:defaultName];
    
}

+ (id)BN_objectForKey:(NSString *)defaultName{
    
    id obj = [[self standardUserDefaults] objectForKey:defaultName];
    if ([obj isKindOfClass:[NSData class]]) {
        obj = [NSKeyedUnarchiver unarchiveObjectWithData:obj];//解档自定义对象
        
    }
    return obj;
    
}

+ (void)defaultsSynchronize{
    [[self standardUserDefaults]synchronize];
    
    NSString *path = NSHomeDirectory();
    //    DDLog(@"\n%@",path);
}


@end
