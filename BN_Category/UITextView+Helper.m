//
//  UITextView+Helper.m
//  BN_Category
//
//  Created by BIN on 2018/11/26.
//

#import "UITextView+Helper.h"
#import <objc/runtime.h>

@implementation UITextView (Helper)

- (UITextView *)placeHolderTextView {
//    return objc_getAssociatedObject(self, _cmd);
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

- (void)setPlaceHolderTextView:(UITextView *)placeHolderTextView {
    objc_setAssociatedObject(self, @selector(placeHolderTextView), placeHolderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


# pragma mark -
# pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(NSNotification *)noti {
    self.placeHolderTextView.hidden = YES;
}
- (void)textViewDidEndEditing:(UITextView *)noti {
    if (self.text && [self.text isEqualToString:@""]) {
        self.placeHolderTextView.hidden = NO;
    }
}

+(void)initialize{
    [super initialize];
    
    Method origMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method newMethod = class_getInstanceMethod([self class], @selector(textView_placeholder_swizzledDealloc));
    method_exchangeImplementations(origMethod, newMethod);
}

//+ (void)load {
//    [super load];
//    Method origMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
//    Method newMethod = class_getInstanceMethod([self class], @selector(textView_placeholder_swizzledDealloc));
//    method_exchangeImplementations(origMethod, newMethod);
//}
- (void)textView_placeholder_swizzledDealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
    [self textView_placeholder_swizzledDealloc];
}


@end

