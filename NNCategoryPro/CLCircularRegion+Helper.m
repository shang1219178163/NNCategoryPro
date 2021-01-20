
//
//  CLCircularRegion+Helper.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/8/20.
//  Copyright © 2019 BN. All rights reserved.
//

#import "CLCircularRegion+Helper.h"

@implementation CLCircularRegion (Helper)

+ (instancetype)regionWithCenter:(CLLocationCoordinate2D)center
                          radius:(CLLocationDistance)radius
                      identifier:(NSString *)identifier{
//    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(39.788857, 116.5559392);
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:center 
                                                                 radius:radius 
                                                             identifier:identifier];
    region.notifyOnEntry = YES;
    region.notifyOnExit = YES;
    return region;
}

@end
