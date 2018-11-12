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

- (void)sliderValueWillChange:(RSSliderView *)sender;
- (void)sliderValueDidChange:(RSSliderView *)sender;

@end

@interface RSSliderView : UIView

@property (nonatomic, strong) UIColor *foregroundColor;
@property (nonatomic, strong) UIColor *handleColor;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, strong) UIColor *textColor;

/**
 Text in middle of the slider.
 */
@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) UIFont *font;

/**
 Corner raduis, 5.0 by default. Changes affects on handle corners.
 */
@property (nonatomic, assign) CGFloat cornerRadius;

/**
 2.0 by default.
 */
@property (nonatomic, assign) CGFloat borderWidth;

/**
 No by default.
 */
@property (nonatomic, assign, getter=isHandleHidden) BOOL handleHidden;

/**
 Calculates from width and height automatically, but can be changed after init.
 */
@property (nonatomic, assign) RSSliderViewOrientation orientation;

@property (nonatomic, assign) float value;

@property (nonatomic, weak) id <RSSliderViewDelegate> delegate;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (void)setValue:(float)value;
- (void)setValue:(float)value withAnimation:(bool)animate;
- (void)setValue:(float)value withAnimation:(bool)animate completion:(void (^)(BOOL finished))completion;


@end
