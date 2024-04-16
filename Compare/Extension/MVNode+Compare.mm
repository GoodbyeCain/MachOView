//
//  MVNode+Compare.m
//  MachOView
//
//  Created by saycain on 2024/4/15.
//

#import "MVNode+Compare.h"
#import "MVTable+Compare.h"

@implementation MVNode (Compare)

- (BOOL)needCompared
{
    static NSArray <NSString *>* needComparedCaptionNames = @[
        @"C String Literals",
        @"U String Literals"
    ];
    if([needComparedCaptionNames containsObject:self.caption])
    {
        return YES;
    }
    return  NO;
}


- (CompareModel *)compareWithNode:(MVNode *) other {
    CompareModel *result = [[CompareModel alloc] initWithLeftNode:self rightNode:other];
    NSLog(@"Compare node: %@ childCount: %@", other.caption, @(self->children.count));
    if(self->children.count > 1 && other->children.count > 1) 
    {
        return  result;
    }
    else if(self->children.count == 1 && other->children.count == 1)
    {
        MVNode *leftChild = self->children[0];
        MVNode *rightChild = other->children[0];
        if([leftChild needCompared]) {
            MVTable *leftDetail = [leftChild getDetails];
            MVTable *rightDetail = [rightChild getDetails];
            [leftDetail compareStringLiterals:rightDetail resultModel:result];
            NSLog(@"Compare %@ %@", self.caption, leftChild.caption);
            NSLog(@"\t left count:%@ right count: %@ similar: %@", @(leftDetail.rowCount), @(rightDetail.rowCount), @(result.similar));
        }
        return result;
    }
    else 
    {
        return result;
    }
}

- (MVTable * )getDetails
{
    if (self.detailsOffset != 0)
    {
      [self closeDetails];
    }
    
    [self openDetails];
    [self filterDetails:nil];
    return details;
}

- (void)updateSimilar:(float) similar
{
    self.similar = similar;
    self.similarInfo = [NSString stringWithFormat:@"%.2f", similar];
}

@end
