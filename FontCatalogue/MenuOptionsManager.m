//
//  MenuOptionsManager.m
//  FontCatalogue
//
//  Created by Antonio Rodrigues on 18/08/13.
//  Copyright (c) 2013 Antonio Rodrigues. All rights reserved.
//

#import "MenuOptionsManager.h"

#define kAlignmentString @"alignment"
#define kBackwardsString @"backwards"
#define kSortString @"sort"
#define kReverseString @"reverse"

@interface MenuOptionsManager(){
    NSString* path;
    NSMutableDictionary *menuOptions;
}
@end

@implementation MenuOptionsManager

#pragma mark Singleton Methods

+ (id)sharedManager {
    static MenuOptionsManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}


- (void)createDocument{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    path = [documentsDirectory stringByAppendingPathComponent:@"MenuOptions.plist"]; 
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]) 
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"MenuOptions" ofType:@"plist"]; 
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error]; 
    }
}

- (void)readDocument{
    menuOptions = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    _alignment = [[menuOptions objectForKey:kAlignmentString] intValue];
    _backwards = [[menuOptions objectForKey:kBackwardsString] boolValue];
    _sort = [[menuOptions objectForKey:kSortString] intValue];
    _reverse = [[menuOptions objectForKey:kReverseString] boolValue];
    
}

- (void)writeDocument{
    menuOptions = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    [menuOptions setObject:[NSNumber numberWithInt:_alignment] forKey:kAlignmentString];
    [menuOptions setObject:[NSNumber numberWithBool:_backwards] forKey:kBackwardsString];
    [menuOptions setObject:[NSNumber numberWithInt:_sort] forKey:kSortString];
    [menuOptions setObject:[NSNumber numberWithBool:_reverse] forKey:kReverseString];
    
    [menuOptions writeToFile: path atomically:YES];
    
}

- (NSDictionary*)menuOptionsDictionary{
    return menuOptions;
}

- (void)setAlignment:(int)alignment{
    _alignment = alignment;
}

- (void)setBackwards:(BOOL)backwards{
    _backwards = backwards;
}

- (void)setSort:(int)sort{
    _sort = sort;
}

- (void)setReverse:(BOOL)reverse{
    _reverse = reverse;
}


@end
