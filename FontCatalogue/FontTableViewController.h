//
//  FontTableViewController.h
//  FontCatalogue
//
//  Created by Antonio Rodrigues on 12/08/13.
//  Copyright (c) 2013 Antonio Rodrigues. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopoverView;

@interface FontTableViewController : UITableViewController  {
    PopoverView *pv;
    int textAlignment;
    BOOL backwards;
    
}


@property (nonatomic,retain) NSMutableArray* fontCatalogue;
@end
