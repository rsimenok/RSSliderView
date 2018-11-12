//
//  ViewController.m
//  RSSliderViewExample
//
//  Created by Roman Simenok on 16.02.15.
//  Copyright (c) 2015 Roman Simenok. All rights reserved.
//

#import "ViewController.h"
#import "RSSliderView.h"

@interface ViewController () <RSSliderViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    RSSliderView *horSlider = [[RSSliderView alloc] initWithFrame:CGRectMake(20, 40, 280, 70)];
    horSlider.delegate = self;
    horSlider.backgroundColor = [UIColor colorWithRed:27.0/255.0 green:28.0/255.0 blue:37.0/255.0 alpha:1.0];
    horSlider.foregroundColor = [UIColor colorWithRed:0.0 green:106.0/255.0 blue:95.0/255.0 alpha:1.0];
    horSlider.handleColor = [UIColor colorWithRed:0.0 green:205.0/255.0 blue:184.0/255.0 alpha:1.0];
    horSlider.borderColor = [UIColor colorWithRed:0.0 green:205.0/255.0 blue:184.0/255.0 alpha:1.0];
    horSlider.text = @"Horizontal slider";
    
    horSlider.textColor = [UIColor colorWithRed:0.0 green:205.0/255.0 blue:184.0/255.0 alpha:1.0];
    [self.view addSubview:horSlider];
    
    RSSliderView *vertSlider = [[RSSliderView alloc] initWithFrame:CGRectMake(150, 200, 80, 300)];
    vertSlider.delegate = self;
    vertSlider.backgroundColor = [UIColor colorWithRed:37.0/255.0 green:46.0/255.0 blue:38.0/255.0 alpha:1.0];
    vertSlider.foregroundColor = [UIColor colorWithRed:32.0/255.0 green:86.0/255.0 blue:0.0 alpha:1.0];
    vertSlider.handleColor = [UIColor colorWithRed:128.0/255.0 green:209.0/255.0 blue:79.0/255.0 alpha:1.0];
    vertSlider.borderColor = [UIColor colorWithRed:128.0/255.0 green:209.0/255.0 blue:79.0/255.0 alpha:1.0];
    
    // Coment code below if you donn't need text on you slider
    vertSlider.text = @"Vertical slider";
    vertSlider.textColor = [UIColor colorWithRed:128.0/255.0 green:209.0/255.0 blue:79.0/255.0 alpha:1.0];
    [self.view addSubview:vertSlider];
}

- (void)sliderValueChanged:(RSSliderView *)sender {
    NSLog(@"Value Changed: %f", sender.value);
}

- (void)sliderValueChangeEnded:(RSSliderView *)sender {
    NSLog(@"Touсh ended: %f", sender.value);
}

@end
