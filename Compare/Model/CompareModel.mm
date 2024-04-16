//
//  CompareModel.m
//  MachOView
//
//  Created by saycain on 2024/4/15.
//

#import "CompareModel.h"
#import "DataController.h"

@implementation CompareModel

- (instancetype)initWithLeftNode:(MVNode *) lNode rightNode:(MVNode *) rNode
{
    self = [super init];
    if(self) {
        _lNode = lNode;
        _rNode = rNode;
        _similar = 0;
        _compared = FALSE;
    }
    return self;
}

- (NSString *)description
{
    if(_lNode.allChildren.count == 1 && _rNode.allChildren.count == 1) 
    {
        MVNode *child = _lNode.allChildren[0];
        return [NSString stringWithFormat:@"%@ %@ left intersection percent: %.2f right intersection percent %.2f",
                _lNode.caption,
                child.caption,
                _lNode.similar,
                _rNode.similar];
    }
    
    return [NSString stringWithFormat:@"%@ similar: %.2f", _lNode.caption, _similar];
}

@end
