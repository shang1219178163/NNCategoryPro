//
//  UITextView+Helper.h
//  NNCategory
//
//  Created by BIN on 2018/11/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (Helper)

@property (nonatomic, strong) UITextView *placeHolderTextView;

/**
 带提示的textView
 */
+ (instancetype)createRect:(CGRect)rect;

/**
 [简]带提示的textView
 */
+ (instancetype)createRect:(CGRect)rect placeholder:(NSString *)placeholder;

/**
 展示性质的textView,不提供编辑
 */
+ (instancetype)createTextShowRect:(CGRect)rect;

-(void)setHyperlinkDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
