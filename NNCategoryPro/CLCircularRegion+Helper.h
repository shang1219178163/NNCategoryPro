//
//  CLCircularRegion+Helper.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/8/20.
//  Copyright © 2019 BN. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLCircularRegion (Helper)

+ (instancetype)regionWithCenter:(CLLocationCoordinate2D)center
                                radius:(CLLocationDistance)radius
                            identifier:(NSString *)identifier;
@end

NS_ASSUME_NONNULL_END
