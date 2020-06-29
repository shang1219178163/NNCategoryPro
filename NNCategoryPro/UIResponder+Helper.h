//
//  UIResponder+Helper.h
//  NNCategory
//
//  Created by BIN on 2018/11/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (Helper)

-(UIResponder *_Nullable)nextResponder:(NSString *)responderName;

- (NSString *)responderChainDescription;

@end

NS_ASSUME_NONNULL_END
