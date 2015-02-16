//
//  RS_SliderView.h
//  RS_SliderView
//
//  Created by Roman Simenok on 13.02.15.
//  Copyright (c) 2015 Roman Simenok. All rights reserved.
//

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

-(void)sliderView:(RS_SliderView *)view score:(float)score;

@end

@interface RS_SliderView : UIView

@property (nonatomic, strong) UIView *foregroundView;
@property (nonatomic, strong) UIView *handleView;
@property (nonatomic, strong) UILabel *label;

@property (nonatomic, weak) id <RSliderViewDelegate> delegate;

@property (nonatomic, assign) Orientation orientation;

-(void)setScore:(float)score withAnimation:(bool)isAnimate completion:(void (^)(BOOL finished))completion;
-(void)setColorsForBackground:(UIColor *)bCol foreground:(UIColor *)fCol handle:(UIColor *)hCol border:(UIColor *)brdrCol;

-(id)initWithFrame:(CGRect)frame andOrientation:(Orientation)orientation;

@end
