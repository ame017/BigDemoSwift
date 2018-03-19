//
//  UITextView+STAutoHeight.h
//  AUtoLayoutTest
//
//  Created by StriVever on 2017/12/26.
//  Copyright © 2017年 StriVever. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const st_layout_frame = @"st_layout_frame";
static NSString * const st_auto_layout = @"st_auto_layout";
IB_DESIGNABLE
@interface UITextView (STAutoHeight)

/**
 是否自适应高度
 */

@property (nonatomic, assign)IBInspectable BOOL isAutoHeightEnable;

/**
 设置最大高度
 */
@property (nonatomic, assign)IBInspectable CGFloat st_maxHeight;

/**
 最小高度
 */
@property (nonatomic, assign) CGFloat st_minHeight;

/**
 占位符
 */
@property (nonatomic, copy)IBInspectable NSString * st_placeHolder;
/**
 占位符颜色
 */
@property (nonatomic, strong) UIColor * st_placeHolderColor;

/**
 占位Label
 */
@property (nonatomic, strong) UITextView * st_placeHolderLabel;

/**
 行间距
 */
@property (nonatomic, assign)IBInspectable CGFloat st_lineSpacing;
@property (nonatomic, strong) NSLayoutConstraint *heightConstraint;
@property (nonatomic, copy) NSString *layout_key;
@property (nonatomic, copy) void(^textViewHeightDidChangedHandle)(CGFloat textViewHeight);
@end
