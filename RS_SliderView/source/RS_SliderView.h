//
//  RS_SliderView.h
//  RS_SliderView
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

#define handleWidth 14.0 // handle width
#define borderWidth 2.0 // size of border under the slider
#define viewCornerRadius 5.0 // view corners radius
#define animationSpeed 0.1 // speed when slider change position on tap

#import <UIKit/UIKit.h>

@class RS_SliderView;

typedef enum{
    Vertical,
    Horizontal
} Orientation;

@protocol RSliderViewDelegate <NSObject>

@optional

-(void)sliderValueChanged:(RS_SliderView *)sender; // calls when user is swiping slider
-(void)sliderValueChangeEnded:(RS_SliderView *)sender; // calls when user touchUpInside or toucUpOutside slider

@end

@interface RS_SliderView : UIView {
    BOOL isHandleHidden;
}

@property (nonatomic, strong) UIView *foregroundView;
@property (nonatomic, strong) UIView *handleView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) float value;

@property (nonatomic, weak) id <RSliderViewDelegate> delegate;

@property (nonatomic, assign) Orientation orientation;

-(void)setValue:(float)value withAnimation:(bool)isAnimate completion:(void (^)(BOOL finished))completion;
-(void)setColorsForBackground:(UIColor *)bCol foreground:(UIColor *)fCol handle:(UIColor *)hCol border:(UIColor *)brdrCol;
-(void)removeRoundCorners:(BOOL)corners removeBorder:(BOOL)border;
-(void)hideHandle;

-(id)initWithFrame:(CGRect)frame andOrientation:(Orientation)orientation;

@end
