//
//  NSDateFormatter+Helper.h
//  Location
//
//  Created by BIN on 2017/12/21.
//  Copyright © 2017年 Location. All rights reserved.
//

/**
 NSDateFormatter *dateFormatter = [NSDateFormatter dateFormat:@"MM/dd/yyyy"];

 */

#import <Foundation/Foundation.h>

@interface NSDateFormatter (Helper)

+ (NSDateFormatter *)dateFormat:(NSString *)formatStr;
    
@end
