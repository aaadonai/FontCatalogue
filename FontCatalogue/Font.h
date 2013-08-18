//
//  Font.h
//  FontCatalogue
//
//  Created by Antonio Rodrigues on 15/08/13.
//  Copyright (c) 2013 Antonio Rodrigues. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Font : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) int characterCount;
@property (nonatomic, assign) int displaySize;


- (id)initWithName:(NSString*)name;
- (NSString*)backwards;
- (int)displaySize;
- (int)characterCount;

@end
