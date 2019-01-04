//
//  UILabel+Helper.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/3.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Helper)

- (NSMutableAttributedString *)setContent:(NSString *)content attDic:(NSDictionary *)attDic;

@end

NS_ASSUME_NONNULL_END
