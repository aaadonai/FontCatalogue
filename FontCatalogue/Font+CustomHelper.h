//
//  Font+CustomHelper.h
//  FontCatalogue
//
//  Created by Antonio Rodrigues on 18/08/13.
//  Copyright (c) 2013 Antonio Rodrigues. All rights reserved.
//

#import "Font.h"

@interface Font (CustomHelper)

- (id)initWithName:(NSString*)name;
- (NSString*)backwards;
- (int)displaySize;
- (int)characterCount;

@end
