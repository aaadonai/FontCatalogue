//
//  Font.m
//  FontCatalogue
//
//  Created by Antonio Rodrigues on 15/08/13.
//  Copyright (c) 2013 Antonio Rodrigues. All rights reserved.
//

#import "Font.h"

@implementation Font

- (id)initWithName:(NSString*)name{
    self = [super init];
    if (self) {
        self.name = name;
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
