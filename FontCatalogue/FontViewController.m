//
//  FontViewController.m
//  FontCatalogue
//
//  Created by Antonio Rodrigues on 18/08/13.
//  Copyright (c) 2013 Antonio Rodrigues. All rights reserved.
//

#import "FontViewController.h"
#import "FontView.h"
#import "Font.h"
#import "CoreDataManager.h"

#define maxFontSize 36.0f
#define minFontSize 8.0f
#define minRating 0
#define maxRating 5


@interface FontViewController () <FontViewDelegate>

@end

@implementation FontViewController

- (id)initWithFont:(Font *)font {
    self = [super init];
    if (self) {
        self.title = font.name;
        self.font = font;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //Create MenuView
    FontView* fontView = [[FontView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) andFontName:self.font.name];
    fontView.delegate = self;
    fontView.ratingTextField.text = [self.font.rating stringValue];
    fontView.frequencyLabel.text = [NSString stringWithFormat:@"%@ %@", @"Frequency:",self.font.frequency];
    [self.view addSubview:fontView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - FontViewDelegate methods

- (void)ratingPlusButtonPressed:(FontView*)fontView{
    int rating = [fontView.ratingTextField.text intValue];
    if (rating >= maxRating){
        return;
    } else {
        rating++;
        fontView.ratingTextField.text = [NSString stringWithFormat:@"%d",rating ];
    }
    self.font.rating = [NSNumber numberWithInt:rating];
    [[CoreDataManager sharedManager]saveContext];
}

- (void)ratingMinusButtonPressed:(FontView*)fontView{
    int rating = [fontView.ratingTextField.text intValue];
    if (rating <= minRating){
        return;
    } else {
        rating--;
        fontView.ratingTextField.text = [NSString stringWithFormat:@"%d",rating ];
    }
    self.font.rating = [NSNumber numberWithInt:rating];
    [[CoreDataManager sharedManager]saveContext];
}

- (void)fontSizePlusButtonPressed:(FontView*)fontView{
    int size = [fontView.fontSizeTextField.text intValue];
    if (size >= maxFontSize){
        return;
    } else {
        size++;
        fontView.fontSizeTextField.text = [NSString stringWithFormat:@"%d",size ];
    }

    fontView.fontDisplayLabel.font = [UIFont fontWithName:fontView.fontDisplayLabel.font.familyName size:[fontView.fontSizeTextField.text floatValue]];
    fontView.fontDisplayLabel.frame = CGRectMake(15, 95, self.view.frame.size.width - 15, 25);
    fontView.fontDisplayLabel.numberOfLines = 0;
    [fontView.fontDisplayLabel sizeToFit];
}

- (void)fontSizeMinusButtonPressed:(FontView*)fontView{
    int size = [fontView.fontSizeTextField.text intValue];
    if (size <= minFontSize){
        return;
    } else {
        size--;
        fontView.fontSizeTextField.text = [NSString stringWithFormat:@"%d",size ];
    }

    fontView.fontDisplayLabel.font = [UIFont fontWithName:fontView.fontDisplayLabel.font.familyName size:[fontView.fontSizeTextField.text floatValue]];
    fontView.fontDisplayLabel.frame = CGRectMake(15, 95, self.view.frame.size.width - 15, 25);
    fontView.fontDisplayLabel.numberOfLines = 0;
    [fontView.fontDisplayLabel sizeToFit];
}

@end
