//
//  MEGANode.m
//
//  Created by james bouker on 3/4/15.
//  Copyright (c) 2015 Jimmy Bouker. All rights reserved.
//

#import "MEGANode.h"

#pragma mark - Local Method Stubs

@interface MEGANode (Local)

+(MEGANode*)recover:(MEGANode*)node;
+(MEGANode*)successor:(MEGANode*)node;
+(MEGANode*)rebalance:(MEGANode*)node;
+(BOOL)isBalanced:(MEGANode*)node;
+(NSInteger)balanceFactor:(MEGANode*)node;
+(MEGANode*)rotateRight:(MEGANode*)node;
+(MEGANode*)rotateLeft:(MEGANode*)node;
+(NSInteger)height:(MEGANode*)node;
+(NSInteger)recalcHeight:(MEGANode*)node;
+(NSInteger)size:(MEGANode *)node;
+(NSInteger)recalcSize:(MEGANode *)node;

@end

#pragma mark - Public Method Implementations

@implementation MEGANode

-(instancetype)initWithKey:(id<NSCopying, MEGAComparable>)key value:(id)value {
    self = [super init];
    if(self) {
        self.key = key;
        self.value = value;
        
        self.left = nil;
        self.right = nil;
        self.height = 1;
        self.size = 1;
    }
    return self;
}

+(MEGANode*)push:(id<NSCopying, MEGAComparable>)key value:(id)value root:(MEGANode*)node {
    if(node == nil) {
        //Inform the AVLTree
        return [[MEGANode alloc] initWithKey:key value:value];
    }
    
    NSComparisonResult diff = [key compare:node.key];
    if(diff < 0)        node.left = [MEGANode push:key value:value root:node.left];
    else if(diff > 0)   node.right = [MEGANode push:key value:value root:node.right];
    else {
        
        //Overwrite the data
        node.value = value;
        return node;
    }
    
    return [MEGANode recover:node];
}

+(MEGANode*)remove:(id<NSCopying, MEGAComparable>)key root:(MEGANode*)node {
    if(node == nil) return nil;
    
    NSComparisonResult diff = [key compare:node.key];
    if(diff < 0)
        node.left  = [MEGANode remove:key root:node.left];
    else if(diff > 0)
        node.right = [MEGANode remove:key root:node.right];
    else {
        //Less than 2 children
        if(node.left == nil || node.right == nil) {
            node = node.left != nil? node.left : node.right;
            if(node == nil) return nil;
        }
        
        //Both children still alive.... FOR NOW!
        else {
            //find successor: 1. copy data in 2. delete original successor
            MEGANode *successor = [MEGANode successor:node];
            node.key = successor.key;
            node.value = successor.value;
            node.right = [MEGANode remove:successor.key root:node.right];
        }
    }
    
    return [MEGANode recover:node];
}

+(id)get:(id<NSCopying, MEGAComparable>)key root:(MEGANode*)node {
    if(node == nil)     return nil;
    
    NSComparisonResult diff = [key compare:node.key];
    if(diff < 0)        return [MEGANode get:key root:node.left];
    else if(diff > 0)   return [MEGANode get:key root:node.right];
    else                return node.value;
}

+(BOOL)contains:(id<NSCopying, MEGAComparable>)key root:(MEGANode*)node {
    if(node == nil)     return NO;
    
    NSComparisonResult diff = [key compare:node.key];
    if(diff < 0)        return [MEGANode contains:key root:node.left];
    else if(diff > 0)   return [MEGANode contains:key root:node.right];
    else                return YES;
}

+(void)orderedArray:(NSMutableArray*)array node:(MEGANode*)node {
    if(node == nil) return;
    
    [MEGANode orderedArray:array node:node.left];
    [array addObject:@{@"key" : node.key, @"value" : node.value}];
//    [array addObject:node.key];
    [MEGANode orderedArray:array node:node.right];
}

@end

#pragma mark - Local Method Implementations

@implementation MEGANode (Local)

+(MEGANode*)recover:(MEGANode*)node {
    node.height = [MEGANode recalcHeight:node];
    node.size = [MEGANode recalcSize:node];
    return [MEGANode rebalance:node];
}

+(MEGANode*)successor:(MEGANode *)node {
    if(node == nil || node.right == nil) return nil;
    node = node.right;
    while(node.left != nil)
        node = node.left;
    return node;
}

+(MEGANode*)rebalance:(MEGANode*)node {
    if([MEGANode isBalanced:node]) return node;
    
    // ~~Balance that node, Balance it anyway~~
    NSInteger bF = [MEGANode balanceFactor:node];
    if(bF > 1) {
        if(node.left != nil && [MEGANode balanceFactor:node.left] < 0)
            node.left = [MEGANode rotateLeft:node.left];
        return [MEGANode rotateRight:node];
    }
    else {
        if(node.right != nil && [MEGANode balanceFactor:node.right] > 0)
            node.right = [MEGANode rotateRight:node.right];
        return [MEGANode rotateLeft:node];
    }
}

+(BOOL)isBalanced:(MEGANode *)node {
    if(node == nil) return YES;
    NSInteger bF = [MEGANode balanceFactor:node];
    if(bF < -1 || bF > 1) return NO;
    return YES;
}

+(NSInteger)balanceFactor:(MEGANode*)node {
    if(node == nil) return 0;
    return [MEGANode height:node.left] - [MEGANode height:node.right];
}

+(MEGANode*)rotateLeft:(MEGANode *)x {
    MEGANode * y = x.right;
    NSAssert(y != nil, @"Right node nil: Attempted to Left Right");
    
    //swap pointers
    MEGANode *temp = y.left;
    y.left = x;
    x.right = temp;
    
    //update heights
    x.height = [MEGANode recalcHeight:x];
    y.height = [MEGANode recalcHeight:y];
    
    return y;
}

+(MEGANode*)rotateRight:(MEGANode *)y {
    MEGANode *x = y.left;
    NSAssert(x != nil, @"Left node nil: Attempted to Rotate Right");

    //swap pointers
    MEGANode *temp = x.right;
    x.right = y;
    y.left = temp;
    
    //update heights
    y.height = [MEGANode recalcHeight:y];
    x.height = [MEGANode recalcHeight:x];
    
    return x;
}

+(NSInteger)height:(MEGANode *)node {
    if(node == nil) return 0;
    return node.height;
}

+(NSInteger)recalcHeight:(MEGANode *)node {
    if(node == nil) return 0;
    return MAX([MEGANode height:node.left], [MEGANode height:node.right]) + 1;
}

+(NSInteger)size:(MEGANode *)node {
    if(node == nil) return 0;
    return node.size;
}

+(NSInteger)recalcSize:(MEGANode *)node {
    if(node == nil) return 0;
    return [MEGANode size:node.left] + [MEGANode size:node.right] + 1;
}

@end
