//
//  Font.h
//  FontCatalogue
//
//  Created by Antonio Rodrigues on 18/08/13.
//  Copyright (c) 2013 Antonio Rodrigues. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Font : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSNumber * frequency;

@end
