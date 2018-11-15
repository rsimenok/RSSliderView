# RSSliderView
RSSliderView is a simple control for iOS based on UIView class.

Preview:

![A preview of this control](http://i.piccy.info/i9/afdcd8b5029e1f28b8bd33f7bd3822c1/1424118139/12622/780425/123.png)

## Create
RSSliderView is IBDesignable so you can create it in IB or programmatically as you prefer.

``` Objective-C
RSSliderView *horSlider = [[RSSliderView alloc] initWithFrame:CGRectMake(20, 40, 280, 70)];
horSlider.delegate = self;
horSlider.backgroundColor = [UIColor colorWithRed:27.0/255.0 green:28.0/255.0 blue:37.0/255.0 alpha:1.0];
horSlider.foregroundColor = [UIColor colorWithRed:0.0 green:106.0/255.0 blue:95.0/255.0 alpha:1.0];
horSlider.handleColor = [UIColor colorWithRed:0.0 green:205.0/255.0 blue:184.0/255.0 alpha:1.0];
horSlider.borderColor = [UIColor colorWithRed:0.0 green:205.0/255.0 blue:184.0/255.0 alpha:1.0];    
horSlider.text = @"Horizontal slider";
horSlider.textColor = [UIColor colorWithRed:0.0 green:205.0/255.0 blue:184.0/255.0 alpha:1.0];
[self.view addSubview:horSlider];
```

Observe slider value change via delegate
``` Objective-C
- (void)sliderWillChangeValue:(RSSliderView *)sender;
- (void)sliderDidChangeValue:(RSSliderView *)sender;
```

## Customize Appearance
``` Objective-C
@property (nonatomic, strong) IBInspectable UIColor *backgroundColor;
@property (nonatomic, strong) IBInspectable UIColor *foregroundColor;
@property (nonatomic, strong) IBInspectable UIColor *handleColor;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic, strong) IBInspectable UIColor *textColor;
@property (nonatomic, strong) IBInspectable NSString *text;
@property (nonatomic, strong) IBInspectable UIFont *font;
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable CGFloat handleWidth;
@property (nonatomic, assign) IBInspectable CGFloat onTapAnimationSpeed;
@property (nonatomic, assign, getter=isHandleHidden) IBInspectable BOOL handleHidden;
@property (nonatomic, assign) RSSliderViewOrientation orientation;
```

## License
RSSliderView is licensed under the terms of the MIT license. Please see the [LICENSE](LICENSE) file for full details.
