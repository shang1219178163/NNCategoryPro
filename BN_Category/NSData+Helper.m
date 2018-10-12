

//
//  NSData+Helper.m
//  Location
//
//  Created by BIN on 2017/12/23.
//  Copyright © 2017年 Location. All rights reserved.
//

#import "NSData+Helper.h"

@implementation NSData (Helper)


+(NSData *)dataFromObj:(id)obj{
    NSAssert([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[UIImage class]], @"仅支持NSString, NSDictionary, NSArray, UIImage");

    NSData * data = nil;
    if ([obj isKindOfClass:[NSString class]]) {
        data = [obj dataUsingEncoding:NSUTF8StringEncoding];
        
    }
    else if ([obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSArray class]]){
        
        NSError * error = nil;
        data = [NSJSONSerialization dataWithJSONObject:obj options:0 error:&error];

        if (data && error == nil) {
            return data;
        }
    }
    else if ([obj isKindOfClass:[UIImage class]]){
        data = UIImageJPEGRepresentation(obj, 1.0);
        
    }
    return data;
    
}


@end
