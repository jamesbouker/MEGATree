//
//  MEGATree.h
//
//  Created by james bouker on 3/4/15.
//  Copyright (c) 2015 Jimmy Bouker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MEGAComparable.h"

@interface MEGATree : NSObject

@property (nonatomic, readonly) NSUInteger size;
@property (nonatomic, readonly) BOOL isEmpty;

-(void)push:(id<NSCopying, MEGAComparable>)key value:(id)value;
-(void)remove:(id<NSCopying, MEGAComparable>)key;
-(id)get:(id<NSCopying, MEGAComparable>)key;
-(BOOL)contains:(id<NSCopying, MEGAComparable>)key;
-(NSArray*)orderedArray;

@end
