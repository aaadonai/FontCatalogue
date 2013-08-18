//
//  FontViewController.h
//  FontCatalogue
//
//  Created by Antonio Rodrigues on 18/08/13.
//  Copyright (c) 2013 Antonio Rodrigues. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Font;

@interface FontViewController : UIViewController

@property (retain, nonatomic) Font* font;

- (id)initWithFont:(Font *)font;

@end
