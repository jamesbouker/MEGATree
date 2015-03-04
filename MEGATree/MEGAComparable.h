//
//  MEGAComparable.h
//
//  Created by james bouker on 3/4/15.
//  Copyright (c) 2015 Jimmy Bouker. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MEGAComparable <NSObject>
- (NSComparisonResult)compare:(id<MEGAComparable>)object;
@end
