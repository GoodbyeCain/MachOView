//
//  MachOLayout+Compare.m
//  MachOView
//
//  Created by saycain on 2024/4/16.
//

#import "MachOLayout+Compare.h"

@implementation MachOLayout (Compare)

- (void)compareWithLayout:(MachOLayout *) other 
{
    if(other == nil)
    {
        NSLog(@"Summary use  MachOLayout result failed, %@", @"other layout not exist");
        return ;
    }
    
    NSSet *lSymbols = [NSSet setWithArray:self.symbolList];
    NSSet *rSymbols = [NSSet setWithArray:other.symbolList];
    
    NSMutableSet *lInte = lSymbols.mutableCopy;
    [lInte intersectSet:rSymbols];
    
    NSMutableSet *rInte = rSymbols.mutableCopy;
    [rInte intersectSet:lSymbols];
    
    float lPercent = lInte.count / ((float)(lSymbols.count > 0 ? lSymbols.count : 1));
    float rPercent = rInte.count / ((float)(rSymbols.count > 0 ? rSymbols.count : 1));
    
    NSLog(@"Summary use  MachOLayout result");
    NSLog(@"Left  symbol count:%@ intersection count: %@ percent: %.3f", @(lSymbols.count), @(lInte.count), lPercent);
    NSLog(@"Right symbol count:%@ intersection count: %@ percent: %.3f", @(rSymbols.count), @(rInte.count), rPercent);
    
}

@end
