//
//  UIView+Helper.m
//  HuiZhuBang
//
//  Created by BIN on 2017/8/15.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "UIView+Helper.h"
#import <objc/runtime.h>

#import "BN_Globle.h"

#import "NSObject+Helper.h"
#import "NSBundle+Helper.h"

#import "BN_TextField.h"
#import "BN_TextView.h"

@implementation UIView (Helper)

-(CGFloat)x{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

-(CGFloat)width{
    return self.frame.size.width;
}

-(void)setWidth:(CGFloat)width{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

-(CGFloat)height{
    return self.frame.size.height;
}

-(void)setHeight:(CGFloat)height{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

-(CGFloat)w{
    return self.frame.size.width;
}

-(void)setW:(CGFloat)w{
    CGRect rect = self.frame;
    rect.size.width = w;
    self.frame = rect;
}

-(CGFloat)h{
    return self.frame.size.height;
}

-(void)setH:(CGFloat)h{
    CGRect rect = self.frame;
    rect.size.height = h;
    self.frame = rect;
}

- (CGPoint)origin{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect rect = self.frame;
    rect.origin = origin;
    self.frame = rect;
}

-(CGSize)size{
    return self.frame.size;
}

- (void)setSize:(CGSize)size{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}

-(CGFloat)top{
    return self.frame.origin.y;
}

-(CGFloat)left{
    return self.frame.origin.x;
    
}

- (CGFloat)bottom{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)right{
    return self.frame.origin.x + self.frame.size.width;
}

-(BlockView)blockView{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setBlockView:(BlockView)blockView{
    objc_setAssociatedObject(self, @selector(blockView), blockView, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

-(BOOL)selected{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
    
}

-(void)setSelected:(BOOL)selected{
    objc_setAssociatedObject(self, @selector(selected), @(selected), OBJC_ASSOCIATION_ASSIGN);
    
}

-(UIViewController *)parController{
    id responder = self;
    while (responder){
        if ([responder isKindOfClass:[UIViewController class]]){
            return responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

#pragma mak - -绘制

#pragma mark - 设置部分圆角

- (UIView *)addCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii width:(CGFloat)width color:(UIColor *)color{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:cornerRadii];
    // 创建遮罩层
    CAShapeLayer *maskLayer = CAShapeLayer.layer;
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;   // 轨迹
    maskLayer.borderWidth = width;
    maskLayer.borderColor = color.CGColor;
    self.layer.mask = maskLayer;
    
    return self;
}

- (UIView *)addCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii{
    return [self addCorners:corners cornerRadii:cornerRadii width:1.0 color:UIColor.whiteColor];
}

- (UIView *)addCorners:(UIRectCorner)corners width:(CGFloat)width color:(UIColor *)color{
    CGSize cornerRadii = CGSizeMake(CGRectGetWidth(self.bounds)*0.5, CGRectGetWidth(self.bounds)*0.5);
    return [self addCorners:UIRectCornerAllCorners cornerRadii:cornerRadii width:width color:color];
}

- (UIView *)addCornersAll{
    CGSize cornerRadii = CGSizeMake(CGRectGetWidth(self.bounds)*0.5, CGRectGetWidth(self.bounds)*0.5);
    return [self addCorners:UIRectCornerAllCorners cornerRadii:cornerRadii width:1.0 color:UIColor.whiteColor];
}

#pragma mak - -

- (UIView *)addRecognizerWithTarget:(id)target
                          aSelector:(SEL)aSelector
                               type:(NSNumber *)type{
    self.userInteractionEnabled = YES;

    switch (type.integerValue) {
        case 0:
        {
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:target action:aSelector];
            recognizer.numberOfTapsRequired = 1;
            recognizer.numberOfTouchesRequired = 1;
            
            recognizer.cancelsTouchesInView = NO;
            recognizer.delaysTouchesEnded = NO;
            [self addGestureRecognizer:recognizer];
            return self;
        }
            break;
        case 1:
        {
            UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:target action:aSelector];
            recognizer.numberOfTapsRequired = 1;
            recognizer.numberOfTouchesRequired = 1;
            
            recognizer.minimumPressDuration = 1.5;
            [self addGestureRecognizer:recognizer];
            
            //aSelector需做判断if(recognizer.state == UIGestureRecognizerStateBegan)
            return self;
        }
            break;
        case 2:
        {
            // 如果以后想要一个控件支持多个方向的轻扫，必须创建多个轻扫手势，一个轻扫手势只支持一个方向
            UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:aSelector];
            swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
            [self addGestureRecognizer:swipeLeft];
            
            UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:aSelector];
            swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
            [self addGestureRecognizer:swipeRight];
            return self;
        }
            break;
        default:
        {
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:target action:aSelector];
            recognizer.numberOfTapsRequired = 1;
            recognizer.numberOfTouchesRequired = 1;
            
            recognizer.cancelsTouchesInView = NO;
            recognizer.delaysTouchesEnded = NO;
            [self addGestureRecognizer:recognizer];
            return self;
        }
            break;
    }
    return self;
}


/**
 关联方法待改进
 */
- (void)addActionHandler:(void(^)(id obj, id item, NSInteger idx))handler{

    if ([self isKindOfClass:[UIButton class]]) {
        [(UIButton *)self addTarget:self action:@selector(handleActionBtn:) forControlEvents:UIControlEventTouchUpInside];

    }
    else if ([self isKindOfClass:[UIControl class]]) {
        [(UIControl *)self addTarget:self action:@selector(handleActionBtn:) forControlEvents:UIControlEventValueChanged];
        
    }
    else{
        UITapGestureRecognizer *tapGesture = objc_getAssociatedObject(self, _cmd);
        if (!tapGesture){
            tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionTapGesture:)];
            tapGesture.numberOfTapsRequired = 1;
            tapGesture.numberOfTouchesRequired = 1;
            
//            tapGesture.cancelsTouchesInView = NO;
//            tapGesture.delaysTouchesEnded = NO;
            
            self.userInteractionEnabled = YES;
            [self addGestureRecognizer:tapGesture];
        }
    }
    objc_setAssociatedObject(self, _cmd, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
/**
 关联方法待改进
 */
- (void)handleActionBtn:(id)sender{
    void(^block)(id obj, id item, NSInteger idx) = objc_getAssociatedObject(self, @selector(addActionHandler:));

    if ([sender isKindOfClass:[UISegmentedControl class]]) {
        UISegmentedControl * segmentCtl = sender;
        if (block) block(sender, sender, segmentCtl.selectedSegmentIndex);
    }
    else{
        if (block) block(sender, sender, ((UIButton *)sender).tag);
    }
}

/**
 关联方法待改进
 */
- (void)handleActionTapGesture:(UITapGestureRecognizer *)tapGesture{
    void(^block)(id obj, id item, NSInteger idx) = objc_getAssociatedObject(self, @selector(addActionHandler:));
    if (block){
        block(tapGesture, tapGesture.view, tapGesture.view.tag);

    }
}


//寻找特定控件
+ (id)getControl:(NSString *)control view:(UIView *)view{
    
    for (id subview in view.subviews) {
        if ([subview isKindOfClass:[NSClassFromString(control) class]]) {
            return subview;
        }
        [self getControl:control view:subview];
    }
    return nil;
}

// 获取所有子视图(需要注意的是，我的level设置是从1开始的，这与方法中加空格时变量 i 起始的值是相呼应的，要改就要都改。)
+ (void)getSub:(UIView *)view andLevel:(NSInteger)level {
    NSArray *subviews = [view subviews];
    if ([subviews count] == 0) return;
    for (UIView *subview in subviews) {
        
        NSString *blank = @"";
        for (NSInteger i = 1; i < level; i++) {
            blank = [NSString stringWithFormat:@"  %@", blank];
        }
        NSLog(@"%@%ld: %@", blank, (long)level, subview.class);
        [self getSub:subview andLevel:(level+1)];
        
    }
}

//给所有子视图加框
- (void)getViewLayer{
    NSArray *subviews = [self subviews];
    if ([subviews count] == 0) return;
    for (UIView *subview in subviews) {
        subview.layer.borderWidth = kW_LayerBorder;
        subview.layer.borderColor = UIColor.blueColor.CGColor;
        subview.layer.borderColor = UIColor.clearColor.CGColor;

        [subview getViewLayer];
        
    }
}

- (void)showLayerColor:(UIColor *)layerColor{
    self.layer.borderWidth = kW_LayerBorder;
    self.layer.borderColor = layerColor.CGColor;
    
    self.layer.masksToBounds = YES;
    
    CGFloat cornerRadius = 5.0;
    CGFloat max = CGRectGetWidth(self.frame) >= CGRectGetHeight(self.frame) ? CGRectGetWidth(self.frame): CGRectGetHeight(self.frame);
    if (max/10.0 <= 3.0) {
        cornerRadius = 3.0;
        
    }
    else if (max/10.0 >= 5.0) {
        cornerRadius = 5.0;
        
    }else{
        cornerRadius = max/10.0;
        
    }
    self.layer.cornerRadius = cornerRadius;
}

+ (UIImageView *)createCardViewWithRect:(CGRect)rect title:(NSString *)title image:(id)image tag:(NSInteger)tag target:(id)target aSelector:(SEL)aSelector{
    
    UIImageView * containView = [UIView createImageViewRect:rect image:image tag:tag target:target aSelector:aSelector];
    
    CGSize imgViewSize = CGSizeMake(kH_LABEL_SMALL, kH_LABEL_SMALL);
    CGFloat YGap = (CGRectGetHeight(rect) - imgViewSize.height*2)/2.0;
    CGFloat XGapImgView = (CGRectGetWidth(rect) - imgViewSize.width)/2.0;
    
    CGRect imgViewRect = CGRectMake(XGapImgView, YGap, imgViewSize.width, imgViewSize.height);
    UIImageView * imgView = [UIView createImgViewWithRect:imgViewRect image:@"img_cardAdd.png" tag:kTAG_IMGVIEW type:@0];
    imgView.layer.backgroundColor = UIColor.whiteColor.CGColor;
    [containView addSubview:imgView];
    
    CGSize textSize = [self sizeWithText:title font:@(kFZ_Third) width:CGRectGetWidth(rect)];
    CGFloat XGapLab = (CGRectGetWidth(rect) - textSize.width)/2.0;
    
    CGRect labRect = CGRectMake(XGapLab, CGRectGetMaxY(imgViewRect), textSize.width, kH_LABEL_SMALL);
    UILabel * lab = [UIView createLabelWithRect:labRect text:title textColor:kC_TextColor_TitleSub tag:kTAG_LABEL type:@2 font:kFZ_Third backgroudColor:nil alignment:NSTextAlignmentCenter];
    [containView addSubview:lab];
    
    if (image == nil) {
        imgView.hidden = NO;
        lab.hidden = NO;
        
    }else{
        imgView.hidden = YES;
        lab.hidden = YES;
        
    }
    
    return containView;
    
}


+ (BN_TextField *)createTextFieldWithRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder font:(NSInteger)fontSize textAlignment:(NSTextAlignment)textAlignment keyboardType:(UIKeyboardType)keyboardType
{
    BN_TextField * textField = [[BN_TextField alloc]initWithFrame:rect];
    
    textField.text = text;
    textField.placeholder = placeholder;
    textField.font = [UIFont systemFontOfSize:fontSize];
    textField.textAlignment = textAlignment;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    textField.keyboardAppearance = UIKeyboardAppearanceDefault;
    textField.keyboardType = keyboardType;
    
    //        textField.returnKeyType = UIReturnKeyDone;
    //        textField.clearButtonMode = UITextFieldViewModeAlways;
    
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;//清楚键
    //        textField.layer.borderWidth = 0.5;  // 给图层添加一个有色边框
    //        textField.layer.borderColor = [UtilityHelper colorWithHexString:@"d2d2d2"].CGColor;
    textField.backgroundColor = UIColor.whiteColor;
    //    textField.backgroundColor = UIColor.clearColor;
    
    return textField;
    
}

+ (BN_TextField *)createTextFieldWithRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder font:(NSInteger)fontSize textAlignment:(NSTextAlignment)textAlignment keyboardType:(UIKeyboardType)keyboardType leftView:(UIView *)leftView leftPadding:(CGFloat)leftPadding rightView:(UIView *)rightView rightPadding:(CGFloat)rightPadding{
    BN_TextField * textField = [BN_TextField createTextFieldWithRect:rect text:text placeholder:placeholder font:fontSize textAlignment:NSTextAlignmentLeft keyboardType:keyboardType];
    textField.textAlignment = textAlignment;
    
    //    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_cardAdd.png"]];
    //    imgView.frame = CGRectMake(0, 0, 21, 21);
    textField.leftView = leftView;
//    textField.leftViewPadding = 5;
    textField.leftViewPadding = leftPadding;

    textField.leftViewMode = UITextFieldViewModeAlways;
    
    //    UIButton * btn = [UIButton createBtnWithRect:CGRectMake(0, 0, 40, textFieldHeight) title:@"搜 索" font:kFZ_Second image:nil tag:kTAG_BTN type:@2 target:self aSelector:@selector(goSearch)];
    textField.rightView = rightView;
//    textField.rightViewPadding = 5;
    textField.rightViewPadding = rightPadding;
    textField.rightViewMode = UITextFieldViewModeAlways;
    
    textField.keyboardType = keyboardType;
    textField.returnKeyType = UIReturnKeyDone;
    textField.backgroundColor = [UIColor whiteColor];
//    textField.backgroundColor = UIColor.greenColor;

    return textField;
}

+ (BN_TextView *)createTextViewWithRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder font:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment keyType:(UIKeyboardType)keyboardType{
    
    BN_TextView *textView = [[BN_TextView alloc] initWithFrame:rect];
    
    textView.text = text;
    textView.placeholder = placeholder;
    textView.placeholderColor = kC_TextColor_TitleSub;

    textView.font = [UIFont systemFontOfSize:fontSize];
    textView.textAlignment = NSTextAlignmentLeft;
    
    textView.keyboardAppearance = UIKeyboardAppearanceDefault;
    textView.keyboardType = keyboardType;
    
    //    textView.returnKeyType = UIReturnKeyDone;
    
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    textView.layer.borderWidth = 0.5;
    textView.layer.borderColor = UIColor.lineColor.CGColor;
    
    [textView scrollRectToVisible:rect animated:YES];
    //    textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
//    textView.backgroundColor = [UIColor whiteColor];
//    textView.backgroundColor = UIColor.clearColor;
    
    return textView;
}

+ (UITextView *)createTextShowWithRect:(CGRect)rect text:(id)text font:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment
{
    UITextView *textView = [[UITextView alloc] initWithFrame:rect];
    if ([text isKindOfClass:[NSString class]]) {
        textView.text = text;

    }
    else if([text isKindOfClass:[NSAttributedString class]]){
        textView.attributedText = text;

    }
    textView.contentOffset = CGPointMake(0, 8);//textView文本显示区域距离顶部为8像素

    
    textView.font = [UIFont systemFontOfSize:fontSize];
    textView.textAlignment = NSTextAlignmentLeft;
    
    textView.keyboardAppearance = UIKeyboardAppearanceDefault;
    //    textView.returnKeyType = UIReturnKeyDone;
    
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    [textView scrollRectToVisible:rect animated:YES];
    //    textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    textView.editable = NO;
    textView.dataDetectorTypes = UIDataDetectorTypeAll;
    
//    textView.layer.borderWidth = 0.5;
//    textView.layer.borderColor = UIColor.redColor.CGColor;

    return textView;
}

+ (UILabel *)createRichLabWithRect:(CGRect)rect text:(NSString *)text textTaps:(NSArray *)textTaps{
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:text];
    for (NSString *textTap in textTaps) {
        [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kFZ_Third] range:NSMakeRange(0, text.length)];
        [attString addAttribute:NSForegroundColorAttributeName value:UIColor.orangeColor range:[text rangeOfString:textTap]];
        
    }
    UILabel *ybLabel = [[UILabel alloc] initWithFrame:rect];
    ybLabel.textColor = kC_TextColor_Title;
    ybLabel.backgroundColor = [UIColor whiteColor];
    ybLabel.numberOfLines = 1;
    
    ybLabel.attributedText = attString;
    ybLabel.textAlignment = NSTextAlignmentCenter;
//    ybLabel.enabledTapEffect = NO;
    
    return ybLabel;
    
}

//图片+文字
+ (UIView *)getImgLabViewRect:(CGRect)rect image:(id)image text:(id)text imgViewSize:(CGSize)imgViewSize tag:(NSInteger)tag{
    UIView * backgroudView = [[UIView alloc]initWithFrame:rect];
    backgroudView.tag = tag;
    
    CGFloat padding = kPadding;
    CGRect imgViewRect = CGRectMake(0, 0, imgViewSize.width, imgViewSize.height);
    
    if (imgViewSize.height > CGRectGetHeight(rect)) {
        CGRect rect = backgroudView.frame;
        rect.size.height = imgViewSize.height;
        backgroudView.frame = rect;
        
    }else{
        CGFloat XYGap = (CGRectGetHeight(backgroudView.frame) - imgViewSize.height)/2.0;
        imgViewRect = CGRectMake(XYGap, XYGap, imgViewSize.width, imgViewSize.height);
        
    }
    
    CGRect labelRect = CGRectMake(CGRectGetMaxX(imgViewRect) + padding, CGRectGetMinY(imgViewRect), CGRectGetWidth(backgroudView.frame) - CGRectGetWidth(imgViewRect) - padding, CGRectGetHeight(imgViewRect));
    
    UIImageView * imgView = [UIView createImgViewWithRect:imgViewRect image:image tag:kTAG_IMGVIEW type:@0];
    imgView.tag = kTAG_IMGVIEW;
    [backgroudView addSubview:imgView];
    
    UILabel * labelVehicle = [UIView createLabelWithRect:labelRect text:text textColor:nil tag:kTAG_LABEL type:@2 font:kFZ_Third backgroudColor:nil alignment:NSTextAlignmentLeft];
    labelVehicle.tag = kTAG_LABEL;
    [backgroudView addSubview:labelVehicle];
    
//    backgroudView.layer.borderColor = UIColor.whiteColor.CGColor;
//    backgroudView.layer.borderWidth = 0.5;
    
    return backgroudView;
}

+ (UIView *)createViewWithRect:(CGRect)rect elements:(NSArray *)elements numberOfRow:(NSInteger)numberOfRow viewHeight:(CGFloat)viewHeight padding:(CGFloat)padding{
    
    //    CGFloat padding = 15;
    //    CGFloat viewHeight = 30;
    //    NSInteger numberOfRow = 4;
    NSInteger rowCount = elements.count % numberOfRow == 0 ? elements.count/numberOfRow : elements.count/numberOfRow + 1;
    //
    UIView * backgroudView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetWidth(rect), rowCount * viewHeight + (rowCount - 1) * padding)];
    backgroudView.backgroundColor = UIColor.greenColor;
    
    CGSize viewSize = CGSizeMake((CGRectGetWidth(backgroudView.frame) - (numberOfRow-1)*padding)/numberOfRow, viewHeight);
    for (NSInteger i = 0; i< elements.count; i++) {
        
        CGFloat w = viewSize.width;
        CGFloat h = viewSize.height;
        CGFloat x = (w + padding) * (i % numberOfRow);
        CGFloat y = (h + padding) * (i / numberOfRow);
        
        NSString * title = elements[i];
        CGRect btnRect = CGRectMake(x, y, w, h);
        UIButton * btn = [UIView createBtnWithRect:btnRect title:title font:15 image:nil tag:kTAG_BTN+i type:@0 target:self aSelector:@selector(handleActionBtn:)];
        [btn removeTarget:self action:@selector(handleActionBtn:) forControlEvents:UIControlEventTouchUpInside];
        [backgroudView addSubview:btn];
        
    }
    return backgroudView;
}


+ (UIView *)createViewWithRect:(CGRect)rect items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding type:(NSNumber *)type handler:(void(^)(id obj, id item, NSInteger idx))handler{
    
    //    CGFloat padding = 15;
    //    CGFloat viewHeight = 30;
    //    NSInteger numberOfRow = 4;
    NSInteger rowCount = items.count % numberOfRow == 0 ? items.count/numberOfRow : items.count/numberOfRow + 1;
    CGFloat itemWidth = (CGRectGetWidth(rect) - (numberOfRow-1)*padding)/numberOfRow;
    itemHeight = itemHeight == 0.0 ? itemWidth : itemHeight;;
    
    //
    UIView * backgroudView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetWidth(rect), rowCount * itemHeight + (rowCount - 1) * padding)];
    backgroudView.backgroundColor = UIColor.greenColor;
    
    for (NSInteger i = 0; i< items.count; i++) {
        
        CGFloat w = itemWidth;
        CGFloat h = itemHeight;
        CGFloat x = (i % numberOfRow) * (w + padding);
        CGFloat y = (i / numberOfRow) * (h + padding);
        
        NSString * title = items[i];
        CGRect itemRect = CGRectMake(x, y, w, h);
        
        UIView * view = nil;
        switch (type.integerValue ) {
            case 0://uibutton
            {
                view = [UIView createBtnWithRect:itemRect title:title font:15 image:nil tag:i type:@5 target:nil aSelector:nil];
            }
                break;
            case 1://UIImageVIew
            {
                view = [UIView createImgViewWithRect:itemRect image:title tag:i type:@0];
                
            }
                break;
            case 2://UILabel
            {
                view = [UIView createLabelWithRect:itemRect text:title textColor:nil tag:i type:@0 font:15 backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
                
            }
                break;
            default:
                break;
        }
        [backgroudView addSubview:view];
        [view addActionHandler:^(id obj, id item, NSInteger idx) {
            handler(obj, item, idx);
            
        }];
        
    }
    return backgroudView;
}


//+ (BN_AlertViewZero *)creatAlertViewTitle:(NSString *)title array:(NSArray *)array dict:(NSDictionary *)dict mustList:(NSArray *)mustList btnTitles:(NSArray *)btnTitles{
//    
//    NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];
//    for (NSInteger i = 0; i < array.count; i++) {
//        ElementModel *model = [[ElementModel alloc]init];
//        
//        if ([mustList containsObject:@(i)]) {
//            model.isMust = YES;
//        }
//        
//        NSString * title = array[i];
//        NSString * starString = @"*";
//        model.title = [self getAttringByPrefix:starString content:title isMust:model.isMust];
////        model.content = array[i];
//        model.placeHolder = dict[title];
//        
//        [marr addObject:model];
//    }
//    
//    BN_AlertViewZero * alertView = [BN_AlertViewZero alertViewWithTitle:title items:marr btnTitles:btnTitles];
//    return alertView;
//    
//}

//向屏幕倾斜
+ (void)transformStateEventWithView:(UIView *)view {
    
    // 初始化3D变换,获取默认值
    CATransform3D perspectiveTransform = CATransform3DIdentity;
    // 透视
    perspectiveTransform.m34 = -1.0/500.0;
    
    // 位移
    //    perspectiveTransform = CATransform3DTranslate(perspectiveTransform, 30, -35, 0);
    // 空间旋转
    //    perspectiveTransform = CATransform3DRotate(perspectiveTransform, [Math radianFromDegree:30], 0.75, 1, -0.5);
    perspectiveTransform = CATransform3DRotate(perspectiveTransform, (10) * M_PI / 180.f, -1, 0, 0);
    
    // 缩放变换
    //    perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
    
    view.layer.transform              = perspectiveTransform;
    view.layer.allowsEdgeAntialiasing = YES; // 抗锯齿
    //    view.layer.speed                  = 0.5;
    
    view.layer.shadowOffset = CGSizeMake(0, 5);
    view.layer.shadowColor = UIColor.blackColor.CGColor;
    view.layer.shadowOpacity = 1;//阴影透明度，默认0
    view.layer.shadowRadius = 2;//阴影半径，默认3
}

#pragma make - -圆角
//通过Graphics 和 BezierPath 设置圆角
+ (void)setCutCirculayWithView:(UIImageView *)view cornerRadius:(CGFloat)cornerRadius type:(NSNumber *)type{
    switch (type.integerValue) {
        case 0:
        {
            //通过Graphics 和 BezierPath 设置圆角
            UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, UIScreen.mainScreen.scale);
            [[UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:cornerRadius] addClip];
            [view drawRect:view.bounds];
            
            view.image = UIGraphicsGetImageFromCurrentImageContext();
            // 结束
            UIGraphicsEndImageContext();

        }
            break;
        case 1:
        {
            // 创建BezierPath 并设置角 和 半径 这里只设置了 左上 和 右上
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
            CAShapeLayer *layer = CAShapeLayer.layer;
            layer.frame = view.bounds;
            layer.path = path.CGPath;
            view.layer.mask = layer;
        }
            break;
        case 2:
        {
            
        }
            break;
        default:
            break;
    }
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    CGPoint point = [touch locationInView:self];
//    __weak typeof(self) weakSelf = self;
//    [self tapView:<#(UIView *)#> tapClick:^(UIView *View) {
//        
//        if (weakSelf.tapBlock) {
//            weakSelf.tapBlock (view);
//        }
//        
//    }];
//    
//}


+ (UIVisualEffectView *)createBlurViewEffect:(UIBlurEffectStyle)effect subView:(UIView *)view{
    
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    if (effect) {
        blur = [UIBlurEffect effectWithStyle:effect];
        
    }
//    UIVibrancyEffect *vibrancy = [UIVibrancyEffect effectForBlurEffect:blur];

    UIVisualEffectView * visualView = [[UIVisualEffectView alloc]initWithEffect:blur];
    
    visualView.frame = view.bounds;
    
    visualView.layer.masksToBounds = YES;
    visualView.layer.cornerRadius = CGRectGetHeight(visualView.frame);
    
    
    //把要添加的视图加到毛玻璃上
    [visualView.contentView addSubview:view];
    
    return visualView;
}

- (void)addCircleLayerColor:(UIColor *)layColor layerWidth:(CGFloat)layerWidth{
    
    CGPoint center = self.center;
    //半径
    CGFloat radius = sqrt(pow(CGRectGetWidth(self.frame), 2) + pow(CGRectGetHeight(self.frame), 2))/2.0 + layerWidth*2;
    
    //创建贝塞尔路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:(-0.5f*M_PI) endAngle:1.5f*M_PI clockwise:YES];
    //添加背景圆环
    CAShapeLayer *layer = CAShapeLayer.layer;
    layer.frame = self.bounds;
    layer.fillColor =  UIColor.clearColor.CGColor;
    layer.strokeColor = UIColor.themeColor.CGColor;
    layer.lineWidth = layerWidth;
    layer.path = path.CGPath;
    layer.strokeEnd = 1;
    [[self superview].layer addSublayer:layer];
    
}

- (void)removeAllSubViews{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
        
    }];
    
}

- (NSIndexPath *)getCellIndexPathByTableView:(UITableView *)tableView{
    UITableViewCell * cell = [self getClickViewCell];
    NSIndexPath * indexPath = [tableView indexPathForRowAtPoint:cell.center];
    //    DDLog(@"%@",indexPath);
    return indexPath;
}

- (UITableViewCell *)getClickViewCell{
    UIView * view = self;
    UIView * supView = [view superview];
    while (![supView isKindOfClass:[UITableViewCell class]]) {
        
        supView = [supView superview];
    }
    UITableViewCell * tableViewCell = (UITableViewCell *)supView;
    return tableViewCell;
}

- (id)asoryView:(NSString *)unitString{
    //    NSArray * unitList = @[@"元",@"公斤"];
    NSParameterAssert([self isKindOfClass:[UITextField class]]);
    NSParameterAssert(unitString != nil && ![unitString isEqualToString:@""]);
    
    if ([unitString containsString:@".png"]) {
        CGSize size = CGSizeMake(20, 20);
        UIImageView * imgView = [UIView createImgViewWithRect:CGRectMake(0, 0, size.width, size.height) image:unitString tag:kTAG_IMGVIEW type:@0];
        imgView.image = UIImageFromParams(unitString,self.class,@"BN_Globle");
        return imgView;
    }
    
    CGSize size = [self sizeWithText:unitString font:@(kFZ_Third) width:UIScreen.width];
    UILabel * label = [UIView createLabelWithRect:CGRectMake(0, 0, size.width+2, 25) text:unitString textColor:kC_TextColor_Title tag:kTAG_LABEL type:@2 font:kFZ_Third backgroudColor:UIColor.clearColor alignment:NSTextAlignmentCenter];
    return label;
    
}

////信任值展示,无点击手势
//+ (id)getStarViewRect:(CGRect)rect rateStyle:(NSString *)rateStyle currentScore:(CGFloat)currentScore{
//    //默认五颗星星
//    BN_StarRateView *starRateView = [[BN_StarRateView alloc] initWithFrame:rect];
//    switch ([rateStyle integerValue]) {
//        case 0:
//        {
//            starRateView.rateStyle = WholeStar;
//
//        }
//            break;
//        case 1:
//        {
//            starRateView.rateStyle = HalfStar;
//
//        }
//            break;
//        case 2:
//        {
//            starRateView.rateStyle = IncompleteStar;
//
//        }
//            break;
//        default:
//            break;
//    }
//
//    starRateView.currentScore = currentScore/100.0 * 5;
//    starRateView.backgroundColor = UIColor.clearColor;
//    starRateView.userInteractionEnabled = NO;
//
//    return starRateView;
//}




@end
