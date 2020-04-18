//
//  UITextView+Helper.m
//  NNCategory
//
//  Created by BIN on 2018/11/26.
//

#import "UITextView+Helper.h"
#import <objc/runtime.h>
#import "NSObject+Hook.h"
#import "UIColor+Helper.h"
#import "NSAttributedString+Helper.h"

@implementation UITextView (Helper)

+(void)initialize{
    if (self == self.class) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            SwizzleMethodInstance(self.class,  NSSelectorFromString(@"dealloc"), @selector(swz_Dealloc));

        });
    }
}

- (void)swz_Dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
    [self swz_Dealloc];
}

#pragma mark - - 属性

- (UITextView *)placeHolderTextView {
    UITextView *textView = objc_getAssociatedObject(self, _cmd);
    if (!textView) {
        textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.font = self.font;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor grayColor];
        textView.userInteractionEnabled = NO;
        [self addSubview:textView];
        
        objc_setAssociatedObject(self, _cmd, textView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(textViewDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(textViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
         [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(textViewDidEndEditing:) name:UITextViewTextDidChangeNotification object:self];
    }
    return textView;
}

- (void)setPlaceHolderTextView:(UITextView *)placeHolderTextView{
    objc_setAssociatedObject(self, @selector(placeHolderTextView), placeHolderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

# pragma mark -funtions
- (void)textViewDidBeginEditing:(NSNotification *)noti {
    self.placeHolderTextView.hidden = YES;
}

- (void)textViewDidEndEditing:(NSNotification *)noti {
//    NSLog(@"_%@_%@_%@_",self,self.text,@(self.text.length));
    if ([self.text isEqualToString:@""] || self.text.length == 0) {
        self.placeHolderTextView.hidden = NO;
    }
}

/**
 [源]UITextView创建
 */
+ (instancetype)createRect:(CGRect)rect{    
    UITextView *textView = [[self alloc] initWithFrame:rect];
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    textView.font = [UIFont systemFontOfSize:15];
    textView.textAlignment = NSTextAlignmentLeft;
    
    textView.keyboardAppearance = UIKeyboardAppearanceDefault;
    textView.keyboardType = UIReturnKeyDefault;
    
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    textView.layer.borderWidth = 0.5;
    textView.layer.borderColor = UIColor.lineColor.CGColor;
    [textView scrollRectToVisible:rect animated:YES];
    //    textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    //    textView.backgroundColor = UIColor.whiteColor;
    //    textView.backgroundColor = UIColor.clearColor;
    
    return textView;
}

+ (instancetype)createRect:(CGRect)rect placeholder:(NSString *)placeholder{
    UITextView *textView = [self createRect:rect];
    textView.placeHolderTextView.text = placeholder;
    textView.placeHolderTextView.textColor = UIColor.titleSubColor;
    return textView;
}

/**
 不可编辑UITextView创建
 */
+ (instancetype)createTextShowRect:(CGRect)rect{
    UITextView *textView = [self createRect:rect];
    
    textView.contentOffset = CGPointMake(0, 8);//textView文本显示区域距离顶部为8像素
    textView.editable = NO;
    textView.dataDetectorTypes = UIDataDetectorTypeAll;
    //    textView.layer.borderWidth = 0.5;
    //    textView.layer.borderColor = UIColor.redColor.CGColor;
    
    return textView;
}

- (void)setHyperlinkDic:(NSDictionary *)dic{
    // both are needed, otherwise hyperlink won't accept mousedown
    UITextView *textView = self;
    NSDictionary *attributes = @{
                                  NSFontAttributeName: textView.font,
                                  };
    
    __block NSMutableAttributedString *mattStr = [[NSMutableAttributedString alloc]initWithString:textView.text attributes:attributes];
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString * key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSURL *url = [NSURL URLWithString:obj];
        NSAttributedString * attStr = [NSAttributedString hyperlinkFromString:key withURL:url font:textView.font];
        NSRange range = [mattStr.string rangeOfString:key];
        [mattStr replaceCharactersInRange:range withAttributedString:attStr];
        
    }];
    
    textView.attributedText = mattStr;
    textView.selectable = true;
    textView.editable = false;
    textView.dataDetectorTypes = UIDataDetectorTypeLink;
}

@end

