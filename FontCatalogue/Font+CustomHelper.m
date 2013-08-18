//
//  Font+CustomHelper.m
//  FontCatalogue
//
//  Created by Antonio Rodrigues on 18/08/13.
//  Copyright (c) 2013 Antonio Rodrigues. All rights reserved.
//

#import "Font+CustomHelper.h"
#import "CoreDataManager.h"

@implementation Font (CustomHelper)

static int startOrder = 0;

- (id)initWithName:(NSString*)name{
    self = [NSEntityDescription insertNewObjectForEntityForName:@"Font" inManagedObjectContext:[[CoreDataManager sharedManager]managedObjectContext]];
    if (self) {
        self.name = name;
        self.order = [NSNumber numberWithInt:startOrder++];
    }
    return self;
}

- (NSString*)backwards {
    int len = [self.name length];
    NSMutableString *backwards = [[NSMutableString alloc] initWithCapacity:len];
    for(int i=len-1;i>=0;i--)
    {
        [backwards appendString:[NSString stringWithFormat:@"%c",[self.name characterAtIndex:i]]];
    }
    return backwards;
}

- (int)displaySize{
    return [self.name sizeWithFont:[UIFont systemFontOfSize:12.0f]].width;
}

- (int)characterCount{
    return self.name.length;
}

@end
