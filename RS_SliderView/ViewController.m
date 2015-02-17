//
//  ViewController.m
//  RS_SliderView
//
//  Created by Roman Simenok on 16.02.15.
//  Copyright (c) 2015 Roman Simenok. All rights reserved.
//

#import "ViewController.h"
#import "RS_SliderView.h"

@interface ViewController () <RSliderViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    RS_SliderView *horSlider = [[RS_SliderView alloc] initWithFrame:CGRectMake(40, 40, 300, 80) andOrientation:Horizontal];
    horSlider.delegate = self;
    [horSlider setColorsForBackground:[UIColor colorWithRed:27.0/255.0 green:28.0/255.0 blue:37.0/255.0 alpha:1.0]
                           foreground:[UIColor colorWithRed:0.0 green:106.0/255.0 blue:95.0/255.0 alpha:1.0]
                               handle:[UIColor colorWithRed:0.0 green:205.0/255.0 blue:184.0/255.0 alpha:1.0]
                               border:[UIColor colorWithRed:0.0 green:205.0/255.0 blue:184.0/255.0 alpha:1.0]];
    horSlider.label.text = @"Horizontal slider";
    horSlider.label.font = [UIFont fontWithName:@"Helvetica" size:25];
    horSlider.label.textColor = [UIColor colorWithRed:0.0 green:205.0/255.0 blue:184.0/255.0 alpha:1.0];
    [self.view addSubview:horSlider];
    
    RS_SliderView *vertSlider = [[RS_SliderView alloc] initWithFrame:CGRectMake(150, 200, 80, 300) andOrientation:Vertical];
    vertSlider.delegate = self;
    [vertSlider setColorsForBackground:[UIColor colorWithRed:37.0/255.0 green:46.0/255.0 blue:38.0/255.0 alpha:1.0]
                            foreground:[UIColor colorWithRed:32.0/255.0 green:86.0/255.0 blue:0.0 alpha:1.0]
                                handle:[UIColor colorWithRed:128.0/255.0 green:209.0/255.0 blue:79.0/255.0 alpha:1.0]
                                border:[UIColor colorWithRed:128.0/255.0 green:209.0/255.0 blue:79.0/255.0 alpha:1.0]];
    vertSlider.label.text = @"Vertical slider";
    vertSlider.label.font = [UIFont fontWithName:@"Helvetica" size:25];
    vertSlider.label.textColor = [UIColor colorWithRed:128.0/255.0 green:209.0/255.0 blue:79.0/255.0 alpha:1.0];
    [self.view addSubview:vertSlider];
}

-(void)sliderView:(RS_SliderView *)view value:(float)value {
    // Slider value changed
    NSLog(@"Slider Value: %f", value);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
