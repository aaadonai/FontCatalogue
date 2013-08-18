//
//  FontView.h
//  FontCatalogue
//
//  Created by Antonio Rodrigues on 18/08/13.
//  Copyright (c) 2013 Antonio Rodrigues. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FontViewDelegate;

@interface FontView : UIView

@property (nonatomic, retain) UILabel *fontDisplayLabel;
@property (nonatomic, retain) UITextField *fontSizeTextField;
@property (nonatomic, retain) UITextField *ratingTextField;
@property (nonatomic, retain) UILabel *frequencyLabel;
@property (nonatomic, assign) id<FontViewDelegate>delegate;

- (id)initWithFrame:(CGRect)frame andFontName:(NSString*)name;

@end

@protocol FontViewDelegate <NSObject>

- (void)ratingPlusButtonPressed:(FontView*)fontView;
- (void)ratingMinusButtonPressed:(FontView*)fontView;
- (void)fontSizePlusButtonPressed:(FontView*)fontView;
- (void)fontSizeMinusButtonPressed:(FontView*)fontView;

@end
