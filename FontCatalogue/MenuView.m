//
//  MenuView.m
//  FontCatalogue
//
//  Created by Antonio Rodrigues on 13/08/13.
//  Copyright (c) 2013 Antonio Rodrigues. All rights reserved.
//

#import "MenuView.h"
#import "MenuOptionsManager.h"

@implementation MenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //Adding revert button
        UIButton *revertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        revertButton.frame = CGRectMake(10,5,60,25);
        
        [revertButton setTitle:@"Revert" forState:UIControlStateNormal];
        [revertButton addTarget:self action:@selector(revert:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:revertButton];
        
        //Adding Edit button
        UIButton *editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        editButton.frame = CGRectMake(80,5,60,25);
        
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
        self.alignmentSegmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
        self.alignmentSegmentedControl.frame = CGRectMake(15, 65, 120, 25);
        self.alignmentSegmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
        self.alignmentSegmentedControl.selectedSegmentIndex = 0;
        [self.alignmentSegmentedControl addTarget:self
                             action:@selector(align:)
                   forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.alignmentSegmentedControl];
        
        //Adding Backwards Switch
        UILabel *backwardsLabel = [[UILabel alloc] init];
        backwardsLabel.frame = CGRectMake(10, 95, 90, 25);
        backwardsLabel.text = @"Backwards";
        backwardsLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:backwardsLabel];

        self.backwards = [[UISwitch alloc] initWithFrame: CGRectMake(100,95,79,27)];
        [self.backwards addTarget: self action: @selector(backwards:) forControlEvents:UIControlEventValueChanged];
        [self addSubview: self.backwards];
        
        //Adding Sort Segment Control
        UILabel *sortLabel = [[UILabel alloc] init];
        sortLabel.frame = CGRectMake(10, 125, 120, 25);
        sortLabel.text = @"Sort by name";
        sortLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:sortLabel];
        NSArray *sortArray = [NSArray arrayWithObjects: @"Alpha", @"Count", @"Size", nil];
        self.sortSegmentedControl = [[UISegmentedControl alloc] initWithItems:sortArray];
        self.sortSegmentedControl.frame = CGRectMake(15, 155, 200, 25);
        self.sortSegmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
        self.sortSegmentedControl.selectedSegmentIndex = -1;//none are selected at start
        [self.sortSegmentedControl addTarget:self
                             action:@selector(sort:)
                   forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.sortSegmentedControl];

        //Adding Reverse Sort Switch
        UILabel *reverseLabel = [[UILabel alloc] init];
        reverseLabel.frame = CGRectMake(10, 185, 120, 25);
        reverseLabel.text = @"Reverse sort";
        reverseLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:reverseLabel];
        
        self.reverseSort = [[UISwitch alloc] initWithFrame: CGRectMake(130,185,79,27)];
        [self.reverseSort addTarget: self action: @selector(reverse:) forControlEvents:UIControlEventValueChanged];
        [self addSubview: self.reverseSort];

        //will load options saved on plist file
        [self loadMenuOptions];
    }
    return self;
}


#pragma mark - Custom methods

- (void)loadMenuOptions{
    MenuOptionsManager* manager = [MenuOptionsManager sharedManager];
    [manager readDocument];
    self.alignmentSegmentedControl.selectedSegmentIndex = manager.alignment;
    self.backwards.on = manager.backwards;
    self.sortSegmentedControl.selectedSegmentIndex = manager.sort;
    self.reverseSort.on = manager.reverse;
}


- (void)revert:(id)sender{
    [self.delegate menuViewRevertBtnPressed:self];
}

- (void)edit:(id)sender{
    [self.delegate menuViewEditBtnPressed:self];
}

- (void)align:(id)sender{
    [[MenuOptionsManager sharedManager]setAlignment:self.alignmentSegmentedControl.selectedSegmentIndex];
    [[MenuOptionsManager sharedManager]writeDocument];
    [self.delegate menuViewAlignBtnPressed:self];
}

- (void)backwards:(id)sender{
    [(MenuOptionsManager*)[MenuOptionsManager sharedManager]setBackwards:self.backwards.on];
    [[MenuOptionsManager sharedManager]writeDocument];
    [self.delegate menuViewBackwardsBtnPressed:self];
}

- (void)sort:(id)sender{
    [[MenuOptionsManager sharedManager]setSort:self.sortSegmentedControl.selectedSegmentIndex];
    [[MenuOptionsManager sharedManager]writeDocument];
    [self.delegate menuViewSortBtnPressed:self];
}

- (void)reverse:(id)sender{
    if (self.sortSegmentedControl.selectedSegmentIndex == -1){
        self.sortSegmentedControl.selectedSegmentIndex = 0;
    }
    [[MenuOptionsManager sharedManager]setReverse:self.reverseSort.on];
    [[MenuOptionsManager sharedManager]writeDocument];
    [self.delegate menuViewSortBtnPressed:self];
}

- (void)reset{
    self.alignmentSegmentedControl.selectedSegmentIndex = 0;
    self.backwards.on = NO;
    self.sortSegmentedControl.selectedSegmentIndex = -1;
    self.reverseSort.on = NO;
    [[MenuOptionsManager sharedManager]setAlignment:self.alignmentSegmentedControl.selectedSegmentIndex];
    [(MenuOptionsManager*)[MenuOptionsManager sharedManager]setBackwards:self.backwards.on];
    [[MenuOptionsManager sharedManager]setSort:self.sortSegmentedControl.selectedSegmentIndex];
    [[MenuOptionsManager sharedManager]setReverse:self.reverseSort.on];
    [[MenuOptionsManager sharedManager]writeDocument];
 }



@end
