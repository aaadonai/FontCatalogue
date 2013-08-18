//
//  FontView.m
//  FontCatalogue
//
//  Created by Antonio Rodrigues on 18/08/13.
//  Copyright (c) 2013 Antonio Rodrigues. All rights reserved.
//

#import "FontView.h"
#import "Font.h"


@interface FontView () {
    UIButton *ratingPlusButton;
    UIButton *ratingMinusButton;
    UIButton *fontSizePlusButton;
    UIButton *fontSizeMinusButton;
}

@end

@implementation FontView

- (id)initWithFrame:(CGRect)frame andFontName:(NSString*)name
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //adding rating label
        UILabel *ratingLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 100, 25)];
        ratingLabel.text = @"Rating:";
        [self addSubview:ratingLabel];
        
        //adding subtract rating button
        ratingMinusButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        ratingMinusButton.frame = CGRectMake(120,5,30,30);
        
        [ratingMinusButton setTitle:@"-" forState:UIControlStateNormal];
        [ratingMinusButton addTarget:self action:@selector(ratingMinusButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:ratingMinusButton];
        
        //adding rating field
        self.ratingTextField = [[UITextField alloc]init];
        self.ratingTextField.frame = CGRectMake(150, 5, 30, 30);
        self.ratingTextField.enabled = NO;
        self.ratingTextField.text = @"0";
        self.ratingTextField.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.ratingTextField];
        
        
        //adding add rating buttom
        ratingPlusButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        ratingPlusButton.frame = CGRectMake(180,5,30,30);
        
        [ratingPlusButton setTitle:@"+" forState:UIControlStateNormal];
        [ratingPlusButton addTarget:self action:@selector(ratingPlusButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:ratingPlusButton];
        
        //adding font size label
        UILabel *sizeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 35, 100, 25)];
        sizeLabel.text = @"Font size:";
        [self addSubview:sizeLabel];

        //adding subtract font size button
        fontSizeMinusButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        fontSizeMinusButton.frame = CGRectMake(120,40,30,30);
        
        [fontSizeMinusButton setTitle:@"-" forState:UIControlStateNormal];
        [fontSizeMinusButton addTarget:self action:@selector(fontSizeMinusButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:fontSizeMinusButton];
        
        //adding font size field
        self.fontSizeTextField = [[UITextField alloc]init];
        self.fontSizeTextField.frame = CGRectMake(150, 40, 30, 30);
        self.fontSizeTextField.enabled = NO;
        self.fontSizeTextField.text = @"8";
        self.fontSizeTextField.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.fontSizeTextField];
        
        
        //adding add font size buttom
        fontSizePlusButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        fontSizePlusButton.frame = CGRectMake(180,40,30,30);
        
        [fontSizePlusButton setTitle:@"+" forState:UIControlStateNormal];
        [fontSizePlusButton addTarget:self action:@selector(fontSizePlusButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:fontSizePlusButton];
        
        //Adding Frequency label
        self.frequencyLabel = [[UILabel alloc] init];
        self.frequencyLabel.frame = CGRectMake(15, 65, 120, 25);
        self.frequencyLabel.text = [NSString stringWithFormat:@"%@ %d", @"Frequency:",0];
        self.frequencyLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.frequencyLabel];
               
        //adding alphabet display label 
        self.fontDisplayLabel = [[UILabel alloc] init];
        self.fontDisplayLabel.frame = CGRectMake(15, 95, self.frame.size.width - 15, 25);
        self.fontDisplayLabel.text = @"abcdefghijklmnopqrstuvxyz";
        self.fontDisplayLabel.font = [UIFont fontWithName:name size:8.0f];
        self.fontDisplayLabel.numberOfLines = 0;
        [self.fontDisplayLabel sizeToFit];
        self.fontDisplayLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.fontDisplayLabel];

    }
    return self;
}

- (void)ratingPlusButtonPressed:(id)sender{
    [self.delegate ratingPlusButtonPressed:self];
}

- (void)ratingMinusButtonPressed:(id)sender{
    [self.delegate ratingMinusButtonPressed:self];
}

- (void)fontSizePlusButtonPressed:(id)sender{
    [self.delegate fontSizePlusButtonPressed:self];
}

- (void)fontSizeMinusButtonPressed:(id)sender{
    [self.delegate fontSizeMinusButtonPressed:self];
}

@end
