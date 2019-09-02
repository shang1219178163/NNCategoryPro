//
//  NSObject+FaceDetect.h
//  FaceDetector
//
//  Created by BIN on 2018/2/11.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (FaceDetect)

- (NSArray *)faceDetectImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
