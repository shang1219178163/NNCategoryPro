//
//  UIImage+Helper.h
//  
//
//  Created by BIN on 2017/7/31.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Helper)

@property (nonatomic, strong, readonly) NSString *contentType;

/**
 通过图片Data数据第一个字节 来获取图片扩展名
 */
+ (NSString *)contentTypeForImageData:(NSData *)data;

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)screenshotFromView:(UIView *)view;
- (UIImage *)croppedImage:(CGRect)cropRect;

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

- (UIImage *)normalizedImage;

- (UIImage *)fixOrientation;

- (UIImage *)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size;

/**
 
 区别:
 效果:第一种Core Image设置模糊之后会在周围产生白边，vImage使用不存在任何问题；
 性能:图像模糊处理属于复杂的计算，大部分图片模糊选择的是vImage，性能最佳
 
 Core Image是苹果提供的一个相当强大专门用于处理图片的库。稍微试了一下，不仅能实现毛玻璃效果，还能实现很多其他的效果。但是，在使用过程中发现使用Core Image来实现这些效果，非常占用内存。查看文档:createCGImage:outputImage : fromRect:方法会单独开辟一个临时的缓存区，出现离屏渲染，这可能是一个使得内存增大的重要原因。
 
 *  CoreImage图片高斯模糊
 *  @param blur  模糊数值(默认是10)
 *
 *  @return 重新绘制的新图片
 */

-(UIImage *)coreBlurNumber:(CGFloat)blur;

/**
 *  vImage模糊图片(推荐)
 *
 *  @param blur  模糊数值(0-1)
 *
 *  @return 重新绘制的新图片
 */
-(UIImage *)boxBlurNumber:(CGFloat)blur;

- (BOOL)isEquelImage:(id)image;

-(UIColor *)mostColor;

//获取图像某一点的颜色
- (UIColor *)colorAtPixel:(CGPoint)point;

#pragma mark - -压缩图片

//1.自动缩放到指定大小
- (UIImage *)thumbnailToFileSize:(CGSize)asize;

//2.保持原来的长宽比，生成一个缩略图
- (UIImage *)thumbnailWithoutScaleToFileSize:(CGSize)asize;

// 调整图片分辨率/尺寸（等比例缩放）
- (UIImage *)newSizeImage:(CGSize)size;

//递归缩小压缩系数,返回压缩后imageData
- (NSData *)compressToFileSize:(NSInteger)fileSize;
/**
 UIImage压缩

 @param fileSize 最大文件尺寸
 @param type 0:NSData,1:UIImage,1:图片二进制数据的base64编码
 @return 根据type返回对应对应类型
 */
- (id)compressToFileSize:(NSInteger)fileSize type:(NSNumber *)type;

/**
 保证图片清晰度,先压缩图片质量。如果要使图片一定小于指定大小，压缩图片尺寸可以满足。对于后一种需求，还可以先压缩图片质量，如果已经小于指定大小，就可得到清晰的图片，否则再压缩图片尺寸。

 @param maxLength 文件大小
 @return uiimage
 */
- (UIImage *)compressImageToByte:(NSUInteger)maxLength;
- (id)compressToByte:(NSUInteger)maxLength type:(NSNumber *)type;

@end
