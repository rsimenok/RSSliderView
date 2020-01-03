//
//  RSSliderView.h
//  RSSliderView
//
//  Created by Roman Simenok on 13.02.15.
//  Copyright (c) 2015 Roman Simenok. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <UIKit/UIKit.h>

@class RSSliderView;

typedef NS_ENUM(NSUInteger, RSSliderViewOrientation) {
    RSSliderViewOrientationVertical,
    RSSliderViewOrientationHorizontal
};

@protocol RSSliderViewDelegate <NSObject>

@optional
- (void)sliderWillChangeValue:(RSSliderView *)sender;
- (void)sliderDidChangeValue:(RSSliderView *)sender;

@end

IB_DESIGNABLE
@interface RSSliderView : UIView

@property (nonatomic, strong) IBInspectable UIColor *foregroundColor;
@property (nonatomic, strong) IBInspectable UIColor *handleColor;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic, strong) IBInspectable UIColor *textColor;

/**
 Text in middle of the slider.
 */
@property (nonatomic, strong) IBInspectable NSString *text;

@property (nonatomic, strong) IBInspectable UIFont *font;

/**
 Corner raduis, 5.0 by default. Changes affects on handle corners.
 */
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

/**
 2.0 by default.
 */
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

/**
 14.0 by default.
 */
@property (nonatomic, assign) IBInspectable CGFloat handleWidth;

/**
 Animation speed for On Tap Value Change.
 0.1 by default.
 */
@property (nonatomic, assign) IBInspectable CGFloat onTapAnimationSpeed;

/**
 No by default.
 */
@property (nonatomic, assign, getter=isHandleHidden) IBInspectable BOOL handleHidden;

/**
 Calculates from width and height automatically.
 */
@property (nonatomic, assign) RSSliderViewOrientation orientation;

@property (nonatomic, assign) IBInspectable CGFloat value;

@property (nonatomic, weak) IBOutlet id <RSSliderViewDelegate> delegate;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (void)setValue:(CGFloat)value withAnimation:(BOOL)animate;
- (void)setValue:(CGFloat)value withAnimation:(BOOL)animate completion:(void (^)(BOOL finished))completion;


@end
