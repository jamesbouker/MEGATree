//
//  MEGATree.m
//
//  Created by james bouker on 3/4/15.
//  Copyright (c) 2015 Jimmy Bouker. All rights reserved.
//

#import "MEGATree.h"
#import "MEGANode.h"

@interface MEGATree ()
@property (nonatomic, strong) MEGANode *root;
@end

@implementation MEGATree

#pragma mark - Public Methods

-(void)push:(id<NSCopying, MEGAComparable>)key value:(id)value {
    if(value != nil)
        self.root = [MEGANode push:key value:value root:self.root];
    else
        [self remove:key];
}

-(void)remove:(id<NSCopying, MEGAComparable>)key {
    self.root = [MEGANode remove:key root:self.root];
}

-(id)get:(id<NSCopying, MEGAComparable>)key {
    return [MEGANode get:key root:self.root];
}

-(BOOL)contains:(id<NSCopying, MEGAComparable>)key {
    return [MEGANode contains:key root:self.root];
}

-(NSArray*)orderedArray {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.size];
    [MEGANode orderedArray:array node:self.root];
    return array;
}

-(BOOL)isEmpty {
    return _size == 0;
}


#pragma mark - AVLNodeDelegate Methods

-(void)removedNode  {
    if(_size == 0)
        NSLog(@"QTF");
    _size--;
}
-(void)addedNode    {
    _size++;
}

@end
