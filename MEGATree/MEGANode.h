//
//  MEGANode.h
//
//  Created by james bouker on 3/4/15.
//  Copyright (c) 2015 Jimmy Bouker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MEGAComparable.h"

@protocol AVLNodeDelegate <NSObject>
-(void)removedNode;
-(void)addedNode;
@end

@interface MEGANode : NSObject

//Data
@property (nonatomic, copy) id<NSCopying, MEGAComparable> key;
@property (nonatomic, strong) id value;

//Bookkeeping
@property (nonatomic, assign) NSUInteger height;
@property (nonatomic, strong) MEGANode *left;
@property (nonatomic, strong) MEGANode *right;

-(instancetype)initWithKey:(id<NSCopying, MEGAComparable>)key value:(id)value;
+(MEGANode*)push:(id<NSCopying, MEGAComparable>)key value:(id)value root:(MEGANode*)node delegate:(id<AVLNodeDelegate>)delegate;
+(MEGANode*)remove:(id<NSCopying, MEGAComparable>)key root:(MEGANode*)node removed:(BOOL)hasRemoved delegate:(id<AVLNodeDelegate>)delegate;
+(BOOL)contains:(id<NSCopying, MEGAComparable>)key root:(MEGANode*)node;
+(void)orderedArray:(NSMutableArray*)array node:(MEGANode*)node;

@end