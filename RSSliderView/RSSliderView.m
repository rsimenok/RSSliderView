//
//  RSSliderView.m
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

#import "RSSliderView.h"

@interface RSSliderView()

/**
 Public property `value` works as get/set for this private property.
 */
@property (nonatomic, assign) CGFloat sliderValue;
@property (nonatomic, strong) UIView *foregroundView;
@property (nonatomic, strong) UIView *handleView;
@property (nonatomic, strong, readwrite) UILabel *textLabel;

@property (nonatomic, strong) UITouch *touchTracker;
@property (nonatomic, assign) CGPoint touchLastPoint;
@end

@implementation RSSliderView

@synthesize handleWidth = _handleWidth;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self mainInit];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self mainInit];
    }
    return self;
}

- (void)mainInit {
    self.foregroundView = [UIView new];
    self.handleView = [UIView new];
    self.handleView.layer.masksToBounds = YES;
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.foregroundView];
    [self addSubview:self.handleView];
    
    // Setup default appearance
    _handleWidth = 14.0;
    self.layer.borderWidth = 2.0;
    [self setCornerRadius:5.0];
    [self setHandleHidden:NO];
    
    self.onTapAnimationSpeed = 0.1;
    self.backgroundColor = [UIColor colorWithRed:27.0/255.0 green:28.0/255.0 blue:37.0/255.0 alpha:1.0];
    self.foregroundColor = [UIColor colorWithRed:0.0 green:106.0/255.0 blue:95.0/255.0 alpha:1.0];
    self.handleColor = [UIColor colorWithRed:0.0 green:205.0/255.0 blue:184.0/255.0 alpha:1.0];
    self.borderColor = [UIColor colorWithRed:0.0 green:205.0/255.0 blue:184.0/255.0 alpha:1.0];
    
    RSSliderViewOrientation orientation = self.frame.size.width > self.frame.size.height ? RSSliderViewOrientationHorizontal : RSSliderViewOrientationVertical;
    [self setOrientation:orientation];
}

#pragma mark - Get/Set

- (CGFloat)value {
    return self.sliderValue;
}

- (void)setValue:(CGFloat)value {
    [self setValue:value withAnimation:NO];
}

- (void)setValue:(CGFloat)value withAnimation:(BOOL)animate {
    [self setValue:value withAnimation:animate completion:nil];
}

- (void)setValue:(CGFloat)value withAnimation:(BOOL)animate completion:(void (^)(BOOL finished))completion {
    NSAssert((value >= 0.0) && (value <= 1.0), @"Value must be between 0 and 1");
    value = [self clampFloat:value min:0 max:1];
    CGPoint point = [self sliderValueToFrameValue:value];

    if (animate) {
        __weak __typeof(self) weakSelf = self;
        
        [UIView animateWithDuration:self.onTapAnimationSpeed animations:^ {
            [weakSelf changeStarForegroundViewWithPoint:point];
        } completion:^(BOOL finished) {
            if (completion) {
                completion(finished);
            }
        }];
    } else {
        [self changeStarForegroundViewWithPoint:point];
    }
}

- (void)setOrientation:(RSSliderViewOrientation)orientation {
    _orientation = orientation;
    
    switch (orientation) {
        case RSSliderViewOrientationVertical:
            [_textLabel setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
            break;
        case RSSliderViewOrientationHorizontal:
            [_textLabel setTransform:CGAffineTransformIdentity];
            break;
        default:
            break;
    }
    
    // update the UI
    [self setValue:self.value];
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.center = self.center;
        switch (self.orientation) {
            case RSSliderViewOrientationVertical:
                [_textLabel setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
                break;
            case RSSliderViewOrientationHorizontal:
                [self.textLabel setTransform:CGAffineTransformIdentity];
                break;
            default:
                break;
        }
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont fontWithName:@"Helvetica" size:24];
        [self insertSubview:_textLabel atIndex:1];
    }
    return _textLabel;
}

- (void)setForegroundColor:(UIColor *)foregroundColor {
    self.foregroundView.backgroundColor = foregroundColor;
}

- (UIColor *)foregroundColor {
    return self.foregroundView.backgroundColor;
}

- (void)setHandleColor:(UIColor *)handleColor {
    self.handleView.backgroundColor = handleColor;
}

- (UIColor *)handleColor {
    return self.handleView.backgroundColor;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setTextColor:(UIColor *)textColor {
    self.textLabel.textColor = textColor;
}

- (UIColor *)textColor {
    return self.textLabel.textColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.handleView.layer.cornerRadius = cornerRadius - 2;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setFont:(UIFont *)font {
    self.textLabel.font = font;
    
    [self updateTextLabelPosition];
}

- (UIFont *)font {
    return self.textLabel.font;
}

- (void)setText:(NSString *)text {
    self.textLabel.text = text;
    
    [self updateTextLabelPosition];
}

- (NSString *)text {
    return self.textLabel.text;
}

- (void)setHandleHidden:(BOOL)handleHidden {
    self.handleView.hidden = handleHidden;
}

- (BOOL)isHandleHidden {
    return self.handleView.hidden;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
    
    // update UI
    [self setValue:self.value];
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (void)setHandleWidth:(CGFloat)handleWidth {
    _handleWidth = handleWidth;
    
    // update UI
    [self setValue:self.value];
}

- (CGFloat)handleWidth {
    if (self.isHandleHidden) {
        return 0;
    } else {
        return _handleWidth;
    }
}

#pragma mark - Other Methods

- (void)updateTextLabelPosition {
    [self.textLabel sizeToFit];
    self.textLabel.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
}

#pragma mark - Touch Events

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_touchTracker) {
        _touchTracker = [touches anyObject];
        _touchLastPoint = [_touchTracker locationInView:self];
    }
    if ([touches containsObject:_touchTracker]) {
        CGPoint newPoint = [_touchTracker locationInView:self];
        CGPoint delta = (CGPoint) {newPoint.x - _touchLastPoint.x, newPoint.y - _touchLastPoint.y};
        _touchLastPoint = newPoint;

        if (delta.x != 0 || delta.y != 0) {
            CGPoint point;
            switch (self.behavior) {
                case RSSliderBehaviorRelativeDrag: {
                    point = [self sliderValueToFrameValue:_sliderValue];
                    point = (CGPoint){point.x + delta.x, point.y + delta.y};
                    break;
                }
                case RSSliderBehaviorAbsoluteTouch:
                default: {
                    point = newPoint;
                    break;
                }
            }
            if ([self.delegate respondsToSelector:@selector(sliderWillChangeValue:)]) {
                [self.delegate sliderWillChangeValue:self];
            }
            switch (self.orientation) {
                case RSSliderViewOrientationVertical:
                    [self changeStarForegroundViewWithPoint:point];
                    break;
                case RSSliderViewOrientationHorizontal:
                    [self changeStarForegroundViewWithPoint:point];
                    break;
            }
            if ([self.delegate respondsToSelector:@selector(sliderDidChangeValue:)]) {
                [self.delegate sliderDidChangeValue:self];
            }
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    if (_touchTracker && [touches containsObject:_touchTracker]) {

        CGPoint newPoint = [_touchTracker locationInView:self];
        _touchTracker = nil;

        CGPoint point;
        switch (self.behavior) {
            case RSSliderBehaviorRelativeDrag: {
                CGPoint delta = (CGPoint) {newPoint.x - _touchLastPoint.x, newPoint.y - _touchLastPoint.y};
                point = [self sliderValueToFrameValue:_sliderValue];
                point = (CGPoint){point.x + delta.x, point.y + delta.y};
                break;
            }
            case RSSliderBehaviorAbsoluteTouch:
            default: {
                point = newPoint;
                break;
            }
        }
        if ([self.delegate respondsToSelector:@selector(sliderWillChangeValue:)]) {
            [self.delegate sliderWillChangeValue:self];
        }
        __weak __typeof(self) weakSelf = self;
        [UIView animateWithDuration:self.onTapAnimationSpeed animations:^ {
            [weakSelf changeStarForegroundViewWithPoint:point];
        } completion:^(BOOL finished) {
            __strong __typeof(weakSelf) Self = weakSelf;
            if ([Self.delegate respondsToSelector:@selector(sliderDidChangeValue:)]) {
                [Self.delegate sliderDidChangeValue:Self];
            }
        }];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _touchTracker = nil;
}


#pragma mark - Helper functions

- (CGFloat)clampFloat:(CGFloat)value min:(CGFloat)min max:(CGFloat)max {
    return value < min ? min : value > max ? max : value;
}

- (CGPoint)clampPoint:(CGPoint)value min:(CGPoint)min max:(CGPoint)max {
    return (CGPoint){ [self clampFloat:value.x min:min.x max:max.x], [self clampFloat:value.y min:min.y max:max.y] };
}

- (CGPoint)sliderValueToFrameValue:(CGFloat)value {
	return (CGPoint){ value * (self.frame.size.width - self.handleWidth), (1 - value) * (self.frame.size.height - self.handleWidth) };
}
- (CGFloat)frameValueToSliderValue:(CGPoint)point {
    switch (self.orientation) {
        case RSSliderViewOrientationHorizontal: return [self clampFloat:point.x / (self.frame.size.width - self.handleWidth) min:0 max:1];
        case RSSliderViewOrientationVertical: return [self clampFloat:1 - (point.y / (self.frame.size.height - self.handleWidth)) min:0 max:1];
		default: return 0;
    }
}

#pragma mark - Change Slider Foreground With Point

- (void)changeStarForegroundViewWithPoint:(CGPoint)point {
    CGPoint p = point;
    
    switch (self.orientation) {
        case RSSliderViewOrientationVertical: {

            self.sliderValue = [self frameValueToSliderValue:p];
            p.y = [self clampFloat:p.y+self.handleWidth/2 min:self.handleWidth/2 max:self.frame.size.height - self.handleWidth/2];

            self.foregroundView.frame = CGRectMake(0,
                                                   self.frame.size.height,
                                                   self.frame.size.width,
                                                   p.y - self.frame.size.height);
            
            if (!self.isHandleHidden) {
                if (self.foregroundView.frame.origin.y <= 0) {
                    self.handleView.frame = CGRectMake(self.borderWidth,
                                                       0,
                                                       self.frame.size.width - self.borderWidth * 2,
                                                       self.handleWidth);
                } else if (self.foregroundView.frame.origin.y >= self.frame.size.height) {
                    self.handleView.frame = CGRectMake(self.borderWidth,
                                                       self.frame.size.height - self.handleWidth,
                                                       self.frame.size.width - self.borderWidth * 2,
                                                       self.handleWidth);
                } else {
                    self.handleView.frame = CGRectMake(self.borderWidth,
                                                       self.foregroundView.frame.origin.y - self.handleWidth / 2,
                                                       self.frame.size.width - self.borderWidth * 2,
                                                       self.handleWidth);
                }
            }
        }
            break;
        case RSSliderViewOrientationHorizontal: {

            self.sliderValue = [self frameValueToSliderValue:p];
            p.x = [self clampFloat:p.x+self.handleWidth/2 min:self.handleWidth/2 max:self.frame.size.width - self.handleWidth/2];

            self.foregroundView.frame = CGRectMake(0, 0, p.x, self.frame.size.height);
            
            if (!self.isHandleHidden) {
                if (self.foregroundView.frame.size.width <= 0) {
                    self.handleView.frame = CGRectMake(0,
                                                       self.borderWidth,
                                                       self.handleWidth,
                                                       self.foregroundView.frame.size.height-self.borderWidth);
                } else if (self.foregroundView.frame.size.width >= self.frame.size.width) {
                    self.handleView.frame = CGRectMake(self.foregroundView.frame.size.width - self.handleWidth,
                                                       self.borderWidth,
                                                       self.handleWidth,
                                                       self.foregroundView.frame.size.height - self.borderWidth * 2);
                } else {
                    self.handleView.frame = CGRectMake(self.foregroundView.frame.size.width - self.handleWidth / 2,
                                                       self.borderWidth,
                                                       self.handleWidth,
                                                       self.foregroundView.frame.size.height - self.borderWidth * 2);
                }
            }
        }
            break;
        default:
            break;
    }
}

@end
