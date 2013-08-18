//
//  MenuView.h
//  FontCatalogue
//
//  Created by Antonio Rodrigues on 13/08/13.
//  Copyright (c) 2013 Antonio Rodrigues. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kAlignmentOptionLeft 0
#define kAlignmentOptionRight 1

@protocol MenuViewDelegate;

@interface MenuView : UIView

@property (nonatomic, assign) id<MenuViewDelegate>delegate;

@property (nonatomic, retain) UISegmentedControl *alignmentSegmentedControl;
@property (nonatomic, retain) UISwitch *backwards;
@property (nonatomic, retain) UISegmentedControl *sortSegmentedControl;
@property (nonatomic, retain) UISwitch *reverseSort;

- (void)reset;

@end

@protocol MenuViewDelegate <NSObject>

- (void)menuViewRevertBtnPressed:(MenuView*)menuView;
- (void)menuViewEditBtnPressed:(MenuView*)menuView;
- (void)menuViewAlignBtnPressed:(MenuView*)menuView;
- (void)menuViewBackwardsBtnPressed:(MenuView*)menuView;
- (void)menuViewSortBtnPressed:(MenuView*)menuView;

@end

