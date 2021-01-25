//
//  UILabel+Helper.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/3.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

///自定义显示样式
typedef NS_ENUM(NSUInteger, NNLabelType) {
    ///无限折行
    NNLabelTypeNumberOfLines0,
    ///abc...
    NNLabelTypeNumberOfLines1,
    ///白底主题色字(带边框)
    NNLabelTypeFitWidth,
    ///带边框的标签
    NNLabelTypeOutline,
};

@interface UILabel (Helper)

@property(nonatomic, strong, readonly) NSMutableAttributedString *matt;

/**
 [源]UILabel创建
 */
+ (instancetype)createRect:(CGRect)rect type:(NNLabelType)type;

- (void)setCustomType:(NNLabelType)type;

- (void)setContent:(NSString *)content attDic:(NSDictionary *)attDic;

@end

NS_ASSUME_NONNULL_END
