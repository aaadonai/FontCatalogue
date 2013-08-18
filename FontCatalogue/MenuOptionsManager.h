//
//  MenuOptionsManager.h
//  FontCatalogue
//
//  Created by Antonio Rodrigues on 18/08/13.
//  Copyright (c) 2013 Antonio Rodrigues. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuOptionsManager : NSObject


@property (nonatomic, assign, readonly) int alignment;
@property (nonatomic, assign, readonly) BOOL backwards;
@property (nonatomic, assign, readonly) int sort;
@property (nonatomic, assign, readonly) BOOL reverse;


+ (id) sharedManager;
- (NSDictionary*)menuOptionsDictionary;
- (void)createDocument;
- (void)readDocument;
- (void)writeDocument;
- (int)alignment;
- (BOOL)backwards;
- (int)sort;
- (BOOL)reverse;
- (void)setAlignment:(int)alignment;
- (void)setBackwards:(BOOL)backwards;
- (void)setSort:(int)sort;
- (void)setReverse:(BOOL)reverse;

@end
