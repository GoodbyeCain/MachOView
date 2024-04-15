//
//  CompareModel.h
//  MachOView
//
//  Created by saycain on 2024/4/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MVNode;
@interface CompareModel : NSObject
@property (nonatomic, strong) MVNode *lNode;
@property (nonatomic, strong) MVNode *rNode;

@property (nonatomic, assign) BOOL compared;
@property (nonatomic, assign) float similar;

- (instancetype)initWithLeftNode:(MVNode *) lNode rightNode:(MVNode *) rNode;
@end

NS_ASSUME_NONNULL_END
