//
//  MVTable+Compare.m
//  MachOView
//
//  Created by saycain on 2024/4/15.
//

#import "MVTable+Compare.h"
#import "MVNode+Compare.h"

@implementation MVTable (Compare)


- (void)compareStringLiterals:(MVTable *) otherTable resultModel:(CompareModel *) model
{
    NSMutableSet *selfLiterals = [self valueStrMutableSet];
    
    NSMutableSet *otherLiterals = [otherTable valueStrMutableSet];
    
    NSMutableSet *selfIntersectionResult = selfLiterals.mutableCopy;
    [selfIntersectionResult intersectSet:otherLiterals];
    
    NSMutableSet *otherLiteralsResult = otherLiterals.mutableCopy;
    [otherLiteralsResult intersectSet:selfLiterals];
    
    if(selfLiterals.count > 0 && otherLiterals.count > 0)
    {
        [model.lNode updateSimilar:selfIntersectionResult.count / (float) selfLiterals.count];
        [model.rNode updateSimilar:otherLiteralsResult.count / (float) otherLiterals.count];
        model.compared = YES;
        return;
    }

    NSLog(@"Compare failed %@", @"no row");
}

#pragma mark - Helper
- (NSMutableSet *)valueStrMutableSet
{
    NSMutableSet *selfLiterals = [NSMutableSet set];
    for (NSUInteger lIndex = 0; lIndex < self.rowCount; lIndex++) {
        NSString *valueStr = [self getRowToDisplay:lIndex].columns.valueStr;
        if(valueStr != nil) {
            [selfLiterals addObject:valueStr];
        }
    }
    return selfLiterals;
}

@end
