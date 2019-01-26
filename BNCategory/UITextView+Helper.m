//
//  UITextView+Helper.m
//  BNCategory
//
//  Created by BIN on 2018/11/26.
//

#import "UITextView+Helper.h"
#import <objc/runtime.h>
#import "NSObject+swizzling.h"

@implementation UITextView (Helper)

+(void)initialize{
    if (self == self.class) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            SwizzleMethodInstance(@"UITextView",  NSSelectorFromString(@"dealloc"), @selector(swz_Dealloc));

        });
    }
}

- (void)swz_Dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
    [self swz_Dealloc];
    
}

#pragma mark - - 属性

- (UITextView *)placeHolderTextView {
    UITextView* textView = objc_getAssociatedObject(self, _cmd);
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
    NSLog(@"_%@_%@_%@_",self,self.text,@(self.text.length));
    if ([self.text isEqualToString:@""] || self.text.length == 0) {
        self.placeHolderTextView.hidden = NO;
    }
}

@end

