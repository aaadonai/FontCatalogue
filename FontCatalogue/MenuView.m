//
//  MenuView.m
//  FontCatalogue
//
//  Created by Antonio Rodrigues on 13/08/13.
//  Copyright (c) 2013 Antonio Rodrigues. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //Adding revert button
        UIButton *revertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        revertButton.frame = CGRectMake(10,5,60,25);
        
        DLog(@"button frame: %@", NSStringFromCGRect(revertButton.frame) );
        [revertButton setTitle:@"Revert" forState:UIControlStateNormal];
        [revertButton addTarget:self action:@selector(revert:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:revertButton];
        
        //Adding Edit button
        UIButton *editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        editButton.frame = CGRectMake(80,5,60,25);
        
        DLog(@"button frame: %@", NSStringFromCGRect(editButton.frame) );
        [editButton setTitle:@"Edit" forState:UIControlStateNormal];
        [editButton addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:editButton];
        
        //Adding Alignment Segment Control
        UILabel *alignmentLabel = [[UILabel alloc] init];
        alignmentLabel.frame = CGRectMake(10, 35, 120, 25);
        alignmentLabel.text = @"Align";
        alignmentLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:alignmentLabel];
        NSArray *itemArray = [NSArray arrayWithObjects: @"Left", @"Right", nil];
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
        segmentedControl.frame = CGRectMake(15, 65, 120, 25);
        segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
        segmentedControl.selectedSegmentIndex = 0;
        [segmentedControl addTarget:self
                             action:@selector(align:)
                   forControlEvents:UIControlEventValueChanged];
        [self addSubview:segmentedControl];
        
        //Adding Backwards Switch
        UILabel *backwardsLabel = [[UILabel alloc] init];
        backwardsLabel.frame = CGRectMake(10, 95, 90, 25);
        backwardsLabel.text = @"Backwards";
        backwardsLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:backwardsLabel];

        UISwitch *backwards = [[UISwitch alloc] initWithFrame: CGRectMake(100,95,79,27)];
        [backwards addTarget: self action: @selector(backwards:) forControlEvents:UIControlEventValueChanged];
        [self addSubview: backwards];
        
        //Adding Sort Segment Control
        UILabel *sortLabel = [[UILabel alloc] init];
        sortLabel.frame = CGRectMake(10, 125, 120, 25);
        sortLabel.text = @"Align";
        sortLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:sortLabel];
        NSArray *sortArray = [NSArray arrayWithObjects: @"Alpha", @"Count", @"Size", nil];
        UISegmentedControl *sortSegmentedControl = [[UISegmentedControl alloc] initWithItems:sortArray];
        sortSegmentedControl.frame = CGRectMake(15, 155, 200, 25);
        sortSegmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
        sortSegmentedControl.selectedSegmentIndex = 0;
        [sortSegmentedControl addTarget:self
                             action:@selector(sort:)
                   forControlEvents:UIControlEventValueChanged];
        [self addSubview:sortSegmentedControl];

        //Adding Reverse Sort Switch
        UILabel *reverseLabel = [[UILabel alloc] init];
        reverseLabel.frame = CGRectMake(10, 185, 120, 25);
        reverseLabel.text = @"Reverse sort";
        reverseLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:reverseLabel];
        
        UISwitch *reverseSort = [[UISwitch alloc] initWithFrame: CGRectMake(130,185,79,27)];
        [reverseSort addTarget: self action: @selector(reverse:) forControlEvents:UIControlEventValueChanged];
        [self addSubview: reverseSort];


    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)revert:(id)sender{
    DLog(@"revert pressed!");
    [self.delegate menuViewRevertBtnPressed:self];
}

- (void)edit:(id)sender{
    DLog(@"edit pressed!");
    [self.delegate menuViewEditBtnPressed:self];
}

- (void)align:(id)sender{
    DLog(@"align pressed!");
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    self.alignmentOption = [segmentedControl selectedSegmentIndex];
    [self.delegate menuViewAlignBtnPressed:self];
}

- (void)backwards:(id)sender{
    DLog(@"backwards pressed!");
    UISwitch *backwards = (UISwitch*)sender;
    self.backwardsSwitch = backwards.on;
    [self.delegate menuViewBackwardsBtnPressed:self];
}

- (void)sort:(id)sender{
    DLog(@"sort pressed!");
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    self.sortOption = [segmentedControl selectedSegmentIndex];
    [self.delegate menuViewSortBtnPressed:self];
}

- (void)reverse:(id)sender{
    DLog(@"reverse pressed!");
    UISwitch *reverse = (UISwitch*)sender;
    self.reverseSortSwitch = reverse.on;
    [self.delegate menuViewRevertBtnPressed:self];
}



@end
