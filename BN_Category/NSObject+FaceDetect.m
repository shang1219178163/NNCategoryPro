//
//  NSObject+FaceDetect.m
//  FaceDetector
//
//  Created by BIN on 2018/2/11.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "NSObject+FaceDetect.h"

@implementation NSObject (FaceDetect)

- (NSArray *)faceDetectImage:(UIImage *)image {
    
    NSDictionary *imageOptions = @{
                                   CIDetectorImageOrientation : @(5),
                                   
                                   };
    
    CIImage *cImage = [CIImage imageWithCGImage:image.CGImage];
    NSDictionary *options = @{
                           CIDetectorAccuracy:CIDetectorAccuracyHigh,
             
                           };
    
    CIDetector *faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:options];
    NSArray *features = [faceDetector featuresInImage:cImage options:imageOptions];
    return features;
}



@end
