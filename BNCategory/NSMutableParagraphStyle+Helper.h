//
//  NSMutableParagraphStyle+Helper.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/26.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableParagraphStyle (Helper)

+(NSMutableParagraphStyle)createBreakModel:(NSLineBreakMode )lineBreakMode alignment:(NSTextAlignment )alignment lineSpacing:(CGFloat )lineSpacing;

@end

NS_ASSUME_NONNULL_END
